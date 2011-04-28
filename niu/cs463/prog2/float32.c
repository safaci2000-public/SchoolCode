/****************************************************************************
 * Name:		Samir Faci
 * Class:		CSCI 463
 * Prof:		Dr. Chung
 * TA:			Brandon Flynn
 * Assignment:		Assignment #2, part II
 * Due Date:		09/06/2002
 * **************************************************************************/
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define  xpSize  7		// num. of bits to store exponent
#define  frSize  24		// size of Mantissa
#define  maxSize 31		// total size of float minus the sign bit.

struct Float32			// structure used for manipulating the 
{ float in, out;		// declation of a float and how it's store
   char sb, xp[xpSize], fr[frSize]; //	in memory
};

int main()
{ struct Float32 Float, *fp;	// declares a pointer and an instance of the struct.

   int   IntPart, i;		// Integer part of the float, i is a counter.
   float FrcPart;		// decimal part of the float.

  void  Int_Frc(struct Float32 *);	// declaration of the function prototypes.
  void  IntOnly(struct Float32 *);
  void  FrcOnly(struct Float32 *);
  void  PrintRecord(struct Float32 *);

  /*  prompts user to enter a number within the acceptable range */

  printf("\n");
  printf("\nEnter a non-zero value from -65535.0 thru 65535.0.");
  printf("\nTo Exit, enter the zero, 0.0:->");
  fflush(stdin);		// flushes the input buffer.
  scanf ("%f",&(Float.in));
  printf("Value entered = %f\n", Float.in);

  while ((Float.in >= -65535.0) && (Float.in <= 65535.0) && (Float.in != 0.0))
  { if (Float.in < 0.0) {Float.sb = '1';  Float.in = -Float.in;}
    else                 Float.sb = '0';

    IntPart = Float.in;		// gets the integer part
    FrcPart = Float.in - IntPart;// gets the decimal part.

    if ((IntPart == 0) && (FrcPart == 0.0)) // handles special case (aka float.in = 0.0)
    { Float.out = 0.0;
      Float.xp[0] = '1';
      for (i=1; i<xpSize; i++)  Float.xp[i] = '0';
      for (i=0; i<frSize; i++)  Float.fr[i] = '0';

      printf("\nIntegral Part of input            = %d",IntPart);
      printf("\nIntegral Part in Binary           = %d",0);

      printf("\n");
      printf("\nFractional Part of input          = %f",FrcPart);
      printf("\nFractional Part in Binary         = ");
      for (i=0; i<frSize; i++) printf("%c",Float.fr[i]);
    }

    // appropriate function is called depending on the case //
    
    if ((IntPart  > 0) && (FrcPart  > 0.0)) Int_Frc(&Float);	
    if ((IntPart  > 0) && (FrcPart == 0.0)) IntOnly(&Float);
    if ((IntPart == 0) && (FrcPart  > 0.0)) FrcOnly(&Float);

    PrintRecord(&Float);	// prints user-friendly report

    /*  gets user input until exit condition (Float.in = 0.0) is met */

    printf("\n");
    printf("\nEnter a non-zero value from -65535.0 thru 65535.0.");
    printf("\nTo Exit, enter the zero, 0.0:->");
    fflush(stdin);
    scanf ("%f",&(Float.in));
    printf("Value entered = %f\n", Float.in);
  }

  printf("\nBye for Now!");  
  printf("\n");
  return(0);
}
/****************************************************************************
 * Prototype:  		void PrintRecord(struct Float32 *fp)
 * 
 * Function:		prints data about the Float pointer passed in, in a 
 * 			user-friendly manner.
 *
 * Parameters:  	pointer to a struct which represents how the float is
 * 			stored in memory.
 *
 * Returns:  		None.
 * **************************************************************************/
void PrintRecord(struct Float32 *fp)
{ int i;		// counter

  printf("\n\nSign Bit: %c",fp->sb);
  printf("\nExponent: ");
  for (i=0; i<xpSize; i++)  printf("%c",fp->xp[i]);

  printf("\nMantissa: ");
  for (i=0; i<frSize; i++) printf("%c",fp->fr[i]);

  if (fp->sb == '1') fp->out = -(fp->out);
  printf("\n\nValue if retrieved = %f", fp->out);
  printf("\n");
  return;
}

/****************************************************************************
 * Prototype:  		void Int_Frc(struct Float32 *fp)	
 * 
 * Function:		Calculates the integer and fraction portion of 
 * 			the float struct.
 *
 * Parameters: 		pointer to a struct which represents how the float is 
 * 			stored in memory.
 *
 * Returns:  		None.
 * **************************************************************************/
void Int_Frc(struct Float32 *fp)
{   int  i,j,k,n,x,IntPart;
   char  temp1a[maxSize],temp1b[maxSize],temp2[maxSize];
  float  y,FrcPart;

  x = fp->in;
  IntPart = fp->in;

  y = fp->in - x;
  FrcPart = fp->in - x;

  for (i=0; i<maxSize; i++) temp1a[i] = '0';

  j = 0;
  while (x > 0)
  { if (x / 2 * 2 != x) temp1a[j] = '1';
    x = x / 2;
    j++;
  }

  for (i=0; i<j; i++) temp1b[i] = temp1a[j-i-1];

  printf("\nIntegral Part of input            = %d",IntPart);
  printf("\nIntegral Part in Binary           = ");
  for (i=0; i<j; i++) printf("%c", temp1b[i]);

  n = pow(2,xpSize-1);         //n = 2**(4-1) = 2**3 = 8  if xpSize = 4
  k = n + j;                   //k = 8 + 3 = 11           if x = 6 = 110
			       //xp should be = 1011
  i = xpSize-1;
  while (i >= 0)
  { if (k == k / 2 * 2) fp->xp[i] = '0';
    else                fp->xp[i] = '1';
    k = k/2;
    i--;
  }

  k = 0;
  while (k < frSize)
  { y = y * 2.0;

    if (y >= 1.0)
    { temp2[k] = '1';
      y = y - 1.0;
    }
    else temp2[k] = '0';

    k++;
  }

  printf("\n");
  printf("\nFractional Part of input          = %f",FrcPart);
  printf("\nFractional Part in Binary         = ");
  for (i=0; i<k; i++) printf("%c",temp2[i]);

  if (j < frSize)
  { for (i=0; i<j; i++)            fp->fr[i] = temp1b[i];
    for (i=j; i<frSize; i++)       fp->fr[i] = temp2[i-j];
  }
  else
    for (i=0; i<frSize; i++)     fp->fr[i] = temp1b[i];

  fp->out = 0.0;
  i = 0;
  n = 1;
  while (i < frSize)
  { if (fp->fr[i] == '1') fp->out = fp->out + 1.0/pow(2.0,n);
    i++;
    n++;
  }
  fp->out = (fp->out)*pow(2.0,j);
  return;
}

/****************************************************************************
 * Prototype:  		void IntOnly(struct Float32 *fp)
 * 
 * Function:		Calculates the integer part of the struct only.
 *
 * Parameters: 		pointer to a struct which represents how the float is 
 * 			stored in memory.
 *
 * Returns:  		None
 *
 * **************************************************************************/
void IntOnly(struct Float32 *fp)
{   int  i,j,k,n,x,IntPart;
   char  temp1a[maxSize],temp1b[maxSize];

  x = fp->in;
  IntPart = x;

  for (i=0; i<maxSize; i++) temp1a[i] = '0';

  j = 0;
  while (x > 0)
  { if (x / 2 * 2 != x) temp1a[j] = '1';
    x = x / 2;
    j++;
  }

  for (i=0; i<j; i++) temp1b[i] = temp1a[j-i-1];

  printf("\nIntegral Part of input            = %d",IntPart);
  printf("\nIntegral Part in Binary           = ");
  for (i=0; i<j; i++) printf("%c", temp1b[i]);

  n = pow(2,xpSize-1);
  k = n + j;
  i = xpSize-1;

  while (i >= 0)
  { if (k == k / 2 * 2) fp->xp[i] = '0';
    else                fp->xp[i] = '1';
    k = k/2;
    i--;
  }

  if (j < frSize)
  { for (i=0; i<j; i++)          fp->fr[i] = temp1b[i];
    for (i=j; i<frSize; i++)     fp->fr[i] = '0';
  }
  else
    for (i=0; i<frSize; i++)     fp->fr[i] = temp1b[i];

  fp->out = 0.0;
  i = 0;
  n = 1;
  while (i < frSize)
  { if (fp->fr[i] == '1') fp->out = fp->out + 1.0/pow(2.0,n);
    i++;
    n++;
  }
  fp->out = (fp->out)*pow(2.0,j);
  return;
}

/****************************************************************************
 * Prototype:  		void FrcOnly(struct Float32 *fp)
 * 
 * Function:		Calculates the Fraction part of the float struct only
 *
 * Parameters: 		pointer to a struct which represents how the float is 
 * 			stored in memory.
 *
 * Returns:  		None
 *
 * **************************************************************************/
void FrcOnly(struct Float32 *fp)
{   int  i,j,k,n,IntPart;                 //fp->in = x.y, x=0
  float  y,FrcPart;

  IntPart = fp->in;
  FrcPart = fp->in;
  y = fp->in;

  printf("\nIntegral Part of input            = %d",IntPart);
  printf("\nIntegral Part in Binary           = %d",0);

  i = 0;
  n = 1;
  fp->out = 0.0;

  while (i < frSize)
  { y = y * 2.0;

    if (y >= 1.0)
    { fp->fr[i] = '1';
      y = y - 1.0;
      fp->out = fp->out + 1.0/pow(2.0,n);
      n++;
    }

    else
    { fp->fr[i] = '0';
      n++;
    }
    i++;
  }

  printf("\n");
  printf("\nFractional Part of input          = %f",FrcPart);
  printf("\nFractional Part in Binary         = ");
  for (i=0; i<frSize; i++) printf("%c",fp->fr[i]);

  k = 0;
  while (fp->fr[k] == '0') k++;

  if (k != 0)         // Mantissa needs to be "Normalized".
  { for (i=0; i<frSize-k; i++)  fp->fr[i] = fp->fr[k+i];
    for (i=frSize-k; i<frSize; i++) fp->fr[i] = '0';
  }

  // Now, Characteristic is constructed for Exponent k

  n = pow(2,xpSize-1);
  j = n - k;
  i = xpSize-1;

  while (i >= 0)
  { if (j/2*2 == j) fp->xp[i] = '0';
    else            fp->xp[i] = '1';

    j = j/2;
    i--;
  }
  return;
}
