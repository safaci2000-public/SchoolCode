#include <z002161.pgm4.h>
#include <stdio.h>

void clrscr();

/************************************************************************
Function:   controls the flow of the program
Arguments:  none
Returns:    none
Notes:      none
************************************************************************/

int main()
{
 int code,
	  code_return,
	  track = 0;
 int counter;
 int num;
 char large[10][100];
 char small[10][100];
 char str1[50],
		str2[50];
 int larLoct = 0;
 int smaLoct = 0;

while (!EOF) {
 scanf("%d", &code);

 if (code == 1)
	{
	 scanf("%s", str1);
	 scanf("%s", str2);
	 code_return = mystrngcmp(str1, str2);
	 switch (code_return)
		{
		 case 1: larLoct = mystrngcpy(str1, small[larLoct]);
			 break;
		 case -1: larLoct = mystrngcpy(str2, small[larLoct]);
			  break;
		 default: printf("Error!!  both strings are equal");
			  break;
		}
	}
 if (code == 2)
	{
	 scanf("%s", str1);
	 scanf("%s", str2);
	 scanf("%d", num);


	 code_return = mystrngcasecmp(str1, str2);
	 switch (code_return)
		{
		 case 1: smaLoct = mystrngncpy(str1, large[smaLoct],
num);
					break;
		 case -1: smaLoct = mystrngncpy(str2, large[smaLoct],
num);
					 break;
		 default: printf("Error!!  both strings are equal");
		}
	 track++;
	}
 }
 clrscr();

 printf("High Strings  \n______________\n");
 for (counter = 1; counter <= larLoct; counter++)
	printf("%s \n", large[counter]);
 printf("\n\n\nLow Strings  \n______________\n");
 for (counter = 1; counter <= smaLoct; counter++)
	printf("%s \n", small[counter]);
 printf("\n\n Calls to Function: \n\n");
 printf("mystrngcpy:  %d \n", larLoct+1);
 printf("mystrngncpy: %d \n", smaLoct+1);
 return 0;
}

/***************************************************************************
Function:  clears the screen
Arguments: none
Returns:   none
notes:	   none
**************************************************************************/

void clrscr()
{
 printf("%c[2J", 27);
 fflush(stdout);
}
