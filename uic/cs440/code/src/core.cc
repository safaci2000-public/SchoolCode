/*****************************************************************
 * Name:          Samir Faci
 * Class:         CS440
 * Assignment:    Project
 * Description:   Embed info inside of a jpeg, gif, or png
 * 					core.cc established the cli interface which is then
 * 					called by the GUI.  
 *
 * Error Codes:
 *		2 == Error, invalid parms passed in.
 *		3 == Error, cannot open file or create file
 *		4 == no embedded content detected in image.  Or content 
 *				was not embedded by this program
 *		5 == file type mismatch
 *		6 ==  input and output file are the same
 *		7 ==  Invalid Image type 
 *		8 ==  Error, could not fork
 *		-999 ==  GUI error, see gui doc
 *
*******************************************************************/
#include <string>
#include <fstream>
#include <iostream>
#include <sys/stat.h>
#include <ios>
#include <string.h>
#include <cstdlib>
#include <time.h>

// used to store and parsing of various parameters passed in
struct parms
{ 
   char *input;
   char *output;
   char *embed;
   char action[10];
   char *filename;
   
};

struct file_info
{
 char filename[100];
 int size;
};

// global Varialbes
const int md5sum_char = 16;
const char foo[] = {0xf4,0x8b,0xb6,0x92,0xe4,0x18,0x44,0x58,0xff,0x76,0x8b,0xc8,0xe8,0x92,0x6b,0x41};
const std::string str(foo,foo+sizeof(foo));  // md5sum of cs440 used for eof marker 

// Function Prototypes
struct parms tokenize(int, char*[]);
void embed(std::ifstream &, std::ofstream &, struct parms);
void check_parms(struct parms);
char * extract(struct parms , std::ifstream& );
struct file_info image_info(std::ifstream &,struct parms );
char* extract_data(std::string &, int, int );
void write_log(struct parms, char *p=0);
/*****************************************************************
 * Method:         main
 * Arguments:      argc   // parm counter
 *           	   argv   // argument array
 * Returns:        exit value
 * Function:       control flow of program
*******************************************************************/
int main(int argc, char * argv[]) 
{
   struct parms arg; // arguments passed into the program
   arg.input = arg.output = arg.embed  = arg.filename = '\0';
   arg = tokenize(argc, argv);  // tokenize function
   check_parms(arg);
     
   std::ifstream in_file;
   std::ofstream out_file;

   // print action being performed
   std::cout << arg.action << "ing..."<< std::endl;
   if (strcmp(arg.action,"embed") == 0)
   {
    embed(in_file, out_file, arg);
	write_log(arg);
   }
   if (strcmp(arg.action,"extract") == 0)
   {
    char *p= extract(arg,in_file);  // test out the extraction of a file
	write_log(arg,p);
   }
   std::cout << "done!\n";
   						

  in_file.close();
  out_file.close();
  return 0;
}
/*****************************************************************
 * Method:         tokenize
 * Arguments:      argc   // parm counter
 *           	   argv   // argument array
 * Returns:        exit value
 * Function:       split argument list and checks that min. amount
 *           		of arguments have been passed.
*******************************************************************/
struct parms tokenize(int argc, char* argv[])
{
  struct parms arguments;
  arguments.input = 0;
  char *input;  // input string
  char *output; // output string

  if (argc == 1 )
  {
    std::cerr << "No Parameters were passed in. Please use the following format when calling the program:\n\n embed:  stego --input <filename> --output <filename> --embed data\n extract: stego --extract <file>\n Images supported are:  jpg, png, tiff\n";
	exit(2); // invalid parms
  }
  else if (argc <7 && argc >1 && argc !=3)
  {
	std::cerr << "Invalid Arguments passed in. "  << std::endl;
	exit(2);  // invalid parms
  }

  for (int count=0; count < argc; count++)
  {
    if (strcmp(argv[count], "--input") == 0)  // input file
    {
    if (argv[count+1][0] == '-') 
     {
        std::cerr << "argument " << argv[count] << " requires an argument\n files starting with a - are not supported\n";
      break;
     }
    else
	 {
	  arguments.input = new char[strlen(argv[count+1])];
	  strcpy(arguments.input,argv[count+1]);
	  strcpy(arguments.action,"embed");
	  if (argc != 7)
	  {
		std::cerr << "Invalid Arguments passed in. "  << std::endl;
		exit(2);  // invalid parms
	   }
	 }
    }

    if (strcmp(argv[count], "--extract") == 0)  // input file
    {
    if (argv[count+1][0] == '-') 
     {
        std::cerr << "argument " << argv[count] << " requires an argument\n files starting with a - are not supported\n" ;
      break;
     }
    else
	 {
	  arguments.filename= new char[strlen(argv[count+1])];
	  strcpy(arguments.filename,argv[count+1]);
	  strcpy(arguments.action,"extract");
	 }
    }

  if (strcmp(argv[count], "--output") == 0) // output file
  { 
    if (argv[count+1][0] == '-') 
    {
        std::cerr << "argument " << argv[count] << " requires an argument\n files starting with a - are not supported\n";
      break;
    }
    else
	{
    arguments.output = new char[strlen(argv[count+1])];
	strcpy(arguments.output,argv[count+1]);
	if (strcmp(arguments.input, arguments.output) == 0)
	 {
	    std::cerr << "input and output file names are the same\n";
		exit(6);
	 }
	}
  }
  if (strcmp(argv[count], "--embed") == 0 ) // file to embed
  { 
    if (argv[count+1][0] == '-') 
    {
        std::cerr << "argument " << argv[count] << " requires an argument\n files starting with a - are not supported\n" ;
      break;
    }
    else
    {
     arguments.embed= new char[strlen(argv[count+1])];
	 strcpy(arguments.embed,argv[count+1]);

     int count = 0;
     while (arguments.embed[count] != '\0')
     {
       if (arguments.embed[count] == '/' || arguments.embed[count] == '\\')
           arguments.filename = arguments.embed+count+1;
	   else
	   		arguments.filename = arguments.embed;
       count++;
     }

    }
   }
  }
  return arguments;
}
/*****************************************************************
 * Method:         Embed
 * Arguments:      in - input image
 * 				   out - output image
 * 				   arg - parameter struct
 *
 * Returns:      	None
 * Function:    	writes data to the out image file specified
 *           
*******************************************************************/
void embed(std::ifstream&  in, std::ofstream& out, struct parms arg) 
{
   struct file_info info;  // stores info about a file.
 
   in.open(arg.input, std::ios_base::binary);
   out.open(arg.output,  std::ios::binary );

   if (!in.is_open())
   {
      std::cerr << "Error: could not open input file.\n" ; 
    exit(3);
   } 
   
   if (!out.is_open())
   {
      std::cerr << "Error: could not create file." << std::endl; 
      exit(3);
   }
   
  // recreate image in out file
  out << in.rdbuf();
  out << str;  // write a unique ID hash end


  // write file name to image file
  info = image_info(in,arg);

  /*  retrieve file name of embeded file */
  std::ifstream embed(arg.embed, std::ios_base::binary);
  if (!embed.is_open())
   {
      std::cerr << "Error: could not open file." << std::endl; 
      exit(3);
   }
  // retrieve file size of file to be embedded
  embed.seekg(0,std::ios::end);
  info.size = embed.tellg();
  embed.seekg(0,std::ios::beg);
  
  // writes states on embed file to image file
  out << info.filename << '\0' << info.size << '\0';
  
  // append data to image
  out << embed.rdbuf();
  out << str;  // write a unique ID hash beg
  embed.close();

}
/*****************************************************************
 * Method:         image_info
 * Arguments:      image -  input file stream
 * 				   arg - arguments passed in.
 *           
 * Returns:        struct file_info
 * Function:       retrieves stats on a file being passed in.	
 *           
*******************************************************************/
struct file_info image_info(std::ifstream &image,struct parms arg )
{
  struct file_info nfo;
  nfo.filename;
  char *ptr;
  ptr = arg.filename;
  while(*ptr++ != '\0')
  {
	if (*ptr == '/') arg.filename = ptr+1;
  }

  strcpy(nfo.filename, arg.filename);

  image.seekg(0,std::ios::end); // goto end of file
  nfo.size = image.tellg(); // get file size
  image.seekg(0,std::ios::beg);  // reset position

  return nfo;
}
/*****************************************************************
 * Method:          extract
 * Arguments:       arg -- struct of arguments that were passed in
 * 				    in - input stream from which to extract embedded
 * 				   		data
 *           
 * Returns:      	none.
 * Function:    	retrieves info on image, loads image into a string 
 * 					  and calls extract_data
 *           
*******************************************************************/
char* extract(parms arg, std::ifstream& in)
{

   int loc;  // location in image of embedded data
   // open image file 
   in.open(arg.filename, std::ios_base::binary);
   // error checks
   if (!in.is_open())
   {
      std::cerr << "Error: could not open file" <<  arg.filename<< ".\n" ; 
    exit(3);
   } 

   in.seekg(0,std::ios::end); // goto end of file
   int filesize = in.tellg(); // get file size
   in.seekg(0,std::ios::beg);  // reset position

   char dump[filesize];
   in.read(dump,filesize);

   std::string search((const char *)dump, filesize);
   loc = search.find(str);
   if (loc > filesize || loc < 0)
   {
   		std::cerr << "Error:  no embeded content found";
		exit(4);
   }
   // run extract_data to write the new file embedded inside the image file
   return extract_data(search, loc, filesize);
}
/*****************************************************************
 * Method:         extract_data
 * Arguments:      search -- embedded data
 * 				   loc -- location of md5sum in image
 * 				   filesize -- size of image
 *           
 * Returns:        none
 * Function:       writes data to cwd
 *           
*******************************************************************/
char* extract_data(std::string & search, int loc, int filesize)
{

  struct file_info info;  // instance that retrieves info on file opened
  loc = loc + md5sum_char;  // moves pointer past md5hash
  int next_loc = 0;
  int i=0;  // for loop counter
  for (i=loc; search[i] != '\0'; i++)
  {
	
	info.filename[i-loc] = search[i];
	next_loc = i;
	// ensures loc doesn't get passed EOF
	if(i > filesize)
		break;
  }
  //sets null pointer
  info.filename[i-loc] = search[next_loc+1];
  
  // caps the embedded size to just under a gig of space
  // inserting that much into an image is ridiculous
  // if data that large needs to be embedded another format
  // beyond just an image will need to be used.
  char size[10];

  next_loc+=2; // increment past null pointer
  for (i=next_loc; search[i] != '\0'; i++)
  {
    size[i-next_loc] = search[i];
	if(i > filesize)
		break;
  }
 //converts file size to int
 info.size = atoi(size);
 char write_out[info.size]; // create output data 
 i++;  // increment past the null pointer
 for(int count=0; count < info.size; count++)
 {
 	write_out[count] = search[i+count];
 }
  std::ofstream out ; 
  out.open(info.filename,  std::ios::binary );
  if (!out.is_open())
   {
      std::cerr << "Error: could not create file." << std::endl; 
      exit(3);
   }
  out.write(write_out, info.size);
  out.close();
  return info.filename;

}
/*****************************************************************
 * Method:         extract_data
 * Arguments:      search -- embedded data
 * 				   loc -- location of md5sum in image
 * 				   filesize -- size of image
 *           
 * Returns:        none
 * Function:       writes data to cwd
 *           
*******************************************************************/
void write_log(struct parms argm, char *p)
{
	time_t rawtime; // date n time
	time(&rawtime); // get date/time
	std::ofstream log;
	log.open("log.txt", std::ios::app);

	if (strcmp(argm.action,"embed")==0)
	log << "I've: " <<  argm.action << " " << argm.embed << " into " << argm.output << " on:  " << ctime(&rawtime );
	else
	 log << "I've: " <<  argm.action << "ed the embedded data on: "  << ctime(&rawtime );


	log.close();

}
/*****************************************************************
 * Method:         check_parms
 * Arguments:      struct arg // arguments read in
 *           
 * Returns:        None
 * Function:       Exits out of program is safe checks are not met
 *           
*******************************************************************/
void check_parms(struct parms arg)
{
 // checks all supported image formats
 bool jpg = false,
  	  gif = false,
	  tiff = false,
	  png = false;

 // makes sure that there is an input 
 if (arg.input != '\0')
 {
 // identifies the type of file being passed in.
 if(strstr(arg.input, ".jpg") || strstr(arg.input,".JPG"))
 		jpg = true;
 else if(strstr(arg.input, ".gif") || strstr(arg.input,".GIF"))
 		gif = true;
 else if(strstr(arg.input, ".tiff") || strstr(arg.input,".TIFF"))
 		tiff = true;
 else if(strstr(arg.input, ".png") || strstr(arg.input,".PNG"))
 		png = true;
 else
 {
	std::cerr << "Image format passed in is not supported" << std::endl;
 	exit(7);
 }
 }


 // ensures that the input file is of the same data type as the output file
 if (jpg)
 {
    if (!(strstr(arg.output, ".jpg") || strstr(arg.output, ".JPG")))
	{
		std::cerr << "File Extension mismatch.  Image types must be of the " <<
		"same data type" << std::endl;
		exit(5);
	}
 }
 else if(gif)
 {
    if (!(strstr(arg.output, ".gif") || strstr(arg.output, ".GIF")))
	{
		std::cerr << "File Extension mismatch.  Image types must be of the " <<
		"same data type" << std::endl;
		exit(5);
	}
 }
 else if(tiff)
 {
    if (!(strstr(arg.output, ".tiff") || strstr(arg.output, ".TIFF")))
	{
		std::cerr << "File Extension mismatch.  Image types must be of the " <<
		"same data type" << std::endl;
		exit(5);
	}
 }
 else if(png)
 {
    if (!(strstr(arg.output, ".png") || strstr(arg.output, ".PNG")))
	{
		std::cerr << "File Extension mismatch.  Image types must be of the " <<
		"same data type" << std::endl;
		exit(5);
	}

 } // end if
} // end function
