/*****************************************************************************
 * Name:				Samir Faci
 * Class:				CSCI 463
 * Prof:				Dr. Chung
 * TA:					Brandon Flynn
 * Assignment:			Assignment #8
 * Due Date:			11/04/02
 *
 * NOTES:   			flushall() was giving me unexpected problems, so i
 *						switched to the C++ cin for most input.
******************************************************************************/
#include <iostream>
#include<cstdio>
#include<float.h>
#include<cstdlib>
#include<math.h>
using namespace std;


#define CLEAR "cls"

int main()
{   int m,n,Repeat;
  float p, q1,q2,r1,r2,
        x[7] = {0},y[7] = {0} ,z[7] = {0};

  system(CLEAR);
  cout << endl << "Information for the CPU and I/O System" << endl;

  Repeat = 1;
  while (Repeat == 1)
  { 
    cout << endl << "Enter # of bytes that I/O command has to process:->";
    cin >> m; 

    cout << "\nEnter # of non-I/O instructions following the I/O command:->";
	cin >> n;

    cout <<"\nEnter the speed of the CPU (in MIPS):-> ";
	cin >> p;

    cout << "\nEnter the I/O speed for Programmed & Interrupt-Driven (in bytes/second):->";
	cin >> q1;

    cout << "\nEnter # of instructions/byte for Programmed & Interrupt-Driven:->";
	cin >> r1;

    cout << "\nEnter the DMA speed (in bytes/second):->";
	cin >> q2;

    cout << "\nEnter # of instructions/byte for DMA:->";
	cin >> r2;

    system(CLEAR);
    cout << "\n-------------------------------------------------------";
    printf("\n# of bytes that the I/O command has to process = %6d",m);
    printf("\n# of instructions that follow the I/O command  = %6d",n);
    printf("\n-------------------------------------------------------------------------");
    printf("\n                                                     Interrupt           ");
    printf("\n                                       Programmed     -Driven       DMA  ");
    printf("\n-------------------------------------------------------------------------");
    printf("\n                 CPU speed (in MIPS):   %9.4f   %9.4f   %9.4f ",p,p,p);
    printf("\n            I/O speed (in bytes/sec):   %9.4f   %9.4f   %9.4f ",q1,q1,q2);
    printf("\n# of instructions CPU has to execute:   %9.4f   %9.4f   %9.4f ",r1,r1,r2);
    printf("\n-------------------------------------------------------------------------");

//  m = # bytes for I/O command to tansfer (Read/Write)
//  n = # non-I/O instructions for CPU to execute

//  p = CPU speed
// q1 = I/O speed
// q2 = DMA speed

// Under Programmed I/O:
// x[1] = CPU time for I/O command = m bytes * r1 inst/byte * CPU speed
//        = (m*r1)/p msec
// x[2] = I/O time for I/O command = m bytes * I/O speed
//        = m bytes * 1000/q1 msec/byte
//        = 1000m/q1 msec
// x[3] = Time for I/O command = x[1] + x[2]
// x[4] = Time for non-I/O instructions = n/p
// x[5] = Total Time = x[3] + x[4]
// x[6] = % of times CPU idles = x[3]*100/x[5]

   x[1] = (m*r1)/(p * 1000.0);
   x[2] = 1000.0*m/q1;
   x[3] = x[1] + x[2];
   x[4] = n/( p * 1000.0);
   x[5] = x[3] + x[4];
   x[6] = x[2]*100.0/x[5];

// Under Interrupt-Driven:
// y[1] = CPU time for I/O command
// y[2] = I/O time for I/O command
// y[3] = Time for I/O command
// y[4] = Time for non-I/O instructions
// if (y[2] >= y[4])
//    {y[5] = _____;       y[6] = ____________________;
// else
//    {y[5] = ___________; y[6] = ____;

   y[1] = (m * r1) / (p * 1000.0);
   y[2] = (m*1000.0) / q1;
   y[3] = y[1] + y[2];
   y[4] = n/ ( p * 1000.0);
   if (y[2] >=  y[4])
      {y[5] = y[3];
       y[6] = (y[2] - y[4]) * 100.0 / y[5];}
   else
      {y[5] = y[1] + y[4];
       y[6] = (y[2] - y[4]) * 100.0 / y[5];}

// Under DMA:
// z[1] = CPU time for I/O command
// z[2] = DMA time for I/O command
// z[3] = Time for I/O command
// z[4] = Time for non-I/O instructions
// if (z[2] >= z[4])
//    {z[5] = ____;        z[6] = ____________________;
// else
//    {z[5] = ___________; z[6] = ___;

   z[1] = q2 / q1;
   z[2] = ((m * 1000.0) / q1 ) / z[1];
   z[3] = z[1] + z[2];
   z[4] = n/ ( p * 1000.0);

   if (z[2] >= z[4]) {
      z[5] = z[3];
      z[6] = (z[2] - z[4]) * 100.0 / z[5];
	  }
   else {
      z[5] = z[3];
      z[6] = (z[2] - z[4])* 100.0 / y[5];
   		}


   printf("\n-------------------------------------------------------------------------");
   printf("\nFor the I/O command, CPU time (msec):   %9.4f   %9.4f   %9.4f",x[1],y[1],z[1]);
   printf("\n                     I/O time (msec):   %9.4f   %9.4f   %9.4f",x[2],y[2],z[2]);
   printf("\n                   Total time (msec):   %9.4f   %9.4f   %9.4f",x[3],y[3],z[3]);
   printf("\n-------------------------------------------------------------------------");
   printf("\nFor non-I/O instructions,                                                    ");
   printf("\n                   Total time (msec):   %9.4f   %9.4f   %9.4f",x[4],y[4],z[4]);
   printf("\n-------------------------------------------------------------------------");
   printf("\nFor both (I/O & Instructions),                                             ");
   printf("\n                   Total time (msec):   %9.4f   %9.4f   %9.4f",x[5],y[5],z[5]);
   printf("\n-------------------------------------------------------------------------");
   printf("\n   Percentage of times the CPU idles:   %9.4f   %9.4f   %9.4f",x[6],y[6],z[6]);
   printf("\n-------------------------------------------------------------------------");

   cout << "\n\nType '1' to continue, '0' to exit:->";
   cin >> Repeat;
  }
  cout << "\nBye for Now!\n";
  return 0;
}

