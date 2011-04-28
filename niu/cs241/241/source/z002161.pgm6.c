/***********************************************************************
	Program:	Assinment 6
	Author:		Samir Faci
	LogonID:	z002161
	Due Date:   10/25/2000

	Function:   creates a circular queue.  and reads in data/prints

	Input:	    file redirections.

	Output:     to screen

	Notes:

***********************************************************************/
#include <stdlib.h>
#include <stdio.h>


#define MAX 10
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
void deletearray(int *, int *, int *);
void modifyarray(char [], char , int ,int *qheadptr,int *qtailptr, int *);

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
 int modify = 0;
 char code;			// code scaned in to perform a certain function.
 char ch;			// character read in.
 char queue[10];

			// begin initialize array
 for (counter = 0; counter < 10; counter++)
	 queue[counter] = 0;
		   // end intialization.
 counter = 0;
 clrscr();

 while (scanf("%c", &code) != EOF)
	{
	 if (code == 'i' || code == 'I')
		{
		  fflush(stdin);
		  scanf("%c", &ch);

		  insertlink(ch, &lheadptr, &ltailptr);
		  insertarray(queue, ch, &qtailptr, &counter);
		}
	 else if (code == 'd' || code == 'D')
		{
		  deletelink(&lheadptr, &ltailptr);
		  deletearray(&qtailptr, &qheadptr, &counter);  /* check for underflow */
		}
	 else if (code == 'p' || code == 'P')
		{
		  printflink(&lheadptr, &ltailptr);
		  printfarray(queue, &qtailptr, &qheadptr, &counter);
		}
	 else if (code == 'm' || code == 'M')
		{
		 fflush(stdin);
		 scanf("%c", &ch);
		 fflush(stdin);
		 scanf("%d", &modify);
		 if (modify != 1 && modify != 2 && modify != 3 && modify != 4)
			printf("Error...invalid input.  only 1, 2, 3 or 4 are valid inputs.\n");
		 if (modify == 1 || modify == 2 || modify == 3 || modify == 4)
			modifyarray(queue, ch, modify, &qheadptr, &qtailptr, &counter);
		}
	 else if (code != 'i' && code != 'I' && code != 'd' && code != 'D' &&
			  code != 'm' && code != 'M' && code != 'p' && code != 'P')
		printf("Error...invalid input detected!!\n");
	 fflush(stdin);
	}

 return 0;
}
/**************************************************************************
Function:	inserts a character into the array.
Arguments:  char array, char, int *, int *
Returns:	none
Notes:
**************************************************************************/
void insertarray(char queue[], char ch , int *qtailptr, int *counter)
{

 if (*counter < 0 || (*counter)  >= 10)
	 printf("Error!!!!  overflow..can not insert anymore items into queue\n");

 if (*counter < 10)
	{
	 if (*qtailptr >=10 )
		*qtailptr = *qtailptr % 10;
	 queue[*qtailptr] = ch;
	 (*qtailptr)++;
	 (*counter)++;
	}


}
/**************************************************************************
Function:	deletes members from char array.
Arguments:  char [], and qtailptr;
Returns:	none
Notes:
**************************************************************************/
void deletearray(int *qtailptr, int *qheadptr, int *counter)
{
 if (*counter > 0 && *counter <= 10)
	{
	 if (*qheadptr >=10)
		*qheadptr = *qheadptr % 10;
	 (*qheadptr)++;
	 (*counter)--;
	}
 if (*counter <= 0)
	 printf("Error!!  underflow encountered");

}
/**************************************************************************
Function:	prints queue
Arguments:  char [], and qtailptr;
Returns:	none
Notes:
**************************************************************************/
void printfarray(char queue[], int *qtailptr, int *qheadptr, int *counter)
{
 int track = 0;
 printf("\nsequential:  ");
 if (*qtailptr < *qheadptr)
   {
	queue[*qtailptr] = '\0';
	for (track = *qheadptr; track <= 9; track++)
		printf("%c  ", queue[track]);
	for (track = 0; track <= *qtailptr; track++)
		printf("%c  ", queue[track]);
   }
 else if (*qtailptr > *qheadptr)
	{
	 queue[*qtailptr] = '\0';
	 for (track = *qheadptr; track <= *qtailptr; track++)
		{
		 printf("%c  ", queue[track]);
		}
	}
 else if (*qtailptr == *qheadptr && *counter > 0)
	{
	 for (track = *qheadptr; track < 10; track++)
		printf("%c  ", queue[track]);
	 for (track = 0; track < *qheadptr; track++)
		printf("%c  ", queue[track]);
	}
}
/**************************************************************************
Function:	modifies char array.
Arguments:  char array, char ch, modify (choice), qheadptr, qtailptr
Returns:	none
Notes:
**************************************************************************/
void modifyarray(char queue[],char ch, int modify,int *qheadptr, int *qtailptr, int *counter)
{
 int movedown;  	// calculates # of slots to move array.
 int remainder;		// used in calculations.
 int track;			// used in for loop
 int counter2 = 0;
 char temp[10] ;

 for (track = 0; track < 10; track++)
	temp[track] = '\0';

 if (*qtailptr < *qheadptr)
   {
	queue[*qtailptr] = '\0';
	for (track = *qheadptr; track <= 9; track++)
		{
		 temp[counter2] = queue[track];
		 counter2++;
		}
	for (track = 0; track <= *qtailptr; track++)
		{
		 temp[counter2] = queue[track];
		 counter2++;
		}
   }
 else if (*qtailptr > *qheadptr)
	{
	 queue[*qtailptr] = '\0';
	 for (track = *qheadptr; track <= *qtailptr; track++)
		{
		 temp[counter2] = queue[track];
		 counter2++;
		}
	}
 else if (*qtailptr == *qheadptr && *counter > 0)
	{
	 for (track = *qheadptr; track < 10; track++)
		{
		 temp[counter2] = queue[track];
		 counter2++;
		}
	 for (track = 0; track < *qheadptr; track++)
		{
		 temp[counter2] = queue[track];
		 counter2++;
		}
	}




 if (modify == 1)
	{
	 queue[*qheadptr] = ch;
	}
 if (modify == 2)
	{
	 queue[(*qtailptr)-1] = ch;
	 queue[*qtailptr] = NULL;
	}
 if (modify == 3)
	{
	 movedown = ((*qheadptr - *qtailptr) / 2) + *qtailptr;
	 *qtailptr += movedown;
	 *qheadptr += movedown;
	 counter2 = 0;
	 for (track = *qheadptr; track < 10; track++)
		{
		 queue[track] = temp[counter2];
		 counter2++;
		}
	 for (track = 0; track <= *qtailptr; track++)
		{
		 queue[track] = temp[counter2];
		 counter2++;
		}
	}
 if (modify == 4)
	{
	 movedown = (((*qheadptr + 10) - *qtailptr)/2) + *qtailptr;
	 counter2 = 0;
	 for (track = *qheadptr; track < 10; track++)
		{
		 queue[track] = temp[counter2];
		 counter2++;
		}
	 for (track = 0; track <= *qtailptr; track++)
		{
		 queue[track] = temp[counter2];
		 counter2++;
		}



	}
}
/**************************************************************************
Function:	inserts a node to the circular linked list.
Arguments:  char ch, lheadptr, and ltailptr
Returns:	none
Notes:
**************************************************************************/

void insertlink(char ch ,struct lnode **lheadptr, struct lnode **ltailptr)
{
 struct lnode *newptr;
 newptr = (struct lnode*) malloc (sizeof(struct lnode));
 newptr->chfld = ch;
 (*ltailptr)->next = newptr;
 *ltailptr = (*ltailptr)->next;
 (*ltailptr)->next = *lheadptr;
}

/**************************************************************************
Function:	clears the screen
Arguments:  none
Returns:	none
Notes:
**************************************************************************/
void clrscr()
{
 system("clear");

}   
/**************************************************************************
Function:	delete last insert node from link
Arguments:  none
Returns:	none
Notes:
**************************************************************************/
void deletelink(struct lnode **lheadptr, struct lnode**ltailptr)
{


 if ((*lheadptr)->next !=NULL && (*lheadptr) != (*lheadptr)->next)
	{
	 *lheadptr = (*lheadptr)->next;
	 (*ltailptr)->next = *lheadptr;
	}
 else
	printf("Error!!!  invalid input detected \n");
}
/**************************************************************************
Function:	prints current linked list to screen.
Arguments:  lheadptr & ltailptr
Returns:	none
Notes:
**************************************************************************/
void printflink(struct lnode **lheadptr, struct lnode**ltailptr)
{
 struct lnode *currptr;
 printf("\f");
 clrscr();
 printf("linked:  ");
 currptr = (*lheadptr)->next;
 while(currptr != *ltailptr)
	{
	 printf("%c  ", currptr->chfld);
	 currptr = currptr->next;
	}
 if (*lheadptr != (*lheadptr)->next)
	{
	 printf("%c  \n", currptr->chfld);
	}
}
