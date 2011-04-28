/***********************************************************************
	Program:	Assinment 3
	Author:		Samir Faci
	LogonID:	z002161
	Due Date: 07/18/2001

	Function:   creates a circular queue.  and reads in data/prints
		    			using both array and linked list format.

	Input:	    file redirections.

	Output:     to screen

	Notes:

***********************************************************************/
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define CLEAR  "clear"	// changed accordingly depending on the OS used.


#define MAX 10

static int tracker = 0;
struct lnode
	{
	 char chfld;
	 struct lnode *next;
	};

void clrscr();
void insertarray(char [], char , int *, int *);
void insertlink(char ,struct lnode **, struct lnode **);
void deletelink(struct lnode **, struct lnode**);
void printflink(struct lnode**, struct lnode**);
void printfarray(char [], int *, int *, int *);
void deletearray(int *, int *, int *, char []);
void modifyarray(char [], char , char ,int *qheadptr,int *qtailptr);



/**************************************************************************
Function:	int main();
Arguments:	none
Returns:	integer
Notes:		control the flow of the program.
**************************************************************************/


int main()
{
 struct lnode *lheadptr = NULL,
	      *ltailptr = NULL;
 int qheadptr = 0,
     qtailptr = 0;
 int counter = 0;
 char modify = 0;
 char code;		// code scaned in to perform a certain function.
 char ch;		// character read in.
 char junk;		// character used to ignore carriage returns
						 // and or spaces.
 char queue[10] = {0};

 clrscr();

 fflush(stdin);
 while (!feof(stdin))
	{
   fflush(stdin);
   code = getchar();
	 junk = getchar();
	 fflush(stdin);
	 if (code == 'i' || code == 'I')
		{
		  fflush(stdin);
		  ch = getchar();
		
		  fflush(stdin);
		  junk = getchar();
		  insertlink(ch, &lheadptr, &ltailptr);
		  ltailptr->next = lheadptr;						// statement makes the LL circular.
		  insertarray(queue, ch, &qtailptr, &counter);
		}

	 else if (code == 'd' || code == 'D')
		{
		  deletelink(&lheadptr, &ltailptr);
		  deletearray(&qtailptr, &qheadptr, &counter, queue);  /* check for underflow */
		}


	 else if (code == 'p' || code == 'P')
		{
		  printflink(&lheadptr, &ltailptr);
		  printfarray(queue, &qtailptr, &qheadptr, &counter);
		}


	 else if (code == 'm' || code == 'M')
		{
		 fflush(stdin);
		 ch = getchar(); 
		 fflush(stdin);
	   junk = getchar();
		 modify = getchar();

	   junk= getchar();

		 if (modify != '1' && modify != '2' && modify != '3' && modify != '4')
			printf("Error...invalid input.  only 1, 2, 3 or 4 are valid inputs.\n");
		 if (modify == '1' || modify == '2' || modify == '3' || modify == '4')
			modifyarray(queue, ch, modify, &qheadptr, &qtailptr);
		}


	 else if (code != 'i' && code != 'I' && code != 'd' && code != 'D' &&
			  code != 'm' && code != 'M' && code != 'p' && 
			  code != 'P' && code != EOF)
		printf("Error...invalid input detected!!\n");

	 fflush(stdin);

	}

 return 0;
}
/**************************************************************************
Function:	inserts a character into the array.
Arguments:  char array, 		the actual queue
					  char ch,				char to be inserted.
						int *qtailptr		int pointing to the tail
						int *counter		keeps track of # of char. in queue.
Returns:	none
Notes:
**************************************************************************/
void insertarray(char queue[], char ch , int *qtailptr, int *counter)
{

 if (*counter < 0 || (*counter)  >= 10)
	 printf("Error!!!!  overflow..can not insert anymore items into array queue\n");

 if (*counter < 10)
	{
	 if (*qtailptr >=10 )
		*qtailptr = *qtailptr % 10;
	 queue[*qtailptr] = ch;
	 (*qtailptr)++;
	 (*counter)++;
	 tracker = 0;
	}


}
/**************************************************************************
Function:	deletes members from char array.
Arguments:  int *qtailptr			integer with the tail position
					  int *qheadptr			integer with the head position.
					  int *counter,			interger that keeps track of # of slots taken
						char []					  the actual queue.
Returns:	none
Notes:
**************************************************************************/
void deletearray(int *qtailptr, int *qheadptr, int *counter, char queue[])
{

 if (*counter <= 0)
		 printf("Error!!  underflow encountered in array queue\n");


 if (*counter > 0 && *counter <= 10)
	{
	 if (*qheadptr >=10)
		*qheadptr = *qheadptr % 10;
	 queue[*qheadptr] = 0;
	 (*qheadptr)++;
	 (*counter)--;
	}


}
/**************************************************************************
Function:	prints queue
Arguments:  char queue[]		// the actual queue
						int *qtailptr		// points to the tail of the queue
						int *qheadptr		// points to the head of the queue
						int *counter		// tracks # of char inserted in queue.
Returns:	none
Notes:
**************************************************************************/
void printfarray(char queue[], int *qtailptr, int *qheadptr, int *counter)
{
 int print_error = 0;
 int track = 0;
 printf("\nsequential:  ");
 if (*qtailptr < *qheadptr)
   {
	queue[*qtailptr] = '0';
	for (track = *qheadptr; track <= 9; track++)
	{
		printf("%c  ", queue[track]);
		print_error++;
	}
	for (track = 0; track < *qheadptr; track++)
	{
		if (queue[track] == '0')
			printf(" ");		// prints a space in location contains a zero
								// aka the the location is empty.
		else
			printf("%c  ", queue[track]);
		print_error++;
	}
   }


 if ((*qtailptr) > (*qheadptr))
	{
	 queue[*qtailptr] = '0';
	 for (track = *qheadptr; track <= 9; track++)
		{
		 print_error++;
		 if (queue[track] != '0')
			 printf("%c  ", queue[track]);
		 else
			 printf("  ");
		}
	}
 if (*qtailptr == *qheadptr && *counter > 0)
	{
	 for (track = *qheadptr; track < 10; track++)
	 {
		 printf("%c  ", queue[track]);
		 print_error++;
	 }
	 for (track = 0; track < *qheadptr; track++)
	 {
		 printf("%c  ", queue[track]);
		 print_error++;
	 }
	}

 if (print_error == 0)
	 printf("Err:  Array Queue is empty...no data to print!!!\n");

 printf("\n");

}
/**************************************************************************
Function:	modifies char array.
Arguments:  char queue[]		// actual queue
						char ch					// new character w/h replaces the modified char.
					  char modify			// w/h modify alogrithem should be done.
					  int *qheadptr,	// points to head of queue
            int *qtailptr		// points to tail of queue  	
Returns:	none
Notes:
**************************************************************************/
void modifyarray(char queue[],char ch, char modify,int *qheadptr, int *qtailptr)
{
 int position;  	// calculates slot number in queue to be modified for options 3 and 4.



 if (modify == '1')
	{
	 queue[*qheadptr] = ch;
	}
 if (modify == '2')
	{
	 queue[(*qtailptr)-1] = ch;
	 queue[*qtailptr] = '\0';		// NULL
	}

 
 if (modify == '3')
	{
	 if ((*qheadptr) > (*qtailptr))
	 {
		 position = (((*qheadptr) - (*qtailptr)) / 2) + (*qtailptr);
	   printf("%d\n", position);
		 queue[position] = ch;
	 }
	 else
		 printf("Err.  code does not apply here.  head pointer is not greater then tail pointer\n");
	}


 if (modify == '4')
	{
	 if ((*qheadptr) < (*qtailptr))
	 {
		 position = ((((*qheadptr) + 10) - (*qtailptr)) / 2) + (*qtailptr);
		 queue[position] = ch;
	 }
	 else
		 printf("Err.  code does not apply here.  head pointer is not smaller then tail pointer\n");
	 

	}
}

/**************************************************************************
Function:	clears the screen
Arguments:  none
Returns:	none
Notes:
**************************************************************************/
void clrscr()
{
 system(CLEAR);

}   
/**************************************************************************
Function:	inserts a node to the circular linked list.
Arguments:  char ch		// char. to be inserted in queue
						lheadptr	// points to head of queue.
						ltailptr	// points to tail of queue.
Returns:	none
Notes:		  it's a circular linqued list and a circular queue.
PS.					it also uses recursion.
**************************************************************************/

void insertlink(char ch ,struct lnode **lheadptr, struct lnode **ltailptr)
{
 struct lnode *newptr;

 if ((*lheadptr) == (*ltailptr) && ((*ltailptr) != NULL))
 {
   newptr = (struct lnode*) malloc (sizeof(struct lnode));
   newptr->chfld = ch;
   newptr->next = NULL;

  (*lheadptr)->next = newptr;
   *ltailptr = (*lheadptr)->next;
 }
 else if (*ltailptr != NULL)
 {
  insertlink(ch, &(*lheadptr)->next, &(*ltailptr));
 }

 if ((*lheadptr) == NULL)
 {
   newptr = (struct lnode*) malloc (sizeof(struct lnode));
   newptr->chfld = ch;
   newptr->next = NULL;

   *lheadptr = newptr;
   (*lheadptr)->next = (*lheadptr);
   *ltailptr = (*lheadptr)->next;
 }




}
/**************************************************************************
Function:	delete last insert node from link
Arguments:  lheadptr		// points to head of queue
						ltailptr		// points to tail of queue.
Returns:	none
Notes:
**************************************************************************/
void deletelink(struct lnode **lheadptr, struct lnode**ltailptr)
{
 struct lnode *tempnode = NULL;  // used to point to node to be deleted.
 int went_in_loop = 0;			// used to ommit a loop.

 if ((*lheadptr) == NULL)
 {
	printf("Error!!  underflow encountered in linked list queue \n");
 }
 if (((*lheadptr) != NULL) && ((*lheadptr)->next != (*lheadptr)))
 {
	went_in_loop++;
	if ((*lheadptr)->next != NULL)
	{
		tempnode = (*lheadptr);
		(*lheadptr) = (*lheadptr)->next;
		(*ltailptr)->next = (*lheadptr);
		free (tempnode);

	}
	else
	{
		free(*lheadptr);
		(*lheadptr) = NULL;
	}


 }
 if (*lheadptr != NULL)
 {
	if ((*lheadptr)->next == (*lheadptr) && went_in_loop == 0)
	 {
		 free(*lheadptr);
		 (*lheadptr) = NULL;
		 *ltailptr = *lheadptr;

	 }
 }
 

}
/**************************************************************************
Function:	prints current linked list (circular queue) to screen.
Arguments:  lheadptr		// points to head of queue
						ltailptr		// points to tail of queue.
Returns:	none
Notes:
**************************************************************************/
void printflink(struct lnode **lheadptr, struct lnode**ltailptr)
{
 struct lnode *currptr;		// used to traverse queue.


 clrscr();
 printf("\nlinked:  ");

 if ((*lheadptr) != NULL)
 {
	 currptr = (*lheadptr);
	 while(currptr != (*ltailptr))
		{
		 printf("%c  ", currptr->chfld);
		 currptr = currptr->next;
		}

	  if (currptr == *ltailptr)
	  {
		  printf("%c  ", (*ltailptr)->chfld);
	  }
 }

 if ((*lheadptr) == NULL)
 {
	 printf("Err:  Linked List Queue is empty...no data to print!!!\n");
 }



}
