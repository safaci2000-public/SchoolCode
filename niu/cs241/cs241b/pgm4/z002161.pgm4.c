/***********************************************************************
Program:		Assinment 4
Author:			Samir Faci
LogonID:		z002161
Due Date:   	07/27/01

Function:   	creates and prints a binary search tree.
				and calculates other features of the tree.
				It also prints it using pre, in, and post order
				tree traversal.

Input:	    	file redirections.

Output:     	to screen

***********************************************************************/

#include <stdio.h>
#include <stdlib.h>

#define CLEAR "clear"

struct lnode
{
 int data;										// hold data
 struct lnode *leftptr;							// points to left node.
 struct lnode *rightptr;						// points to right node.
 };


		// visited field ommitted since the Extra Credit portion of the
		// program was ommitted.


void prepare(struct lnode **newptr);		// allocates mem for struct.
void buildTree(struct lnode **, int );		// builds binary tree.
void printPreorder(struct lnode*);			// prints tree using Preorder Traversal
void printInorder(struct lnode*);			// prints tree using Inorder Traversal
void printPostorder(struct lnode*, double *avg);// prints tree using Postorder Traversal

int nodes(struct lnode*);						// counts the # of nodes in tree.
int height(struct lnode*);						// calculates the height of the tree.
int leaves(struct lnode*);						// calculates the # of leaves of the tree.
int calcmax(int, int);								// returns the highest of the two values.

/**************************************************************************
Function:	int main();
Arguments:	none
Returns:	integer
Notes:		control the flow of the program.
**************************************************************************/

int main()

{
 struct lnode *hdptr= 0;       	// hdptr used to store root of tree.
 char ch = '\0';					// pauses program.
 struct lnode * array[50] = {0};

 int dat = 9;	  					// temp int used to store data.
 double avg = 0;						// used to store the average value of
									// all the nodes in the tree.

 system(CLEAR);		    			// clears the screen.

 fflush(stdin);
 
 while (scanf("%d", &dat) !=EOF)
	{
		fflush(stdin);
		buildTree(&hdptr, dat);		// function builds tree.
		fflush(stdin);
		
	}
 system(CLEAR);
 printf("Preorder Traversal Using Recursive:  \t");
 printPreorder(hdptr);
 printf("\nInorder Traversal Using Recursive:  \t");
 printInorder(hdptr);
 printf("\nPostorder Traversal Using Recursive:  \t");
 printPostorder(hdptr, &avg);


 dat = height(hdptr);
 dat--;					// decreases height by one since the 
						// height function actually gets the level
						// of the tree instead of the height.


 printf("\n\nHeight: \t\t %d", dat);
 dat = leaves(hdptr);
 printf("\nLeaves: \t\t %d", dat);
 dat = nodes(hdptr);
 printf("\nNodes: \t\t\t %d", dat);
 
 avg /= dat;

 printf("\nAverage: \t\t%4.1f", avg);
 fflush(stdin);
 printf("\n\n\n\nProgram Terminated\n"); 
 printf("Thank you for using a product of the CS241 curriculum\n");
 return 0;
}


/**************************************************************************
Function:	allocates memory to struct.
Arguments:	struct lnode **newptr		points to newly allocated memory.
Returns:	address of allocated memory.
Notes:
**************************************************************************/

void prepare(struct lnode **newptr)
{
 *newptr =(struct lnode *) malloc (sizeof(struct lnode*));
}


/**************************************************************************
Function:	Builds Binary Search Tree.
Arguments:	struct lnode **head  = pointer to root of tree / subtree 
								   (in recurscrion)
			int data = holds data to be stored in new node.

Returns:	none but head (hdptr) is changed.
Notes:
**************************************************************************/

void buildTree(struct lnode **head, int data)
{
 struct lnode *newptr;

  if ( *head == 0)
	{
	 prepare(&newptr);
	 newptr->data = data;
	 *head = newptr;
	 (*head)->leftptr = (*head)->rightptr = 0;
	}


 else if ( data >= (*head)->data && *head != 0)
	{
	 buildTree(&(*head)->rightptr, data);
	}
 else if ( data < (*head)->data && *head != 0)
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

 if (hdptr->leftptr != 0)
	printPreorder(hdptr->leftptr );
 if (hdptr->rightptr != 0)
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
 
 if (hdptr == 0)
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
void printPostorder(struct lnode *hdptr, double* avg)
{
 if (hdptr == 0)
	 return;
 
 printPostorder(hdptr->leftptr, avg); 
 printPostorder(hdptr->rightptr, avg); 
 printf("%d  ", hdptr->data);
 *avg += hdptr->data;

 
}

/**************************************************************************
Function:	to compare to integer values and return the highest of the two.
Arguments:	int val1, int val2 (2 integer values to be compared)
Returns:	the highest of the two values..or val1 if they're equal.

Notes:
**************************************************************************/
int calcmax(int val1, int val2)
{
	if (val1 > val2 )
		return val1;

	else if (val1 < val2)
		return val2;

	else if (val1 == val2)
		return val1;


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
 
  if (hdptr == 0)
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
  if (hdptr == 0)
	   return 0;
	 
else 
	return (  calcmax (1 + height (hdptr->leftptr) ,1 + height (hdptr->rightptr)));

}

/**************************************************************************
Function:	calculates the # of nodes in the tree.
Arguments:	hdptr  == head pointer w/h points to root of tree.
Returns:	number of nodes.
Notes:
**************************************************************************/
 int leaves(struct lnode *hdptr)
 {
   if (hdptr->rightptr == 0 && hdptr->leftptr == 0 )
   	return 1; 
   
   else if (hdptr->rightptr != 0 && hdptr->leftptr == 0)
	   return (leaves (hdptr->rightptr) + 0);

   else if (hdptr->rightptr == 0 && hdptr->leftptr != 0)
	   return (leaves (hdptr->leftptr) + 0);

   else if (hdptr->rightptr != 0 && hdptr->leftptr != 0)
      return (leaves (hdptr->rightptr) + leaves (hdptr->leftptr) );
      
 }
