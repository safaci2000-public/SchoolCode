#include <iostream>
using namespace std;

int binSearch(int[], int, int, int);
int main()
{
 int ar[] = { 5, 1, 9 , 24, -14, 7, 299, 666, -2343, -21};

 int key = -21;

 cout << binSearch(ar, key, 0,9);
}

int binSearch(int ar[], int key, int low, int high)
{
  if (low >= high) return -1;

  int mid = (low + high) / 2;

  if (key == ar[mid])  return mid;

  if (key < ar[mid])
		  return binSearch(ar, key, low, mid+1);
  else
		  return binSearch(ar,key,mid-1, high);
}
