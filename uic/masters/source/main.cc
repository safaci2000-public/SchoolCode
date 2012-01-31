/****************************************************************************
 * Things to note:  White pixel = 255, black pixel is 0
 *
 *      OTSU algorithm was initially used for this application.  It was 
 *  ommited in this application to avoid floating point math in order 
 *  to better benchmark the parallization due to limitation of the hardware
 *  available.
 *
 *  source folder:   fingerdb/
 *  destination folder: outdb/
 *      
 *  Further documentations available in the doc/ folder.
*****************************************************************************/
#include "finger.h"
#include <mpi.h>
#include <iostream>
#include <stdio.h>
#include <sstream>
using std::cout;
using std::cin;
using std::cerr;
using std::endl;

int getdir (std::string dir, std::vector<std::string> &files);
void search(const std::vector<std::string>& , const finger& src, int start, int end, finger dst[], struct searchData& );
void process(const std::vector<std::string>& files, int filesCount, int core, int numprocs, finger dst[]);
int numprocs, rank, namelen;

int main(int argc, char * argv[])
{

    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int searchCount=0;

    std::vector<std::string> files = std::vector<std::string>();  
    //Reading source directory.
    if ( getdir("fingerdb",files) != 0)
    {
        std::cerr << "error, could not open directory, \"fingerdb\"";
        exit(-1);
    }

    sort(files.begin(), files.end());

    MPI_Init(&argc,&argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Get_processor_name(processor_name, &namelen);

    //Sets data varialbe to class so they can be access from within
    //finger object files.
    finger::parallelize(numprocs, rank, namelen, processor_name);

    finger dst[files.size()];

    //binarize and thins the image
    clock_t tstart, tend;
    if(rank == 0) 
    {
      tstart = clock();
      process(files, files.size() , rank, numprocs, dst) ;
      tend = clock();
      std::cout << " processing 49 images for core 0 including communication  and calculations took:  " << std::setprecision(5) << (((double) (tend - tstart)) / CLOCKS_PER_SEC) << std::endl;
        std::cout << "bintime for core 0: " << finger::bintime << std::endl;
        std::cout << "thintime for core 0: " << finger::thintime << std::endl;
    }
    else 
    {
      tstart = clock();
      process(files, files.size() , rank, numprocs, dst) ;
      tend = clock();
      std::cout << " processing 49 images for core " << rank << " including communication  and calculations took:  " << std::setprecision(5) << (((double) (tend - tstart)) / CLOCKS_PER_SEC) << std::endl;
        std::cout << "bin time for core " << rank << ": " << finger::bintime << std::endl;
        std::cout << "thin time for core " << rank << ": " << finger::thintime << std::endl;
    }

    // write all images process to the outdb/ folder
    if(rank == 0)
    {
        for(int i=0; i < files.size(); i++)
        {
            std::ostringstream o;
            std::string out;
            o << i;
            out = "outdb/test" + o.str() + ".tif";
            dst[i].writeImage(out);
        }
    }

    MPI_Finalize();

    return 0;

}
/******************************************************************************
 * Name:       getdir()
 * Function:   reads all the files in a specific directory and returns a 
 *             vector of all the files obtained.
 * parms:      string dir - directory to search
 *              files     - vecotor of files in directory
 * Returns:    errorcode, 0 on success 
 * ***************************************************************************/
int getdir (std::string dir, std::vector<std::string> &files)
{
    DIR *dp;
    struct dirent *dirp;
    if((dp  = opendir(dir.c_str())) == NULL) 
    {
        cout << "Error(" << errno << ") opening " << dir << endl;
        return errno;
    }

    while ((dirp = readdir(dp)) != NULL) 
    {
        // crappy filtering 
        std::string tmp =  std::string(dirp->d_name);
        if(tmp[tmp.length()-1] == 'f') 
            files.push_back(std::string(dirp->d_name));
    }
    closedir(dp);
    return 0;
}
/******************************************************************************
 * Name:       process
 * Function:   binarizes and thins a tiff image writing the output to outdb/
 * parms:      files:   vector of all files to be analyzed
 *             fileCount: number of files.
 *             core:      cpu core currently working on.
 *             numprocs:  number of cores available.
 *             dst:       array of images
 * Returns:    none.
 * Notes:       
 * ***************************************************************************/
void process(const std::vector<std::string>& files, int filesCount, int core, int numprocs, finger dst[])
{

    std::string result;
    bool flag;

    for (unsigned int i = 0; i < filesCount; i++)
    {
        std::ostringstream o;
        std::string tmp = "fingerdb/" + files[i];

        flag = dst[i].empty();
        if(flag == false)
        {
            dst[i].readImage(static_cast<std::string>(tmp) );
            dst[i].setEmpty();
        }
        // binarize
        std::string out;
        o << i;
        out = "outdb/test" + o.str() + ".tif";


        dst[i].binarize(core, numprocs);
        // thinning
        dst[i].thinning(core, numprocs);

   }

}
