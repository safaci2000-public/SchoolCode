#include "finger.h"

//Static variables being initialized
int finger::xid = 0;
int finger::numprocs=0, 
    finger::rank=0, 
    finger::namelen=0;
char* processor_name = NULL;
double finger::bintime = 0.0;
double finger::thintime = 0.0;

/******************************************************************************
 * Name:        Construct
 * Function:    read the raster to the tiff image.
 * parms:       None
 * Returns:     None.
 *****************************************************************************/
finger::finger(): binMid(140) // sets the binarization mid point to 140
{
  raster = NULL;
  hild = NULL;
  in = out = NULL;
  npixels = 7;    
  raster  = NULL;    
  width =  height = 0 ;
  hild = NULL;  
  unique = NULL;   
  emptyid = false;
  xid++;
  id = xid;
  bin_flag = false;

  left  = new bool[numprocs];
  right = new bool[numprocs];
}
/******************************************************************************
 * Name:        Destructor
 * parms:       None
 * Returns:     None.
 *****************************************************************************/
finger::~finger()
{
    if(raster != NULL)
        delete [] raster;        // deletes the mem used by raster array
    
//
//    if(hild != NULL)
//        delete [] hild;         // deletes the Hild bool array
//
    raster = NULL;
    hild = NULL;
}
/******************************************************************************
 * Name:        readImage()
 * Function:    read the raster to the tiff image.
 * parms:       None
 * Returns:     None.
 *****************************************************************************/
void finger::readImage(std::string in)
{

    int strips_max;     // # of strips in image        
    int strips_size;    // size of each strip (doh!)
    int result =0;      // status code of TiffReadEncodedStrip()
    int imageOffset = 0;    // counter which keeps track of the offset in the image
                            // since we are required by tifflib to read the image
                            // in strips
    
    this->in = TIFFOpen((const char*) in.c_str(), "r");
    if(this->in == NULL)
    {
       std::cout << "error, could not open image for read\n";
       return;
    }


    // getting data to be used when re-writting the image
    TIFFGetField(this->in, TIFFTAG_IMAGEWIDTH, &attr.width);    // returns width of image
    TIFFGetField(this->in, TIFFTAG_IMAGELENGTH, &attr.height);    // returns height of image
    TIFFGetField(this->in, TIFFTAG_BITSPERSAMPLE, &attr.bitssample);
    TIFFGetField(this->in, TIFFTAG_ROWSPERSTRIP, &attr.rowsperstrip);
    TIFFGetField(this->in, TIFFTAG_SAMPLESPERPIXEL, &attr.sampleperpixel);
    width = attr.width; height = attr.height;


    npixels = width * height;

    raster = new unsigned char[npixels];  // allocates memory to the raster pointer 


    strips_size = TIFFStripSize(this->in);
    strips_max  = TIFFNumberOfStrips(this->in);


    // reads image into raster
    for (int Stripcount = 0; Stripcount < strips_max; Stripcount++)
    {
        result = TIFFReadEncodedStrip(this->in, Stripcount,raster+imageOffset, strips_size);
        if (result == -1 )
        {
            std::cerr << "Read error on input strip # " << Stripcount << std::endl;
            exit(2);
        }
        imageOffset += result;
    }
    /* end input section */

    TIFFClose(this->in);
    this->in = NULL;
    hild = new bool[npixels]; // allocates memory based on image size.
    // initializes bool array to false
    for (int count=0; count < npixels; count++)
        hild[count] = 0;

    emptyid = true;
}
/******************************************************************************
 * Name:        write_image()
 * Function:    writes the raster to the tiff image.
 * parms:       string denoting file name
 * Returns:     None.
 * ***************************************************************************/
void finger::writeImage(std::string in)
{

    out = TIFFOpen((const char*) in.c_str(), "w");

    if (!(this->out)) 
    {
        std::cerr << "err:  could not write to file" << std::endl;
        return;
    }

    // trying to write the out i have just read in.
    TIFFSetField(out, TIFFTAG_IMAGEWIDTH, width);
    TIFFSetField(out, TIFFTAG_IMAGELENGTH, height);
    TIFFSetField(out, TIFFTAG_BITSPERSAMPLE, attr.bitssample);
    TIFFSetField(out, TIFFTAG_SAMPLESPERPIXEL, 1);
    TIFFSetField(out, TIFFTAG_ROWSPERSTRIP, height); // rows per strip is equivalent to the height of the
                                                // out, hence h is used instead of the 
                                                // value return by TiffGetField function.
    
    // more attributes set here...
    TIFFSetField(out, TIFFTAG_PHOTOMETRIC, PHOTOMETRIC_MINISBLACK);
    TIFFSetField(out, TIFFTAG_COMPRESSION, COMPRESSION_NONE);
    TIFFSetField(out, TIFFTAG_PLANARCONFIG, PLANARCONFIG_CONTIG);
    TIFFSetField(out, TIFFTAG_RESOLUTIONUNIT, RESUNIT_INCH);
    
    // finalizes all changes, and records them into a tiff file.
    TIFFWriteEncodedStrip(out, 0, raster, width*height);

    TIFFClose(out);

}
/******************************************************************************
 * Name:       binarize(int npixels)
 *
 * Function:   Binarizes images, allowing only black and white pixels.  
 *             Initially implimented using OTSU algorithem, which was replaced
 *             by a middle point 140, rather then any intelligent algorithem.
 *             The decision was mainly due to hardware limitation, and our need
 *             to avoid floating point calculations.
 *             
 * parms:      npixels:  num of pixels in image 
 * Returns:    none.
 * Notes:      binarize expects thinning to follow shortly after, if not the 
 *             MPI_Send will block until an MPI_Recv call is received to collect
 *             the data and allow the execution to continue.
 * ***************************************************************************/
void finger::binarize(int cpuid, int numCores)
{
    int cnt[256] = {0};         // frequency of occurances of this shade of gray in image   

    int localpixel = npixels / numCores;  // check to avoid truncation
    if (cpuid == 0)
    {


        MPI_Status status;
        unsigned char data2[npixels];  
        unsigned char data1[npixels];  
        //recieve odd numbered branch
        MPI_Recv(data1, npixels, MPI_BYTE, 1,1, MPI_COMM_WORLD, &status);
        for(int i=0; i< npixels; i++)
            raster[i] = data1[i];
       //receive even numbered branch
        if(numprocs > 2) 
        {
            MPI_Recv(data2, npixels, MPI_BYTE, 2,1, MPI_COMM_WORLD, &status);
            for(int i=0; i< npixels; i++)
                raster[i] = data2[i];
            this->merge(data1,data2);
        }
        clock_t tstart,tend;
        tstart = clock();
        //core 0 writes
        int loc = binMid;    // tracks ideal location
        for (int x=0; x < localpixel; x++)
            ((unsigned int) raster[x] >= loc)? raster[x] = 255: raster[x] = 0;

        tend = clock(); 
        bintime += ((double) (tend - tstart)) / ((double) CLOCKS_PER_SEC);
        //std::cout <<  id << ",bin-core," <<  rank << "," << std::setprecision(5) << ((((double) (tend - tstart)) / ((double) CLOCKS_PER_SEC))) << std::endl;
    }
    else  // deal with odd numbered cores
    {
        //begin
        //
        unsigned char data[npixels];
        MPI_Status status;

        if(!isLeaf(cpuid))
        {
            if(  ((cpuid*2)+1) < numprocs )
            {
                MPI_Recv(data, npixels, MPI_BYTE, ((cpuid*2)+1),1, MPI_COMM_WORLD, &status);
                //recv
                this->merge(raster,data);
            }
            if(  ((cpuid*2)+2) < numprocs )
            {
                MPI_Recv(data, npixels, MPI_BYTE, ((cpuid*2)+2),1, MPI_COMM_WORLD, &status);
                this->merge(raster,data);
                //recv
            }
        }

        clock_t tstart,tend;
        tstart = clock();
        //make changes on current node
        for (int i =(cpuid*localpixel); i <=  ((cpuid+1)*localpixel); i++) 
            cnt[((unsigned int) raster[i])]++;


        int loc = binMid;
        for (int x=(cpuid*localpixel); x < ((cpuid+1)*localpixel); x++)
            ((unsigned int) raster[x] >= loc)? raster[x] = 255: raster[x] = 0;
        tend = clock(); 
        bintime += ((double) (tend - tstart)) / ((double) CLOCKS_PER_SEC);
        //std::cout <<  id << ",bin-core," <<  rank << "," << std::setprecision(5) << ((((double) (tend - tstart)) / ((double) CLOCKS_PER_SEC/1000))) << std::endl;
       
        if(cpuid == 2 || cpuid == 1)
            MPI_Send(raster, npixels, MPI_BYTE, 0,1, MPI_COMM_WORLD);
        else
            MPI_Send(raster, npixels, MPI_BYTE, ((cpuid-1)/2),1, MPI_COMM_WORLD);

    }
}
/******************************************************************************
 * Name:       isLeaf
 * Function:   Determines whether or not the node of the tree is a leaf
 * parms:      None:
 * Returns:    none.
 * ***************************************************************************/
bool finger::isLeaf(int id)
{
    if((id*2) < (numprocs -1))
        return false;
    else
        return true ;

}
/******************************************************************************
 * Name:       void thinning()
 *
 * Function:   calls Call Test which checks 4 condition of the Hilditch 
 *             Algorithm.
 * parms:      None:
 * Returns:    none.
 * Logic:      Runs algorithm for 50 iteration to thin the image.
 *
 * Note:        This should eventually be fixed so it would only run as long
 *              As there are still pixels to be deleted.
 * ***************************************************************************/
void finger::thinning(int rank, int numprocs)
{
    int size = attr.width * attr.height;

    int loc;        // location holder within raster
    int localpixel = size/ numprocs;

    //Broadcasts data to all nodes with the binarized image
    if(rank != 0)
    {
        
        unsigned char *tempdata;
        MPI_Status status;
        tempdata = new unsigned char[npixels];
        MPI_Recv(tempdata, npixels, MPI_BYTE, 0,1, MPI_COMM_WORLD, &status);

        for(int i=0; i < npixels; i++)
            raster[i] = tempdata[i];

    }

    if(rank == 0)
    {
        clock_t tstart, tend;
        int size = npixels/numprocs;
        unsigned char data[size];  // pointers=bad.  Must statically allocate data space
        //Copy data to all other cores
        for(int i =1; i < numprocs; i++)
        {
            MPI_Send(raster, npixels, MPI_BYTE, i,1, MPI_COMM_WORLD);
        }
        //everything works up to this point.        

        MPI_Status status;
        int index = 0;
        traverse(1);  //Get count from Left Branch 
        for(int i=0; i < list.size(); i++)
        {
            MPI_Recv(&index, 1, MPI_INT, 1,1, MPI_COMM_WORLD, &status);    //recieve index
            MPI_Recv(data, size, MPI_BYTE, 1,1, MPI_COMM_WORLD, &status); // receive data
            insertStrip(data, (index* size),size);
        }
        
        list.clear(); //flush list
        traverse(2);
        //receive data to merge from right branch
        if(numprocs == 2) list.clear();

        for(int i=0; i < list.size(); i++)
        {
            MPI_Recv(&index, 1, MPI_INT, 2,1, MPI_COMM_WORLD, &status);    //recieve index
            MPI_Recv(data, size , MPI_BYTE, 2,1, MPI_COMM_WORLD, &status); // receive data
            insertStrip(data, (index* size),size);
        }
        
        tstart = clock();

        // Thin core 0 data
        for(int x = 0; x < 50; x++)
        {   
            // checks the 4 hilditch conditions
            // for every pixel within the image
            for (loc = 0; loc < localpixel; loc++)
            {
                if ((int) raster[loc] == 0)
                    hildTest(loc);
            }
    
            // deltes the needed pixels
            for (loc = 0; loc < localpixel; loc++)
            {
               if(hild[loc])
                    raster[loc] = 255;

            }

       }//end of iterations

        tend = clock();

        thintime += ((double) (tend - tstart)) / ((double) CLOCKS_PER_SEC);
        //std::cout <<  id << ",thin-core," <<  rank << "," << std::setprecision(5) << ((((double) (tend - tstart)) / ((double) CLOCKS_PER_SEC/1000))) << std::endl;
        //send data to all nodes
       for(int i = 1; i < numprocs; i++)
            MPI_Send(raster, npixels, MPI_BYTE, i,1, MPI_COMM_WORLD);

    }//end core 0
    else
    {

        clock_t tstart, tend;
        int size = npixels/numprocs;
        unsigned char data[size];
        MPI_Status status;

        //Retrieve list of Nodes to populate image with.
        if(((rank*2)+1) < numprocs)
            traverse((rank*2)+1);

        int start = 0, end = 0;
        //Receive first
        int index=0;
        int dest = -1;

        //Calculating to which node to send data to
        if(rank == 1 || rank == 2)
            dest = 0;
        else
            dest = ((rank-1)/2);


        if(!list.empty())
        {
           for(int i=0; i < list.size(); i++)
           {
            //Receive Data from child node of its subtree and self 
            MPI_Recv(&index, 1, MPI_INT, ((rank*2)+1),1, MPI_COMM_WORLD, &status);    //recieve index

            MPI_Recv(data, size, MPI_BYTE, ((rank*2)+1),1, MPI_COMM_WORLD, &status);
            //Push Data Received to Parent
            
            MPI_Send(&index, 1, MPI_INT, dest ,1, MPI_COMM_WORLD);
            MPI_Send(data, size, MPI_BYTE, dest ,1, MPI_COMM_WORLD);
           }

        }
        
        //Right Tree
        list.clear();  // flush out list.
        if(((rank*2)+2) < numprocs)
            traverse((rank*2)+2);

        if(!list.empty())
        {
           for(int i=0; i < list.size(); i++)
           {
            //Receive Data from child node of its subtree and self 
            MPI_Recv(&index, 1, MPI_INT, ((rank*2)+2),1, MPI_COMM_WORLD, &status);    //recieve index
            MPI_Recv(data, size, MPI_BYTE, ((rank*2)+2),1, MPI_COMM_WORLD, &status);
            //Push Data Received to Parent
            MPI_Send(&index, 1, MPI_INT, dest,1, MPI_COMM_WORLD);
            MPI_Send(data, size, MPI_BYTE, dest,1, MPI_COMM_WORLD);
           }

        }
        

        tstart = clock();
        //thins strip for current core.
        for(int x = 0; x < 50; x++)
        {   
            // checks the 4 hilditch conditions
            // for every pixel within the image

            for (int x=(rank*localpixel); x < ((rank+1)*localpixel); x++)
            {
               // ((unsigned int) raster[x] >= loc)? raster[x] = 255: raster[x] = 0;
                if ((int) raster[x] == 0)
                    hildTest(x);

            }
    
            // deltes the needed pixels
            for (int x=(rank*localpixel); x < ((rank+1)*localpixel); x++)
            {
               if(hild[x])
                    raster[x] = 255;
            }
       }//end of iterations
       //Mark Start Boundaries

        tend = clock();

        //std::cout <<  id << ",thin-core," <<  rank << "," << std::setprecision(5) << ((((double) (tend - tstart)) / ((double) CLOCKS_PER_SEC/1000))) << std::endl;
        thintime += ((double) (tend - tstart)) / ((double) CLOCKS_PER_SEC);
        index = rank;
        if(rank == 2 || rank == 1)
        {
            index = rank;
            MPI_Send(&index, 1, MPI_INT, 0,1, MPI_COMM_WORLD);
            MPI_Send(raster+(rank*size), size, MPI_BYTE, 0,1, MPI_COMM_WORLD);
        }
        else
        {
            index=rank;
            MPI_Send(&index, 1, MPI_INT, dest,1, MPI_COMM_WORLD);
            MPI_Send(raster+(rank*size), size, MPI_BYTE, ((rank-1)/2),1, MPI_COMM_WORLD);
        }


        MPI_Recv(raster, npixels, MPI_BYTE, 0,1, MPI_COMM_WORLD, &status); // receive completed image from core 0

    }
}
/******************************************************************************
 * Name:        
 * Function:    
 * parms:       offset = start index location in image array
 *              size = size of image strip
 * Returns:    
 * ***************************************************************************/
void finger::insertStrip(u_char * data, int offset,int size)
{
    for(int i=0; i < size; i++)
        raster[i+offset] = data[i];

}
/******************************************************************************
 * Name:        
 * Function:    
 * parms:       
 * Returns:     
 * ***************************************************************************/
void finger::traverse(int node)
{
  if(node > numprocs)
  	return;
  list.push_back(node);
  
  //left branch
  if(((node*2)+1) < numprocs)
  	traverse((node*2)+1);

  // right branch
  if(((node*2)+2) < numprocs)
  	traverse((node*2)+2);
}

/******************************************************************************
 * Name:        mergethin(data1,data2); 
 * Function:    takes two rasters of pixel data and merges the two data sets
 *              looking for binarization patterns.
 * parms:       data1 = even cores, processed data
 *              data2 = odd cores, processed data
 * Returns:     None, all changes made to unsigned char*raster;
 * ***************************************************************************/
void finger::mergethin(unsigned char *data1, unsigned char *data2)
{

    int record[3] = {0};  // keeps track of flagged ids

    int cores = numprocs;
    int local = npixels / cores;
    // 0 ommited, since that has yet to be processed
    unsigned char *ptr; 
    bool start = false;
    bool finish = false;
    
    // Walk through Data1
    int recid = 0;
    for (int i =1; i< npixels; i++)
    {
       if((data1[i] == (u_char) 254 || data1[i] == (u_char) 1))
       {
            //data1[i] = 255;
            if(recid < 2)
            {
            record[recid] = i;
            recid++;//increment id
            }
            else
            {
                std::cerr << "error, too many delimiters detected";
            }
            start = !start;
//            std::cout << "start/end detected at position" << i << std::endl;
       }
       if(start)
       {
//           std::cout << "changing something\n";
           raster[i] = data1[i]; 
       }

    }
    //Walk through Data2

    start = false;
    for (int i = 0; i < npixels; i++)
    {
       if((data2[i] == (u_char) 254) ||  (data2[i] == (u_char) 1))
       {
            //data2[i] = 255;
            if(i == record[0])
            {
                (raster[i] == (u_char)254)? raster[i] = (u_char) 255: raster[i] = (u_char) 0;  // nulify entity
                if((i+1) < npixels)
                    i++;
            }
            if(i == record[1])
            {
                 (raster[i] == (u_char)254)? raster[i] = (u_char) 255: raster[i] = (u_char) 0;  // nulify entity
                if((i+1) < npixels)
                    i++;
            }
            start = !start;
//            std::cout << "start/end detected at position" << i << std::endl;

       }
       if(start)
       {
//           std::cout << "changing something\n";
           raster[i] = data2[i]; 
       }
    }
}
/******************************************************************************
 * Name:       Xh(u_char *)
 * Function:   calculates the sum of bi according to the Xh(p) algorithem
 *             for a given pixel.
 * parms:      Raster  char raster containing every pixel of the image
 * Returns:    sum of bi, based on the algo.
 * Notes:      Xh(P) = Sum( for i= 1 to 4)  bi;
 *             with 1 through 4 representing the 4 neighbors
 *
 *             bi = {  1 iff X2i-1 = 0 and (X2i = 1 or X2i+1 = 1 }
 *                  {  0 otherwise                               }
 * ***************************************************************************/
int finger::Xh(int count )
{

    int sum = 0;

    int x[10] = {-1};              // stores the loc of the 4-neighbors (x1, x3, x5, x7)

    x[2] = ((count - (int) width ) < 0) ? -1: (count- (int) width);
    x[3] = ((count - (int) width + 1) < 0) ? -1: (count- (int) width + 1);
    x[4] = (count > 0 && count % (int ) width == 0) ? -1 : count + 1;  // checks for end corner pixels
    x[5] = ((count + (int) width + 1) > (int (width*height))) ? -1: (count + (int) width + 1);
    x[6] = ((count + (int) width) > (int (width*height))) ? -1: (count + (int) width);
    x[7] = ((count + (int) width - 1) > (int (width*height))) ? -1: (count + (int) width - 1);
    x[8] = (count % (int ) width == 1) ? -1 : count - 1;  // checks for beg. corner pixels
    x[9] = ((count - (int) width - 1) < 0) ? -1: (count- (int) width - 1);

        //255 is white and 0 is black after binarization.
        if( raster[x[2]] == 255 && raster[x[9]] == 0) 
                    sum++;

        for(int neighbor = 9; neighbor >=2; neighbor --)
            if (raster[x[neighbor]] == 255 && raster[x[neighbor -1]] == 0)
                    sum++;
    return sum;

}
/******************************************************************************
 * Name:       void call_test(int loc)
 * Function:   checks the 4 hilditch conditions
 * parms:      int loc:   the current pixel being looked at within the raster
 * Returns:    none.
 * Notes:       assumes that if call_test was called, then p is a black pixel
 * ***************************************************************************/
void finger::hildTest(int loc)
{
  int x[10] = {-1};


    x[2] = ((loc - (int) width ) < 0) ? -1: (loc- (int) width);
    x[3] = ((loc - (int) width + 1) < 0) ? -1: (loc- (int) width + 1);
    x[4] = (loc > 0 and loc % (int) width == 0)? -1 : loc + 1;
    x[5] = ((loc + (int) width + 1) > (int (width*height))) ? -1: (loc + (int) width + 1);
    x[6] = ((loc + (int) width) > (int (width*height))) ? -1: (loc + (int) width);
    x[7] = ((loc + (int) width - 1) > (int (width*height))) ? -1: (loc + (int) width - 1);
    x[8] = (loc % (int ) width == 1) ? -1 : loc - 1;  // checks for beg. corner pixels
    x[9] = ((loc - (int) width - 1) < 0) ? -1: (loc- (int) width - 1);

   /** condition 1:  2< =B(p1) <=6 , black neighbors of p1. **/
   int black = 0;   // number of black pixels
   bool h1 = false; // condition one test flag
   
    for(int z = 2; z < 10; z++)
       if (raster[x[z]] == 0)  black ++;

    (black >= 2 && black <= 6) ? h1 = true : h1 = false;
 
 
    // ** condition 2: A(p1) = 1
    bool h2 = false;        // cond 3.  test flag
 
    (Xh(loc) == 1)? h2 = true : h2= false;


    // condition 3:  p2*p4*p8 = 0 or A(p2) ! = 1;
    bool h3 = false;        // cond3 test flag
    if ((raster[x[2]] == 255 || raster[x[4]] == 255 || raster[x[8]] == 255) || Xh(x[2]) != 1)
             h3= true;

   // condition 4:  p2*p4*p6 = 0 or A(p4)! =1
    bool h4 = false;    // cond4 test flag
    if ((raster[x[2]] == 255 || raster[x[4]] == 255 || raster[x[6]] == 255) || Xh(x[4]) != 1)
             h4= true;

    // if all test conditions passed, then mark pixel for extermination :P
   if (h1 && h2 && h3 && h4) hild[loc] = true; 

// ************** end checking for Hilditch conditions ************  //
}
/******************************************************************************
 * Name:       getRaster()
 * Function:   returns a pointer to the image data (array of unsigned char)
 * Returns:    unsigned char pointer to image data
 * ***************************************************************************/
unsigned char * finger::getRaster()
{
    return raster;
}
/******************************************************************************
 * Name:       getPixels()
 * Function:   return number of pixels per image
 * parms:      none
 * Returns:    long long of npixels
 * Notes:       
 * ***************************************************************************/
long long finger::getPixels()
{
    return npixels;

}
/******************************************************************************
 * Name:       emtpy()
 * Function:   returns a bool denoting if an image has been loaded into object
 *             or not.
 * ***************************************************************************/
bool finger::empty()
{
    return emptyid ;

}
/******************************************************************************
 * Name:       setEmtpy()
 * Function:   returns a bool denoting if an image has been loaded into object
 *             or not.
 * ***************************************************************************/
void finger::setEmpty()
{
    
    emptyid   = true;
}
/******************************************************************************
 * Name:        merge(dat1,data2); 
 * Function:    takes two rasters of pixel data and merges the two data sets
 *              looking for binarization patterns.
 * parms:       data1 = even cores, processed data
 *              data2 = odd cores, processed data
 * Returns:     None, all changes made to unsigned char*raster;
 * ***************************************************************************/
void finger::merge(unsigned char *data1, unsigned char *data2)
{
    unsigned char *ptr; //pointer to current data struct being looked at.
    ptr = data1;
    for(int i=0; i < npixels; i++)
    {
        if( data1[i] == 0 || data1[i] == 255)
            ptr = data1;
        else
            ptr = data2;
        raster[i] = ptr[i];
    }

}
