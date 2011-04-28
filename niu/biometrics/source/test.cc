/****************************************************************************
 * Things to note:  White pixel = 255, black pixel is 0
 *		OTSU algorithm works in a very idealistic case, a local binarization
 *		algorithm should be implemented at some point for best results
 *
 *		the command line parameters are fluky.  It works fine on my linux 
 *		machine, but has issues on erie.
 *	
 *	Also, please see the read me file. 
 *	 	I included a Open Office version and a Word Document version
*****************************************************************************/
#include <tiffio.h>
#include <math.h>
#include <iostream>
#include <cstdlib>
#include "myheader.h"
using namespace std;


// image processing methods:
void write_image(TIFF *);
size_t  read_image(TIFF*);
// binarization methods:
void binary(size_t, int);
double CalcSigma(int[], int, int);
int Optimize(int npixels);
// skeletanization (thinning) methods:
void thinning();
int Xh(int );
int bi(int [], int );
void call_test(int );


u_char * raster;    // array which holds all pixels in image
uint32 w, h;        // unsigned into holding the width and height of image
bool * hild;		// bool array which tracks checked pixels using hilditch algo.
field_data attr;   // struct which retrieves various info
                   // on image.


int main(int argc, char * argv[])
{
    char *filename = new char[20];        // file name of input image

    TIFF *in, *out;        // pointer to input and output image
    TIFF *bin;						 // pointer to binary image
    size_t npixels;        // total number of pixels in image (width * height)

    int location = 0;  // used to store peak location for binarization.

    system("clear");
    if (argc > 1)             // if no parms are passed prompt for file name.
        filename = argv[1];
    else {
      cout << "enter file name of file to open ==>   ";
      cin >> filename;
    }

    in = TIFFOpen((const char*) filename, "r");
    out= TIFFOpen("out.tif", "w");
    bin = TIFFOpen("binary.tif", "w");
    
    if (!(in && out && bin))
    {
        cerr << "err:  could not open/create file" << endl;
        exit(1);
    }
    
	npixels = read_image(in);
		
    hild = new bool[npixels]; // allocates memory based on image size.

	// initializes bool array to false
    for (int count=0; count < npixels; count++)
    {
        hild[count] = 0;
    }

		
    location = Optimize(npixels); // retrieves ideal location to use in
								// binarization
    binary(npixels, location);// creates a binary image. 

    write_image(bin);    // writes image
    thinning();		  //  thins the image.
    write_image(out);

    delete [] raster;        // deletes the mem used by raster array
    delete [] filename;    // deletes the mem used by filename
    return 0;
}

/******************************************************************************
 * Name:        read_image(TIFF *)
 *
 * Function:    read the raster to the tiff image.
 *
 * parms:       *image  pointer to opened file.
 *
 * Returns:  none.
 * ***************************************************************************/
size_t read_image(TIFF *image)
{
	size_t npixels;		// count of number of pixels in image

    int strips_max;		// # of strips in image        
    int strips_size;	// size of each strip (doh!)
    int result =0;		// status code of TiffReadEncodedStrip()
    int imageOffset = 0;	// counter which keeps track of the offset in the image
							// since we are required by tifflib to read the image
							// in strips
	
    // getting data to be used when re-writting the image
    TIFFGetField(image, TIFFTAG_IMAGEWIDTH, &attr.width);    // returns width of image
    TIFFGetField(image, TIFFTAG_IMAGELENGTH, &attr.height);    // returns height of image
    TIFFGetField(image, TIFFTAG_BITSPERSAMPLE, &attr.bitssample);
    TIFFGetField(image, TIFFTAG_ROWSPERSTRIP, &attr.rowsperstrip);
    TIFFGetField(image, TIFFTAG_SAMPLESPERPIXEL, &attr.sampleperpixel);
    w = attr.width; h = attr.height;


	npixels = w * h;

    raster = new u_char[npixels];  // allocates memory to the raster pointer 


    strips_size = TIFFStripSize(image);
    strips_max  = TIFFNumberOfStrips(image);


	// reads image into raster
    for (int Stripcount = 0; Stripcount < strips_max; Stripcount++)
    {
        result = TIFFReadEncodedStrip(image, Stripcount,raster+imageOffset, strips_size);
        if (result == -1 )
        {
            cerr << "Read error on input strip # " << Stripcount << endl;
            exit(2);
        }
        imageOffset += result;
    }
    /* end input section */

    TIFFClose(image);

	return npixels;
}
/******************************************************************************
 * Name:        write_image(TIFF *)
 *
 * Function:    writes the raster to the tiff image.
 *
 * parms:       *image  pointer to opened file.
 *
 * Returns:  none.
 * ***************************************************************************/
void write_image(TIFF *image)
{

    // trying to write the image i have just read in.
    TIFFSetField(image, TIFFTAG_IMAGEWIDTH, w);
    TIFFSetField(image, TIFFTAG_IMAGELENGTH, h);
    TIFFSetField(image, TIFFTAG_BITSPERSAMPLE, attr.bitssample);
    TIFFSetField(image, TIFFTAG_SAMPLESPERPIXEL, 1);
    TIFFSetField(image, TIFFTAG_ROWSPERSTRIP, h); // rows per strip is equivalent to the height of the
                                                // image, hence h is used instead of the 
                                                // value return by TiffGetField function.
    
    // more attributes set here...
    TIFFSetField(image, TIFFTAG_PHOTOMETRIC, PHOTOMETRIC_MINISBLACK);
    TIFFSetField(image, TIFFTAG_COMPRESSION, COMPRESSION_NONE);
    TIFFSetField(image, TIFFTAG_PLANARCONFIG, PLANARCONFIG_CONTIG);
    TIFFSetField(image, TIFFTAG_RESOLUTIONUNIT, RESUNIT_INCH);
    
	// finalizes all changes, and records them into a tiff file.
    TIFFWriteEncodedStrip(image, 0, raster, w*h);

    TIFFClose(image);
}
/******************************************************************************
 * Name:       binary(u_char *, size_t, int)
 *
 * Function:   creates a crude binary image based on the OTSU algorithm.
 *
 * parms:      raster:   buffer of pixel information
 *             npixels:  num of pixels in image
 *             max:      ideal value of pixel.
 *
 * Returns:    none.
 *
 * Notes:      if pixel value is great then max then erase, 
 * 				else make it black
 * ***************************************************************************/
void binary(size_t npixels, int max)
{
    for (int x=0; x < npixels; x++)
    {
		((unsigned int) raster[x] > max)? raster[x] = 255: raster[x] = 0;

    }
}
/******************************************************************************
 * Name:       Optimize(int npixels)
 *
 * Function:   calls CalcSigma to help identify the ideal value
 *             to be used in the binarization process.
 *
 * parms:     npixels:  num of pixels in image 
 *
 * Returns:    none.
 *
 * Notes:		Part of the OTSU algorithm implementation
 *
 * Logic:		checking on all pixels from 0 to 255
 *
 * 				find max value returned by Calc_Sigm and return the pixel value
 * 				(0 to 255) to the calling function which will in turn use that
 * 				value as the ideal breaking point in the binarization process
 * ***************************************************************************/
int Optimize(int npixels)
{
    int cnt[256] = {0};			// frequency of occurances of this shade of gray in image	

	
	// counts number of occurances of
	// each pixel in the 8 bit image.
    for (int i =0; i <=  npixels; i++)        
        cnt[((unsigned int) raster[i])]++;

    double max = -9; // checks for the max value returned
    double ret_val;	// return value of Calc_Sigma
    int loc = 0;	// tracks ideal location


    for (int k=0; k < 256; k++)
    {
        ret_val = CalcSigma(cnt,k, npixels);
        if (ret_val > max )
        {
            max = ret_val;
            loc = k;
        }
    }

    return loc;
}
/******************************************************************************
 * Name:       double CalcSigma(int [], int, int, int)
 *
 * Function:   Calculates Sigma used by Otsu's algorithm to return the 
 *             Sigma value which in turn helps identify the peak value 
 *             to be used in binarizing the image.
 *
 * parms:      k:        possible max 
 *             npixels:  num of pixels in image
 *             cnt[]:	 frequency count/histogram
 *
 * Returns:    none.
 * ***************************************************************************/
double CalcSigma(int cnt[], int k,int npixels)
{
 const int TOTPIXELS = w*h;
 double pi[256] = {0};

 // calc pi
 for (int x =0; x < 256; x++)
    pi[x] = (double) cnt[x] / (double) TOTPIXELS;


// calculate U-t
 double u_t = 0.0;
 for ( int x=0; x < 256; x++)
     u_t += (x * pi[x]);


 // calculate w(k)
 double w_k = 0.0;

 for (int x=0; x <=k; x++)
   w_k += pi[x];


 // compute u-k
 double u_k = 0.0;

 for (int x = 0; x <=k; x++)
     u_k += (x * pi[x]);


 // compute final k.

 double calc_k;

 double nominator = 0, denominator = 0;

 nominator = pow(((u_t * w_k) - u_k),2);
 denominator = (w_k * (1- w_k));

 calc_k  = nominator / denominator;

 return calc_k;
}
/******************************************************************************
 * Name:       void thinning()
 *
 * Function:   calls Call Test which checks 4 condition of the Hilditch 
 * 			   Algorithm.
 *             
 * parms:      None:
 *             
 *
 * Returns:    none.
 *
 * Logic:		Runs algorithm for 50 iteration to thin the image.
 *
 * Note:		This should eventually be fixed so it would only run as long
 * 				As there are still pixels to be deleted.
 * ***************************************************************************/
void thinning()
{

	int size = w * h;//
	int loc;		// location holder within raster
        
    for(int x = 0; x < 50; x++)
    {	
		// checks the 4 hilditch conditions
		// for every pixel within the image
		for (loc = 0; loc < size; loc++)
		{
			if ((int) raster[loc] == 0)
				call_test(loc);
		}

		// deltes the needed pixels
		for (loc = 0; loc < size; loc++)
		{
           if(hild[loc])
				raster[loc] = 255;
		}
   }//end of iterations
}
/******************************************************************************
 * Name:       void call_test(int loc)
 *
 * Function:   checks the 4 hilditch conditions
 *             
 * parms:      int loc:   the current pixel being looked at within the raster
 *
 * Returns:    none.
 *
 * Notes:       assumes that if call_test was called, then p is a black pixel
 * ***************************************************************************/
void call_test(int loc)
{
  int x[10] = {-1};


	x[2] = ((loc - (int) w ) < 0) ? -1: (loc- (int) w);
	x[3] = ((loc - (int) w + 1) < 0) ? -1: (loc- (int) w + 1);
  	x[4] = (loc > 0 and loc % (int) w == 0)? -1 : loc + 1;
	x[5] = ((loc + (int) w + 1) > (int (w*h))) ? -1: (loc + (int) w + 1);
	x[6] = ((loc + (int) w) > (int (w*h))) ? -1: (loc + (int) w);
	x[7] = ((loc + (int) w - 1) > (int (w*h))) ? -1: (loc + (int) w - 1);
	x[8] = (loc % (int ) w == 1) ? -1 : loc - 1;  // checks for beg. corner pixels
	x[9] = ((loc - (int) w - 1) < 0) ? -1: (loc- (int) w - 1);

   /** condition 1:  2< =B(p1) <=6 , black neighbors of p1. **/
   int black = 0;	// number of black pixels
   bool h1 = false;	// condition one test flag
   
    for(int z = 2; z < 10; z++)
       if (raster[x[z]] == 0)  black ++;

    (black >= 2 && black <= 6) ? h1 = true : h1 = false;
 
 
    // ** condition 2: A(p1) = 1
    bool h2 = false;		// cond 3.  test flag
 
    (Xh(loc) == 1)? h2 = true : h2= false;


    // condition 3:  p2*p4*p8 = 0 or A(p2) ! = 1;
    bool h3 = false;		// cond3 test flag
    if ((raster[x[2]] == 255 || raster[x[4]] == 255 || raster[x[8]] == 255) || Xh(x[2]) != 1)
             h3= true;

   // condition 4:  p2*p4*p6 = 0 or A(p4)! =1
    bool h4 = false;	// cond4 test flag
    if ((raster[x[2]] == 255 || raster[x[4]] == 255 || raster[x[6]] == 255) || Xh(x[4]) != 1)
             h4= true;

	// if all test conditions passed, then mark pixel for extermination :P
   if (h1 && h2 && h3 && h4) hild[loc] = true; 


// ************** end checking for Hilditch conditions ************  //
}
/******************************************************************************
 * Name:       Xh(u_char *)
 *
 * Function:   calculates the sum of bi according to the Xh(p) algorithem
 *             for a given pixel.
 *             
 * parms:      Raster        char raster containing every pixel of the image
 *             
 * Returns:    sum of bi, based on the algo.
 *
 * Notes:    
 *                Xh(P) = Sum( for i= 1 to 4)  bi;
 *
 *                with 1 through 4 representing the 4 neighbors
 *
 *                bi = {  1 iff X2i-1 = 0 and (X2i = 1 or X2i+1 = 1 }
 *                     {  0 otherwise                               }
 *
 *
 *  A-Note:         Check, done.
 * ***************************************************************************/
int Xh(int count )
{
    int sum = 0;

    int x[10] = {-1};              // stores the loc of the 4-neighbors (x1, x3, x5, x7)

	x[2] = ((count - (int) w ) < 0) ? -1: (count- (int) w);
	x[3] = ((count - (int) w + 1) < 0) ? -1: (count- (int) w + 1);
	x[4] = (count > 0 && count % (int ) w == 0) ? -1 : count + 1;  // checks for end corner pixels
	x[5] = ((count + (int) w + 1) > (int (w*h))) ? -1: (count + (int) w + 1);
	x[6] = ((count + (int) w) > (int (w*h))) ? -1: (count + (int) w);
	x[7] = ((count + (int) w - 1) > (int (w*h))) ? -1: (count + (int) w - 1);
	x[8] = (count % (int ) w == 1) ? -1 : count - 1;  // checks for beg. corner pixels
	x[9] = ((count - (int) w - 1) < 0) ? -1: (count- (int) w - 1);

        //255 is white and 0 is black after binarization.
        if( raster[x[2]] == 255 && raster[x[9]] == 0) 
                    sum++;

        for(int neighbor = 9; neighbor >=2; neighbor --)
            if (raster[x[neighbor]] == 255 && raster[x[neighbor -1]] == 0)
                    sum++;

	return sum;

}
/******************************************************************************
 * Name:       int bi(int[], int )
 * Function:   if conditions are met, return 1, else return 0
 * parms:      array with pixel and 8 neighbors
 * Returns:    1 or 0 depending if conds. are met
 * Notes:          
 *
 *                bi = {  1 iff X2i-1 = 0 and (X2i = 1 or X2i+1 = 1 }
 *                     {  0 otherwise                               }
 * ***************************************************************************/
int bi(int x[], int i )
{

    int look_in ;

    if (( raster[(x[i  -1])] == 255) && 
        ( raster[(x[i])] == 0 || raster[(x[i +1])] == 0)) 
            return 1;

    return 0;

}
