#ifndef FINGER_H
#define FINGER_H

#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <math.h>
#include <tiffio.h>
#include <sstream>
#include <sys/types.h>
#include <dirent.h>
#include <errno.h>
#include <vector>
#include <string>
#include <mpi.h>
#include <ctime>

//Data Struct  used when reading and writing tiff image
struct field_data
{
    int width;
    int height;
    uint16  bitssample;
    uint16 sampleperpixel;
    uint32 rowsperstrip;
    float x_res;
    float y_res;
    field_data() 
    { 
       width = height = 0; 
       bitssample = sampleperpixel = 0;
       x_res = y_res = 0; 
    }
};  
typedef unsigned char u_char;

class finger
{
    private:
        bool bin_flag;
        TIFF *in,           // input image 
             *out;          // binary image
        long long npixels;    // count of number of pixels in image
        unsigned char * raster;    // array which holds all pixels in image
        unsigned int width, height; // 
        bool * hild;        // bool array which tracks checked pixels using hilditch algo.
        bool * unique;      // Bool Array storing the location of unique marks in print being analyzed/searched for.
        field_data attr;   // struct which retrieves various info
                           // on image.
        bool emptyid;
        const int binMid;
        bool *left;
        bool *right;
	    std::vector<int> list;
        void traverse(int node);
        //Methods
        
        //Hild Algo
        void hildTest(int loc);
        int Xh(int count );
        //MPI Data
        
        static char *processor_name;
        static int numprocs, rank, namelen;
        void merge(unsigned char*, unsigned char*);
        void mergethin(unsigned char*, unsigned char*);
        bool isLeaf(int id);
        void insertStrip(u_char * data, int ,int );

    public:
        static double bintime, thintime;
        int id;
        static int xid;
        finger();
        ~finger();
        finger(std::string input, std::string binary= "err", std::string final="err");
        bool empty();
        void setEmpty();
        void load(std::string input, std::string binary= "err", std::string final="err");
        void readImage(std::string in);
        void writeImage(std::string image);
        void binarize(int cpuid, int numCores);
        void thinning(int rank, int numprocs);
        unsigned char * getRaster();
        long long getPixels();

static void parallelize(int _num, int _cpu, int _namelen, char *pname)
        {
            numprocs  = _num;
            rank = _cpu;
            namelen = _namelen;
            
        }
};
#endif

