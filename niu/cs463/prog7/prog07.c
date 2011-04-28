/****************************************************************************
 * Name:			Samir Faci
 * Class:			CSCI 463
 * Prof:			Dr. Chung
 * TA:				Brandon Flynn
 * Assignment:		Assignment #7
 * Due Date:		09/06/2002
 * **************************************************************************/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#define Mega 1048576
#define Kilo 1024

unsigned int x2n(unsigned long);
void flushall(void);

int main()
{ unsigned long MainSz,NumBlocks,CacheSz,NumSlots,NumSets,MainAddr,
		BlockNum,SlotNum,SetNum,Tag,Byte;
  unsigned int  BlockSz,SetSz,nMain,nBlock,nCache,nSlot,nSet,nByte,nTag;

  system("cls");
  printf("\nCache Memory Functions: Main Memory -> Cache");
  printf("\nGeneral Information for the given Memory System\n");

  system("cls");
  printf("\n\nEnter the size of Main Memory (in Mega bytes).");
  printf("\nTo Exit, enter the zero:->");
  scanf("%ld",&MainSz); printf("%ldM",MainSz);
  MainSz = MainSz * Mega;

  while (MainSz != 0)
  { flushall();
    printf("\nEnter the size of the Cache (in Kilo bytes):->");
    scanf("%ld",&CacheSz); printf("%ldK",CacheSz);
    CacheSz = CacheSz * Kilo;

    flushall();
    printf("\nChoose one for the Block Size in bytes:");
    printf(" 1,2,4,8,16,32,64:->");
    scanf("%d",&BlockSz); printf("%d",BlockSz);

    flushall();
    printf("\nChoose one for the Set Size in slots:");
    printf(" 1,2,4,8,16,32,64:->");
    scanf("%d",&SetSz); printf("%d",SetSz);

//Compute & Displaying
    NumBlocks = MainSz / BlockSz;
    NumSlots  = CacheSz / BlockSz;
    NumSets   = NumSlots / SetSz;

    system("cls");
    printf("\n------------------------------------------------");
    printf("\n               Memory System                    ");
    printf("\n------------------------------------------------");
    printf("\n        Main Memory Size in Mega bytes = %dM",MainSz/Mega);
    printf("\n                Main Memory Size in hex: %lX",MainSz);
    printf("\n  Largest Address in Main Memory in hex: %lX",MainSz-1);
    printf("\n------------------------------------------------");
    printf("\n                            Block Size = %02d",BlockSz);
    printf("\n          Total Number of Blocks in hex: %lX",NumBlocks);
    printf("\n            Largest Block Number in hex: %lX",NumBlocks-1);
    printf("\n------------------------------------------------");
    printf("\n       Cache Memory Size in Kilo bytes = %dK",CacheSz/Kilo);
    printf("\n               Cache Memory Size in hex: %lX",CacheSz);
    printf("\n Largest Address in Cache Memory in hex: %lX",CacheSz-1);
    printf("\n------------------------------------------------");
    printf("\n                             Slot Size = %02d",BlockSz);
    printf("\n           Total Number of Slots in hex: %lX",NumSlots);
    printf("\n             Largest Slot Number in hex: %lX",NumSlots-1);
    printf("\n------------------------------------------------");
    printf("\n                              Set Size = %02d",SetSz);
    printf("\n            Total Number of Sets in hex: %lX",NumSets);
    printf("\n              Largest Set Number in hex: %lX",NumSets-1);
    printf("\n------------------------------------------------");

    flushall();
    printf("\n\nEnter Address of a Byte in Main Memory <= %lX.",MainSz-1);
    printf("\nTo return to the Main Menu, enter the Zero Address:->");
    scanf("%lX",&MainAddr);

    while (MainAddr != 0)
    { printf("\n");
      BlockNum = MainAddr / BlockSz;
      printf("\n------------------------------------------------");
      printf("\nThe Byte's Address in Main Memory     = %lX",MainAddr);
      printf("\nThe Byte belongs to the Block whose # = %lX",BlockNum);

/*  Associative Mapping
 *  Tag  = BlockNum (= MainAddr/BlockSz)
 *  Byte = MainAddr%BlockSz
 */
      Tag  = BlockNum;
      Byte = MainAddr % BlockSz;

      nMain  = x2n(MainSz);
      nBlock = x2n(NumBlocks);
      nTag   = nBlock;
      nByte  = nMain - nBlock;

      printf("\n------------------------------------------------");
      printf("\n          Under Associative Mapping             ");
      printf("\n The Byte at %lX is copied into Cache Memory:",MainAddr);
      printf("\n------------------------------------------------");
      printf("\n    Field:    Tag       Slot#      Byte Location");
      printf("\n  Content:    %0lX      %0lX\t\t%d",Tag,NumSlots-1,Byte);
      printf("\n# of bits:    %d       Not Appl.\t%d",nTag,nByte);


/*  Direct Mapping
 *  Slot# = Block# % (Tot# of slots)
 *  Tag = Block# / (Tot# of slots)
 *
 *  |<------------------------- MainAddr ------------------------>|
 *  |<----------------- Block# ---------------->|<----- Byte ---->|
 *  |<------- Tag -------->|<------ Slot# ----->|<----- byte ---->|
 *  |<------  nTag ------->|<-----  nSlot ----->|<---  nLoc1  --->|
 */

  SlotNum = BlockNum % NumSlots;
  Tag = BlockNum / NumSlots;


  nTag  = x2n(NumSlots);
  nTag  = nBlock - nTag;

  nSlot = x2n(SlotNum);
  nSlot++; 


    printf("\n------------------------------------------------");
    printf("\n            Under Direct Mapping                ");
    printf("\n The Byte at %lX is copied into Cache Memory:",MainAddr);
    printf("\n------------------------------------------------");
    printf("\n    Field:    Tag     Slot#        Byte Location");
    printf("\n  Content:    %0lX      %0lX\t\t%d",Tag,SlotNum,Byte);
    printf("\n# of bits:    %d       %d  \t\t%d",nTag,nSlot,nByte);

/*  Under Set Associative Mapping
 *  Set# = Block# % (Tot# of sets)
 *  Tag  = Block# / (Tot# of sets)
 *
 *  |<------------------------- MainAddr ------------------------>|
 *  |<----------------- Block# ---------------->|<----- Byte ---->|
 *  |<------- Tag -------->|<------  Set# ----->|<----- Byte ---->|
 *  |<------  nTag ------->|<------  nSet ----->|<---  nByte  --->|
 */

  SetNum = BlockNum % NumSets;
  Tag = BlockNum / NumSets;

  nSet = x2n(NumSets);
  nSet =  nBlock - nSet;
  nTag  = x2n(NumSets);
  nTag  = nBlock - nTag;


      printf("\n------------------------------------------------");
      printf("\n       Under Set Associative Mapping            ");
      printf("\n The Byte at %lX is copied into Cache Memory:",MainAddr);
      printf("\n------------------------------------------------");
      printf("\n    Field:    Tag      Set#        Byte Location");
      printf("\n  Content:    %0lX      %0lX\t\t%d",Tag,SetNum,Byte);
      printf("\n# of bits:    %d        %d  \t\t%d",nTag,nSet,nByte);
      printf("\n------------------------------------------------");


      flushall();
      printf("\n\nEnter Address of a Byte in Main Memory <= %lX.",MainSz-1);
      printf("\nTo return to the Main Menu, enter the Zero Address:->");
      scanf("%lX",&MainAddr);
    }

    system("cls");
    printf("\nEnter the size of Main Memory (in Mega bytes).");
    printf("\nTo Exit, enter the zero:->");
    scanf("%ld",&MainSz); printf("%ldM",MainSz);
    MainSz = MainSz * Mega;
  }
  printf("\n\nBye for Now!\n");
  return 0;
}
/****************************************************************************
 * Prototype:  		unsigned int x2n(unsigned long x);
 * 
 * Function:		Calculates the number of bits passed in the int passed		
 *
 * Parameters: 		unsigned long x:  the int for which to calculate the 
 * 					the number of bits.
 *
 * Returns:  		The Number of bits for the long passed in.
 *
 * **************************************************************************/
unsigned int x2n(unsigned long x)
{ unsigned int n=0;
  while (x>1) {x >>= 1; n++;};
  return(n);
}
/****************************************************************************
 * Prototype:  		flushall();
 * 
 * Function:		flushes all the file streams, replacement for TC flushall
 * 					since i refuse to use TC as long as i can avoid it.
 *
 * Parameters:		None. 		
 *
 * Returns:  		None
 *
 * **************************************************************************/
void flushall(void)
{
	fflush(stdin);
	fflush(stdout);
}
