/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Dr. Jie Zhou
 * TA:          Joshua Sanders
 * Assign:      Lab 2
 *
 * Purpose:     To read memory from a shared buffer using 
 *              semaphores to control the flow of the program.
 *                 
 * Notes:       None.
 *                 
*****************************************************************************/
#include "header.h"



char *  init(int &semid, int& memid);
int main(void)
{
    struct sembuf mysembuf;


    int semid, memid;	// ids retuned by semget and shmget

    char * buffer = "All work and no play makes jack a dull boy.";
    char *shm = ""; // pointer to shared memory
	int cnt = 3;    // runs loop for 3 more iteration allowing writers to exit
					// without causing any errors ie. extra credit 
					//	implementation.
    system(CLEAR);	// guess??  maybe, possibly...it clears the screen?



	shm = init(semid, memid); // initializes semaphores
												// and shared mem
    strcpy(shm, buffer);	// copy buffer to shared mem


	mysembuf.sem_flg = SEM_UNDO; // locks out other writers

	printf("%s\n", shm); 		//prints initial shared memory string
    while (strlen(shm ) > 0)
{

    
    mysembuf.sem_num = 1;        // sets up the writer
    mysembuf.sem_op = -1;        // semaphore to active
    
 

    if (semop(semid, &mysembuf,1) < 0 )	// performs signal op
    {
        perror("semop:  ");
        exit(7);
    }


	printf("%s\n", shm);		// prints shared memory

   	if (strlen(shm) <= 0) { cnt--; sleep(2); } // extra credit

	if ( strlen(shm) <= 0 && cnt <= 0 )			// code
			break;


    mysembuf.sem_num = 0;        // sets reader semaphore to wait.
    mysembuf.sem_op = 1 ;        // if set to 0 it waits
    
   
	if(semop(semid, &mysembuf, 1) < 0)	// wait operation
    {
        perror("semop:  ");
        exit(6);
    }

}
    shmctl(memid, IPC_RMID, NULL);		// cleans up shared memory
    semctl(semid,1,IPC_RMID, NULL);		// clearns up semaphores

	printf("reader now exiting...thank you for using a product the NIU CS curriculum,\nhave a good day :->\n");


    return 0;

}
/*****************************************************************************
 * Prototype:   	char * init(int &, int &)
 * 
 * Function:		deals with initialization and error checking of
 *					semaphores and shared memory.
 *
 * Parameters:		semid:		semaphore id
 *					memid:		shared mem id
 *
 * Returns:			shm:		pointer to shared mem
 *
 * Notes:			None
*****************************************************************************/
char * init(int &semid, int& memid)
{
	char * shm;  // shared mem buffer pointer


		// memflag and semflag are flags setup specifically
		// to be used in conjunction with semget and shmget
    int memflag = SHM_R | SHM_W | IPC_CREAT;
	int semflag = SEM_R | SEM_A | IPC_CREAT;


// semaphores initialization / error checking *********

    if ((semid = semget(key1, 2, semflag)) == -1)
    {
        perror("semget: semget failed");
        exit(1);
    }

	arg.val = 1;
    if (semctl(semid, 0, SETVAL, arg) < 0)
    {
        perror("semctl():  set sem0");
        exit(2);
    }

    arg.val = 0;

    if (semctl(semid, 1, SETVAL, arg) < 0)
    {
        perror("semctl(): set sem1");
        exit(3);
    }



// ************ shared memory intilization/error checking *****

    memid = shmget(key2, MAXSIZE, memflag);

    if (memid < 0)
    {
        perror("shmget:  shmget failed");
        exit(4);
    }
    
    shm = (char *) shmat(memid, NULL, 0);    // returns address of shared
                                    // memory location.
    if (shm < 0)
    {
        perror("shmat():  ");
        exit(5);
    }


	return shm;	// returns pointer to the acquired shared memory


}
