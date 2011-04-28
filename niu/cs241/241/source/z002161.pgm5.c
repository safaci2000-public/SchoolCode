/***********************************************************************

	Program:	Assinment 5

	Author:		Samir Faci

	LogonID:	z002161

	Due Date:   10/18/2000



	Function:	manipulate nodes of a linked list.

	Input:		File Redirection.



	Output:



	Notes:		NA



***********************************************************************/



#include <stdio.h>

#include <stdlib.h>





struct lnode

{

 char chfld;

 struct lnode *next;

};



void clrscr();

void prntlink(struct lnode*);

void funcinsert(struct lnode*, struct lnode**);

void funcdelete(char ch, struct lnode**);

void sort(struct lnode **);



/**************************************************************************

Function:	int main();

Arguments:	none

Returns:	integer

Notes:		control the flow of the program.

**************************************************************************/

int main()

{

 struct lnode *newptr, *hdptr;

 char code;

 char ch= 'I';



 hdptr = newptr = NULL;				// set all pointers to NULL

 clrscr();

 scanf("%c", &code);				// reads in code that determines w/h function

									// to call.

 while (code != '0')  // !EOF

	{

	 if (code == 'P' || code == 'p')

		{

		 sort(&hdptr);

		 prntlink(hdptr);

		}

		 scanf("%c", &ch);

		 scanf("%c", &ch);

	 if (code == 'I' || code == 'i')

	 {

		 newptr = (struct lnode*) malloc (sizeof(struct lnode));

		 newptr->chfld = ch;

		 newptr->next = NULL;

		 funcinsert(newptr, &hdptr);

	 }

	 if (code == 'D' || code == 'd')

		  funcdelete(ch, &hdptr);

	 scanf("%c", &code);

	 scanf("%c", &code);

	}

 printf("%c", hdptr->chfld);

 return 1;

}



/**************************************************************************

Function:	clears the screen

Arguments:	none

Returns:	none

Notes:		NA

**************************************************************************/

void clrscr()

{

 system("clear");

}

/**************************************************************************

Function:	insert a node into the linked list

Arguments:	struct lnode *currptr, *newptr, hdptr;

Returns:	nada

Notes:		headache 'till i got the hang of this.

**************************************************************************/

void funcinsert(struct lnode *newptr, struct lnode **hdptr)

{

 struct lnode *currptr;

 currptr = *hdptr;			// sets currptr to head pointer.



 while ( (newptr->chfld < currptr->chfld) && (newptr->chfld > currptr->next->chfld))

 {

  if (currptr->next == NULL)

	break;

  currptr = currptr->next;

 }

	/*  code above gets the location of where the new node should be insert at  */



 if (currptr == *hdptr)

 {



	/* code for beginning of link  */



	newptr->next = *hdptr;

	currptr = newptr;

	currptr->next = *hdptr;

	*hdptr = currptr;

 }





 if (currptr->next == NULL)

 {

	 /* code for end of link */



	currptr->next = newptr;

	currptr->next->next = NULL;

	*hdptr = currptr;



 }





 if (currptr != *hdptr && currptr->next != NULL)

 {

	 /* code for middle of link */



	 newptr->next = currptr->next;

	 currptr->next = newptr;



 }



}

/**************************************************************************

Function:	insert a node into the linked list

Arguments:	struct lnode *currptr, *newptr, hdptr;

Returns:	none

Notes:

**************************************************************************/

void funcdelete(char ch, struct lnode **hdptr)

{

 struct lnode *currptr;

 struct lnode *tempnode;		// used in middle & end deletes.



 currptr = *hdptr;



 while (ch != currptr->chfld)

 {

  currptr = currptr->next;

 }

	/*  code above gets the location of where the new node should be deleted at  */



 if (currptr == *hdptr)

 {



	/* code for beginning of link  */



	*hdptr = (*hdptr)->next;

	currptr = *hdptr;		// sets hdptr to the new location of the 1st element.



 }





 if (currptr->next == NULL)

 {



	 /* code for end of link */

	tempnode = *hdptr;

	while ( (tempnode->chfld > ch ) && (tempnode < currptr))

		tempnode = tempnode->next;



	tempnode->next = NULL;

	currptr = *hdptr;	// sets currptr to 1st node of linked list.

 }





 if (currptr != *hdptr && currptr->next != NULL)

 {

	 /* code for middle of link */



	 tempnode = *hdptr;

	 while ( (tempnode->chfld > ch ) && (tempnode < currptr))

		tempnode = tempnode->next;

	 tempnode->next = tempnode->next->next;



 }





}

/**************************************************************************

Function:	prints linked list

Arguments:	struct lnode *currptr, *hdptr;

Returns:	nada

Notes:

**************************************************************************/

void prntlink(struct lnode *hdptr)

{

 struct lnode *tempnode;

 clrscr();



 while (hdptr != NULL)

 {

	 printf("%c  ", hdptr->chfld);

	 hdptr = hdptr->next;

 }

}

