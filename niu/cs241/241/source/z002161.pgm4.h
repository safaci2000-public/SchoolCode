#include <stdio.h>
#include <math.h>


/************************************************************************
Function:  gets the string length
Argumetns: str1
Returns:   int ...length of string.
Notes:     none
************************************************************************/

int mystrlen(char *str1);

/************************************************************************
Function:  copies a string into another string.
Argumetns: srcptr, destptr
Returns:   int (not sure why we have to return an int)
Notes:     none
************************************************************************/

int mystrngcpy (char *srcptr, char *destptr);

/************************************************************************
Function:  copies a string into another string.
Argumetns: srcptr, destptr
Returns:   int (not sure why we have to return an int)
Notes:     none
************************************************************************/
int mystrngncpy (const char *srcptr, const char *destptr, int n_size);

/************************************************************************
Function:  compares two strings.
Argumetns: char *strng1ptr, char *strng2ptr
Returns:   int
Notes:     returns one if they are equal...0 if they're not.
************************************************************************/

int mystrngcmp (const char *strng1ptr, const char *strng2ptr);
/************************************************************************
Function:  compares two strings and is case sensitive.
Argumetns: srcptr, destptr
Returns:   int (not sure why we have to return an int)
Notes:     none
************************************************************************/

int mystrngcasecmp (const char *strng1ptr, const char *strng2ptr);

