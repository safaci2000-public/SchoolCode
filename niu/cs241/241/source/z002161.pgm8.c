/***********************************************************************
Program:			Assinment 8
Author:			Samir Faci
LogonID:			z002161
Due Date:   	11/13/00

Function:   	creates and prints a binary search tree.
		and calculates other features of the tree.

Input:	    	file redirections.

Output:     	to screen

Notes:

***********************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <sys/ddi.h>

struct lnode
{
 int data;											// hold data
 struct lnode *leftptr;							// points to left node.
 struct lnode *rightptr;						// points to right node.
 };

void prepare(struct lnode **newptr);		// allocates mem for struct.
void buildTree(struct lnode **, int );		// builds binary tree.
void printPreorder(struct lnode*);			// prints tree using Preorder Traversal
void printInorder(struct lnode*);			// prints tree using Inorder Traversal
void printPostorder(struct lnode*);			// prints tree using Postorder Traversal
void printPostorder2(struct lnode*, 
					 struct lnode *array[]);	// prints tree using a nonrecursive postorder traversal.
int nodes(struct lnode*);						// counts the # of nodes in tree.
int height(struct lnode*);						// calculates the height of the tree.
int leaves(struct lnode*);						// calculates the # of leaves of the tree.
int push(struct lnode *array[], int count, struct lnode *);		// pushes an address onto the stack.
int pop(struct lnode *array[], int count);						// pops an address off the stack.


/**************************************************************************
Function:	int main();
Arguments:	none
Returns:	integer
Notes:		control the flow of the program.
**************************************************************************/

int main()

{
 struct lnode *hdptr= NULL;       	// hdptr used to store root of tree.
 char ch = '\0';			// pauses program.
 struct lnode *array[50];

 int dat = 9;	  			// temp int used to store data.

 system("clear");		    				// clears the screen.

 fflush(stdin);
 
 while (scanf("%d", &dat) !=EOF)
	{
		fflush(stdin);
		buildTree(&hdptr, dat);				// function builds tree.
		fflush(stdin);
		
	}
 system("clear");
 printf("Preorder Traversal Using Recursive:  \t");
 printPreorder(hdptr);
 printf("\nInorder Traversal Using Recursive:  \t");
 printInorder(hdptr);
 printf("\nPostorder Traversal Using Recursive:  \t");
 printPostorder(hdptr);
 printf("\nPostorder Traversal without Recursion:  \t"); 
// printPostorder2(hdptr, array);

 dat = height(hdptr);
 printf("\n\nHeight: \t\t %d", dat);
// dat = leaves(hdptr);
 printf("\nLeaves: \t\t %d", dat);
 dat = nodes(hdptr);
 printf("\nNodes: \t\t %d", dat);

 printf("\n\n\n\n Press any key to continue");
 fflush(stdin);
 scanf("%c", &ch);
 fflush(stdin);
 system("clear");
 printf("Program Terminated\n"); 
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
 *newptr =(struct lnode *) malloc (sizeof(struct lnode*));
}


/**************************************************************************
Function:	Builds Binary Search Tree.
Arguments:	struct lnode **head  = pointer to root of tree / subtree.
			int data = holds data to be stored in new node.
Returns:	none but head (hdptr) is changed.
Notes:
**************************************************************************/

void buildTree(struct lnode **head, int data)
{
 struct lnode *newptr;

 if ( *head == NULL)
	{
	 prepare(&newptr);
	 newptr->data = data;
	 *head = newptr;
	 (*head)->leftptr = (*head)->rightptr = NULL;
	}

 if ( data > (*head)->data )
	{
	 buildTree(&(*head)->rightptr, data);
	}
 if ( data < (*head)->data )
	buildTree(&(*head)->leftptr, data);
}

/**************************************************************************
Function:	prints binary search tree using recursion in an preorder traversal.
Arguments:	struct lnode **head  = pointer to root of tree / subtree.
Returns:	none but ouputs tree to screen.
Notes:
**************************************************************************/
void printPreorder(struct lnode *hdptr)
{
 printf("%d  ", hdptr->data);

 if (hdptr->leftptr != NULL)
	printPreorder(hdptr->leftptr );
 if (hdptr->rightptr != NULL)
	printPreorder(hdptr->rightptr );
		
}
/**************************************************************************
Function:	prints binary search tree using recursion in an Inorder traversal
Arguments:	struct lnode **head  = pointer to root of tree / subtree.
Returns:	none but ouputs tree to screen.
Notes:
**************************************************************************/
void printInorder(struct lnode *hdptr)
{
 
 if (hdptr == NULL)
	 return;
 
 printInorder(hdptr->leftptr);
 printf("%d  ", hdptr->data);
 printInorder(hdptr->rightptr);
 
}

/**************************************************************************
Function:	prints binary search tree using recursion in an Inorder traversal
Arguments:	struct lnode **head  = pointer to root of tree / subtree.
Returns:	none but ouputs tree to screen.
Notes:
**************************************************************************/
void printPostorder(struct lnode *hdptr)
{
 if (hdptr == NULL)
	 return;
 
 printPostorder(hdptr->leftptr); 
 printPostorder(hdptr->rightptr); 
 printf("%d  ", hdptr->data);
 
}

/**************************************************************************
Function:	pushes in the memory address into the stack.
Arguments:	array==> array of memory address.
				count==> location in array.
				add  ==> new memory address to store in stack
Returns:	location of stack array.
Notes:
**************************************************************************/
int push(struct lnode *array[], int count, struct lnode *add)
{
 array[count] = (struct lnode *) malloc (sizeof(struct lnode *));
 array[count] = add;
 
 return ++count;
}

/**************************************************************************
Function:	pops out the memory address out of the stack.
Arguments:	array ==> array of struct lnode pointer,
			count ==> keeps track of location within the array.
Returns:	count ==> next open location in array.
Notes:
**************************************************************************/
int pop(struct lnode *array[], int count)
{
 array[count] = NULL;
 count--;

 return count;
}
/**************************************************************************
Function:	prints tree using Post order traversal w/o recursion.	
Arguments:	hdptr ==> the root of the tree.
				array[] ==> holds the address of each node..aka array stack.
Returns:		none...but outputs to screen.
Notes:		
**************************************************************************/
void printPostorder2(struct lnode *hdptr, struct lnode *array[])
{
 
	int location = 0;		// keeps track of location in array.
	int track = 0;			// keeps track and see if right wing of tree has been visited.
	struct lnode *root = hdptr;

	while (hdptr != NULL)
	{

	location = push(array, location, hdptr);
	hdptr= hdptr->leftptr;

	}
	hdptr = array[location-1];
	while (hdptr != root)
	{
		while (hdptr->rightptr != NULL && track != 1)
		{
			location = push(array, location, hdptr->rightptr);
			hdptr = array[location-1];
			if (hdptr->rightptr == NULL)
				track = 1;

		}
		track = 0;
		printf("%d  ", array[location-1]->data);
		location = pop(array, location);
		hdptr = array[location-1];
	}
			/* code above visits left side of tree */



	location = 0;
	array[0] = NULL;
	track = 0;
	
			/* code above resets variables */

	while (hdptr != NULL)
	{

	location = push(array, location, hdptr);
	hdptr= hdptr->rightptr;
	while (hdptr->leftptr != NULL && track != 1)
		{
			 location = push(array, location, hdptr->leftptr);
			 hdptr = array[location-1];
			 if (hdptr->leftptr == NULL)
				 track = 1;
		}
		track = 0;
	}
	
	hdptr = array[location-1];
	while (hdptr != root)
	{
	
	printf("%d  ", array[location-1]->data);
	location = pop(array, location);
	hdptr = array[location-1];  
	
	}
		/* code above visits right side of tree */
	
	printf("%d  ", root->data);	
	
		/* code above prints the root node */

}
/**************************************************************************
Function:	calculates the # of nodes in the tree.
Arguments:	hdptr  == head pointer w/h points to root of tree.
Returns:	number of nodes.
Notes:
**************************************************************************/
int nodes(struct lnode *hdptr)
{
  static int counter = 0;		// keeps track of # of nodes.
 
  if (hdptr == NULL)
	 {
	  return counter;
	  
	 }
 
 nodes(hdptr->leftptr);
 counter++;
 
 nodes(hdptr->rightptr);
 
 
 return counter;
}
/**************************************************************************
Function:	calculates the height of the tree.
Arguments:	hdptr  == head pointer w/h points to root of tree.
Returns:	height of tree.
Notes:
**************************************************************************/
int height(struct lnode *hdptr)
{
  if (hdptr == NULL)
	   return 0;
	 
else 
	return (  max (1 + height (hdptr->leftptr) ,1 + height (hdptr->rightptr)));

}

/**************************************************************************
Function:	calculates the # of nodes in the tree.
Arguments:	hdptr  == head pointer w/h points to root of tree.
Returns:	number of nodes.
Notes:
**************************************************************************/
 int leaves(struct lnode *hdptr)
 {
   if (hdptr->rightptr == NULL && hdptr->leftptr == NULL )
   	return 1; 
   
   else
      return (leaves (hdptr->rightptr) + leaves (hdptr->leftptr) );
      
 }
