/***********************************************************************
Program:	Assinment 7
Author:		Samir Faci
LogonID:	z002161
Due Date:   10/25/2000

Function:   creates and prints a binary search tree.

Input:	    file redirections.

Output:     to screen

Notes:

***********************************************************************/
#include <stdio.h>
#include <stdlib.h>


struct lnode
{
 int data;									// hold data
 struct lnode *leftptr;						// points to left node.
 struct lnode *rightptr;					// points to right node.
 struct lnode *prev;						// points to prev. node.
};

void prepare(struct lnode **newptr);		// allocates mem for struct.
void buildTree(struct lnode **, int );		// builds binary tree.
void printTree(struct lnode *);				// prints binary tree.

/**************************************************************************
Function:	int main();
Arguments:	none
Returns:	integer
Notes:		control the flow of the program.
**************************************************************************/

int main()
{
 struct lnode *hdptr;       				// hdptr used to store root of tree.

 int dat;		    						// temp int used to store data.

 system("clear");		    				// clears the screen.


 prepare(&hdptr);
											// function above allocates memory to node.

 fflush(stdin);		    					// flushes the stdin stream.
 scanf("%d", &dat);	    					// reads in the character.
 fflush(stdin);

 if (EOF)
	{
	 printf("invalid/corrupt data detected...program terminated. \n");
	 exit(0);
	}	   // code checks for empty data file.

 hdptr->data = dat;
 hdptr->leftptr = NULL;
 hdptr->rightptr = NULL;
 hdptr->prev = NULL;
		  // code above reads in root node.	

 fflush(stdin);
 while (scanf("%d", &dat) != EOF)
	{
		fflush(stdin);				
		buildTree(&hdptr, dat);				// function builds tree.
		fflush(stdin);
	}
 printTree(hdptr);
 return 0;
}


/**************************************************************************
Function:	allocates memory to struct.
Arguments:	struct lnode **newptr
Returns:	address of allocated memory.
Notes:
**************************************************************************/

void prepare(struct lnode **newptr)
{
 *newptr =(struct lnode **) malloc (sizeof(struct lnode));
}


/**************************************************************************
Function:	inserts link in node at the right of tree.
Arguments:	struct lnode **head, int data
Returns:	node but head (hdptr) is changed.
Notes:
**************************************************************************/

void buildTree(struct lnode **head, int data)
{
 struct lnode *newptr, *currptr, *temp;
 currptr = *head;
 prepare(&newptr);
 newptr->data = data;

 if (data < (*head)->data)
 {
	 while(currptr != NULL)
	 {
		 temp = currptr;
		 currptr = currptr->leftptr;
		 newptr->prev = temp;
		 currptr->prev = temp;
		 newptr->leftptr = NULL;
		 newptr->rightptr = NULL;
	 }

	 if (data <= currptr->prev->data)
		 newptr->prev->leftptr = newptr;

	 else if (data > currptr->prev->data)
	 {
		 while (data > currptr->prev->data)
			{
			 currptr = currptr->prev;
			 temp = currptr;
			}
		 newptr->leftptr = NULL;
		 newptr->rightptr = NULL;
		 newptr->prev = temp;
		 currptr->rightptr = newptr;
	 }
	 else
	 {
		 currptr = newptr;
	 }

 }

	/* code above inserts node at left branch of tree */

 if (data > (*head)->data)
 {
	 while (currptr != NULL)
	 {
		 temp = currptr;
		 currptr = currptr->rightptr;
		 newptr->prev = temp;
		 currptr->prev = temp;
		 newptr->leftptr = NULL;
		 newptr->rightptr = NULL;
	 }

	 if (data >= currptr->prev->data)
		 newptr->prev->rightptr = newptr;
	 else if (data < currptr->prev->data)
	 {

		 while (data < currptr->prev->data)
			{
			 currptr = currptr->prev;
			 temp = currptr;
			}
		 newptr->leftptr = NULL;
		 newptr->rightptr = NULL;
		 newptr->prev = temp;
		 currptr->leftptr = newptr;
	 }
	 else
	 {
		 currptr = newptr;
	 }
 }
		/* code above inserts node at right branch of tree. */

}

/**************************************************************************
Function:	prints tree in inorder.
Arguments:	struct lnode *head
Returns:	nonde.
Notes:		guess i was supposed to use recursion here...couldn't figure out
			how.
**************************************************************************/
void printTree(struct lnode *hdptr)
{
 
 while (hdptr->leftptr != NULL)
	hdptr = hdptr ->leftptr;
 printf("%d  \n", hdptr->data);
 while (hdptr->prev != NULL)
	{
	 hdptr = hdptr->prev;
	 if (hdptr->rightptr != NULL)
		 printf("%d", hdptr->rightptr->data);
	 printf("%d  \n", hdptr->data);
	}

	hdptr = hdptr->prev;
	printf("%d", hdptr->rightptr->data);

  while (hdptr->rightptr != NULL)
	{
		hdptr = hdptr ->rightptr;
		if (hdptr->leftptr != NULL)
			printf("%d \n", hdptr->leftptr->data );
		printf("%d\n", hdptr->data);
	}


}