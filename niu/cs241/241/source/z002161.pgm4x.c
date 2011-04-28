#include <stdio.h>
#include <math.h>
#include "z002161.pgm4.h"

/************************************************************************
Function:  gets the string length
Argumetns: str1
Returns:   int ...length of string.
Notes:     none
************************************************************************/
int mystrlen(char *str1)
{
 int lenght = 0;
 char *pointer;
 *pointer = *str1;

 while (*pointer != '\0' && *pointer++ != '\0')
	{
	 pointer++;
	 lenght++;
	 if (*pointer == '\0' || *pointer == '\0')
		break;
	}
	lenght *= 2;
 return lenght;
}


/************************************************************************
Function:  copies a string into another string.
Argumetns: srcptr, destptr
Returns:   int (not sure why we have to return an int)
Notes:     none
************************************************************************/
int mystrngcpy (char *srcptr, char *destptr)
{
 static int counter=0;
 while (*destptr ++ = *srcptr++);
 counter++;
 return counter;
}


/************************************************************************
Function:  copies a string into another string.
Argumetns: srcptr, destptr
Returns:   int (not sure why we have to return an int)
Notes:     none
************************************************************************/
int mystrngncpy (const char *srcptr, const char *destptr, int n_size)
{
 static track = 0;
 int counter = 0;
 int sizesrc = 0,
	  sizedst = 0;
 char *src,
      *dst;
 src = srcptr;
 dst = destptr;
 sizesrc = mystrlen(srcptr);
 sizedst = mystrlen(destptr);
	 if (abs(n_size) > abs(sizedst))
		sizedst = abs(n_size);
	 if (n_size > 0)
	 {
		 for (counter = n_size; counter <=sizesrc; counter++)
		  {	dst[counter] = src[counter];  }
	 }
	 if (n_size < 0)
	 {
		for (counter = (sizedst + n_size); counter <= sizesrc; counter++)
			dst[counter] = src[counter];
	 }
	 dst[counter] = '\0';
 track++;
 return track;
}

/************************************************************************
Function:  compares two strings.
Argumetns: char *strng1ptr, char *strng2ptr
Returns:   int
Notes:     returns one if they are equal...0 if they're not.
************************************************************************/
int mystrngcmp (const char *strng1ptr, const char *strng2ptr)
{
 char *str1,
		*str2;
 int answer = 0;
 int size1, size2;  // length of each string;
 int counto;		  // counts to value of variable
 int counter;  	  // used in for loop.
 str1 = strng1ptr;
 str2 = strng2ptr;
 size1 = mystrlen(str1);
 size2 = mystrlen(str2);

 if (size1 > size2)
	counto = size1;
 if (size1 <= size2)
	counto = size2;

 for ( counter = 0; counter <= counto; counter++)
 {
  if (str1[counter] > str2[counter])
		{
		 answer = 1;
		 break;
		}
  if (str2[counter] > str1[counter])
		{
		 answer = -1;
		 break;
		}
  if (str1[counter] == '\0' && str2[counter] == '\0')
		{
		 answer = 0;
		 break;
		}
 }

 return(answer);
}

/************************************************************************
Function:  compares two strings and is case sensitive.
Argumetns: srcptr, destptr
Returns:   int (not sure why we have to return an int)
Notes:     none
************************************************************************/

int mystrngcasecmp (const char *strng1ptr, const char *strng2ptr)
{

 char *str1,
		*str2;
 int answer = 0;
 int size1, size2;  // length of each string;
 int counto;		  // counts to value of variable
 int counter;  	  // used in for loop.
 str1 = strng1ptr;
 str2 = strng2ptr;
 size1 = mystrlen(str1);
 size2 = mystrlen(str2);

 if (size1 > size2)
	counto = size1;
 if (size1 <= size2)
	counto = size2;


 for (counter = 0; counter <= counto; counter++)
	{
	 if (*(str1 + counter) >96 && *(str1 + counter) < 123)
		*(str1 + counter) -= 32;
	 if (*(str2 + counter) > 96 && *(str2 + counter) < 123)
		*(str2 + counter) -= 32;

	}


 for ( counter = 0; counter <= counto; counter++)
 {
  if (str1[counter] > str2[counter])
		{
		 answer = 1;
		 break;
		}
  if (str2[counter] > str1[counter])
		{
		 answer = -1;
		 break;
		}
  if (str1[counter] == '\0' && str2[counter] == '\0')
		{
		 answer = 0;
		 break;
		}
 }
 return(answer);
}
