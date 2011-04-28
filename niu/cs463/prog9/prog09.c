#include<stdio.h>
#include<math.h>
#define Giga 1073741824
#define Mega 1048576
#define Kilo 1024


#define CLEAR "cls"

unsigned int x2n(unsigned long);
void flushall();

int main()
{ unsigned long virtInG,mainInM,Ratio,pageInK,framInK,
		nVirt,nMain,npSz,nfSz,nTotPages,nTotFrams,pgmInK;

// virtInG  = size of Virtual Memory (in G bytes)
// mainInM  = size of Main Memory (in M bytes)
// Ratio    = virtInG*Kilo/MainInM
// pageInK  = size of Page  (in K bytes)
// framInK  = size of Frame (in K bytes) = pageInK
// nVirt    : size of Virtual Memory = 2**(nVirt)
// nMain    : size of Main Memory = 2**(nMain)
// npSz     : size of Page  = 2**(npSz)
// nfSz     : size of Frame = 2**(nfSz)
// nTotPages: TotPages = 2**(nTotPages), where TotPages = Total # of Pages
// nTotFrams: TotFrams = 2**(nTotFrams), where TotFrams = Total # of Frames
// pgmInK   : size of Program Segment (in K bytes)

  long long test = 0;
  unsigned long virtSz,mainSz,pageSz,framSz,TotPages,TotFrams,
		maxPage,maxFram,virtAdr[40],pageNum[40],bytePos[40],
		mainAdr[40],pagePos[40],framNum[40];

	    int i,j,k,temp,Repeat;
// virtSz    = size of Virtual Memory (in bytes) = virtInG*Mega*Kilo
// mainSz    = size of Main Memory (in bytes) = mainInM*Mega
// pageSz    = size of Page  (in bytes) = pageInK * Kilo
// framSz    = size of Frame (in byte) = pageSz
// TotPages  = Total # of Pages  = virtSz/pageSz
// TotFrams  = Total # of Frames = mainSz/framSz
// maxPage   = Largest Page #  = TotPages - 1
// maxFram   = Largest Frame # = TotFrams - 1
// virtAdr[] : virtAdr[0] = address of First Byte of Program in Virtual Memory
//             virtAdr[i] = virtAdr[i-1] + pageSz*Kilo (1 <= i <= j)
// pageNum[] = Page # to which virtAdr[] belongs     (= virtAdr[] / pageSz)
// bytePos[] = Position of First Byte in pageNum[]   (= virtAdr[] % pageSz)
// mainAdr[] = address of virtAdr[] in Main Memory   (= virtAdr[] / Ratio)
// pagePos[] = Position of pageNum[] among the pages (= virtAdr[] % Ratio)
// framNum[] = Frame # to which pageNum[] is mapped  (= pageNum[] % Ratio)

  system(CLEAR);
  printf("\nGeneral Information for the Virtual-Main Memory System:\n");

  Repeat = 1;
  while (Repeat == 1)
  { system(CLEAR);
    printf("\nEnter the size of Virtual Memory (in Giga bytes):->");
    scanf("%d",&virtInG);         /* set memory size to immpropor responce */
    virtSz = virtInG * Mega * Kilo;

    flushall();
    printf("\nEnter the size of Main Memory (in Mega bytes):->");
    scanf("%d",&mainInM);
    mainSz = mainInM * Mega;

    flushall();
    printf("\nChoose one for the size of Page (in Kilo bytes):");
    printf("1,2,4,8,16,32,64:->");
    scanf("%d",&pageInK);
    pageSz  = pageInK * Kilo;
    framInK = pageInK;
    framSz  = pageSz;

//  Memory System Information: Compute & Display
    TotPages = virtInG * Mega / pageInK;
    TotFrams = mainSz / framSz;
	Ratio = (virtInG * Mega) / (mainSz / Kilo);

	nVirt = 30;
	test = virtInG;
	while (test > 1) {
		test /= 2;
		nVirt++;
	}

    nMain = x2n(mainSz);
    npSz = x2n(pageSz);

    nfSz = x2n(framSz);
    nTotPages = x2n(TotPages);
    nTotFrams = x2n(TotFrams);

    system(CLEAR);
    printf("\n------------------------------------------------------");
    printf("\n            Virtual-Main Memory System                ");
    printf("\n------------------------------------------------------");
    printf("\n    Virtual Memory Size in Giga bytes = %dG = 2**%d",virtInG,nVirt);
    printf("\n    Largest Address in Virtual Memory = %lX",virtSz-1);
    printf("\n                   Page Size in bytes = %dK = 2**%d",pageInK,npSz);
    printf("\n        Virtual Memory Size/Page Size = %lX = 2**%d",TotPages,nTotPages);
    printf("\nLargest Page Number in Virtual Memory = %lX",TotPages-1);
    printf("\n------------------------------------------------------");
    printf("\n Virtual Memory Size/Main Memory Size = %d",Ratio);
    printf("\n------------------------------------------------------");
    printf("\n       Main Memory Size in Mega bytes = %dM = 2**%d",mainInM,nMain);
    printf("\n       Largest Address in Main Memory = %lX",mainSz-1);
    printf("\n                  Frame Size in bytes = %dK = 2**%d",framInK,nfSz);
    printf("\n          Main Memory Size/Frame Size = %lX = 2**%d",TotFrams,nTotFrams);
    printf("\n  Largest Frame Number in Main Memory = %lX",TotFrams-1);
    printf("\n------------------------------------------------------");

    flushall();
    printf("\nAbout a Program in Virtual Memory:");
    printf("\nEnter the address of its First Byte <= %lX:-> ",virtSz-1);
    scanf("%lX",&virtAdr[0]);

    pageNum[0] = virtAdr[0] / framSz;
    bytePos[0] = virtAdr[0] % framSz;

    framNum[0] = pageNum[0] % TotFrams;
    pagePos[0] = pageNum[0] / TotFrams;

    printf("\n--------------------------------------------------------------");
    printf("\n      Address of First Byte of Program = virtAdr[0] = %lX",virtAdr[0]);
    printf("\n    Page # to which virtAdr[0] belongs = pageNum[0] = %lX",pageNum[0]);
    printf("\n    Position of virtAdr[0] in the Page = bytePos[0] = %lX",bytePos[0]);
    printf("\n Frame # to which pageNum[0] is mapped = framNum[0] = %lX",framNum[0]);
    printf("\nPosition of pageNum[0] among the pages = pagePos[0] = %lX",pagePos[0]);
    printf("\n--------------------------------------------------------------");

    flushall();
    printf("\nEnter the size of the program in K bytes:->");
    scanf("%d",&pgmInK);
    printf("\nSize of the program in K bytes = %dK",pgmInK);
    printf("\nAddress of First Byte = %lX",virtAdr[0]);

	test = pgmInK * pow(2,10);
    printf("\nAddress of Last Byte  = %lX", (virtAdr[0]+ test - 1));

    virtAdr[1] = virtAdr[0] + (pageSz - bytePos[0]);

    i = 1;
    while (virtAdr[i]  < (virtAdr[0]+pgmInK*Kilo-1))  {
    pageNum[i] = pageNum[i-1] + 1;
    framNum[i] = framNum[i-1] + 1;
    printf("\n--------------------------------------------------------------");
    printf("\n    Address of First Byte in Next Page = virtAdr[%d] = %lX",i,virtAdr[i]);
    printf("\n    Page # to which virtAdr[%d] belongs = pageNum[%d] = %lX",i,i,pageNum[i]);
    printf("\n Frame # to which pageNum[%d] is mapped = framNum[%d] = %lX",i,i,framNum[i]);
    i++;

	virtAdr[i] = virtAdr[i-1] +  pageSz; 
    } 
    printf("\n--------------------------------------------------------------");
    printf("\nNumber of Pages occupied by Program = %d",i);

    flushall();
    printf("\n\nType '1' to continue, '0' to exit:->");
    scanf("%d",&Repeat);
  }
  printf("\nBye for Now!\n");
  return 0;
}

unsigned int x2n(unsigned long x)
{ unsigned int n=0;
  while (x>1) {x = x/2; n++;};
  return(n);
}

void flushall()
{
  fflush(stdin);
  fflush(stdout);
}
