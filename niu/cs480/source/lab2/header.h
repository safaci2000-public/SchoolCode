#define FREEBSD		//	defines which OS the program is being compile
					// on.	if FreeBSD dont need to redefine union semun	
//#define MP		// if MP redefine the union.

#include <sys/types.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <sys/ipc.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

const key_t key1 = 2161;		// semaphore key
const key_t key2 = 2162;		// memory key.

const size_t MAXSIZE = 1024;	// limits shared mem size to 1 k.

const char* CLEAR = "clear";	// const string to clear the screen

#ifdef MP						// if MP define union.
union semun
{
	int val;
	struct semid_ds *buf;
	ushort *array;
};
#endif

static union semun arg;			// define static union instance since
								// it will be used by both reader and writer
								// program

