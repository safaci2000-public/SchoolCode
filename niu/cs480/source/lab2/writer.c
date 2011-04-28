/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Dr. Jie Zhou
 * TA:          Joshua Sanders
 * Assign:      Lab 2
 *
 * Purpose:     to alter memory from a shared buffer using 
 *              semaphores to control the flow of the program.
 *                 
 * Notes:       None.
 *                 
*****************************************************************************/
#include "header.h"

void fixmem(char *shm);
char * init(int &semid, int & memid);

int main(void)
{

    struct sembuf mysembuf;

    int semid, memid;  // ids returned by semget and shmget

    char *shm = init(semid, memid);

    system(CLEAR);


	while (strlen(shm) > 0)
 {

    mysembuf.sem_num = 0;   // reader go-go gadget gooo!!!!
    mysembuf.sem_op = -1;	// ie. signal reader
	mysembuf.sem_flg = SEM_UNDO;
    

    if( semop(semid, &mysembuf, 1) < 0)	// perform signal op
    {
        perror("semop reader:  \n");
        exit(6);
    }

    fixmem(shm);             // chops off a single character.
	printf("The semaphores after writing:\t\t");
	printf("sem 0:  %d\tsem 1:  %d\n", semctl(semid, 0, GETVAL, arg), semctl(semid,0,GETVAL,arg));

    mysembuf.sem_num = 1;  // reader go-go gadjet stop!!
    mysembuf.sem_op = 1;	// ie. signal writer
    

    if( semop(semid, &mysembuf, 1) < 0)	// perform wait op
    {
        perror("semop writer:  \n");
        exit(6);
    }
	printf("The semaphores before writing:\t\t");
	printf("sem 0:  %d\tsem 1:  %d\n", semctl(semid, 0, GETVAL, arg), semctl(semid,0,GETVAL,arg));
	if (strlen(shm) <= 0) { printf("writer done, now exiciting!\n"); break;}


 }
    printf("Catch you later Alligator!!\n");
    return 0;

}

/*****************************************************************************
 *  Prototype: 			void fixmem(char *shm)
 *
 *  Function:			shops off a single character off the shared mem buffer
 *
 *  Parameters:			char *shm  pointer to shared mem
 *
 *	Returns:			None.
 *
 ****************************************************************************/
void fixmem(char *shm)
{
    if (strlen(shm) >  0) *(shm+(strlen(shm) -1))  = '\0';

	sleep(1);

}
/*****************************************************************************
 *  Prototype: 			char * init(int& semid, int& memid);
 *
 *  Function:			initializes semaphores and shared memory
 *
 *  Parameters:			semid:		id returned by semget
 *						memid:		id returned by shmget
 *
 *	Returns:			shm:		pointer to shared memory
 *
 ****************************************************************************/

char * init(int &semid, int &memid)
{

		// memflag and semflag are flags setup
		// specifically to be used in conjunction
		// with semget() and shmget()
    int memflag = SHM_R | SHM_W; 
    int semflag = SEM_R | SEM_A | IPC_CREAT;

	char * shm = ""; // pointer to shared memory

// semaphores initialization / error checking *********


    if ((semid = semget(key1, 2, semflag)) < 0)
    {
        perror("semget: semget failed");
        exit(1);
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
	return shm;
}
