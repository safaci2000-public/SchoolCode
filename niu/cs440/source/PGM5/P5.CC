/* This driver program can be used to test your List class. */

#ifndef H_440
#define H_440
#include "440.h"
//#include "/usr2/onyuksel/courses/440/common/440.h"
#endif
using namespace std;
/* Implement the header file list1.h for your List class and
   put it in the same directory with the driver program p5.cc. */

#include "List2.h"



int main()
{
	int n, k; float x;

    int a[] = {  2,  3,  5,  7, 11, 13, 17, 19, 23, 29, 31, 37, 41,
                43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97 };
    const int sz_a = sizeof(a) / sizeof(int);

    float b[] = { 1.3, 2.7, -0.5, 17, -99.9 }; 
    const int sz_b = sizeof(b) / sizeof(float);

    string s1("CSCI"), s2("Programming"), s;
    List<int> first; List<float> second;
    List<string> third, fifth;

    cout << "first:\n  isEmpty? "
         << (first.isEmpty() ? "yes" : "no") << endl; 
    cout << "  size = " << first.size() << endl;

    cout << "\nfirst:\n";
    first.insert(-1, 1);
    for (int i = 0; i < sz_a-1; i += 2) {
        first.insert(i, a[i]).insert(i+1, a[i+1]);
        cout << "  size = " << first.size() << endl;
    }

    cout << "\nfirst:\n  isEmpty? "
         << (first.isEmpty() ? "yes" : "no") << endl; 

    cout << "first: ";
    first.traverse(print_entry);
    cout << endl;

    first.replace(3, 8);
    cout << "first: ";
    first.traverse(print_entry);
    cout << endl;

    first.traverse(increment);
    cout << "first: ";
    first.traverse(print_entry);
    cout << endl;

    first.traverse(decrement);
    cout << "first: ";
    first.traverse(print_entry);
    cout << endl;

	const int N = first.size()/2 + 2;
    cout << "\nfirst:\n";
    for (int i = 0; i < N; i += 2)
        first.remove(i, n).remove(i+1, n);
    cout << "  size = " << first.size() << "\nfirst: ";
    first.traverse(print_entry);
    cout << endl;

    if ((k = first.search(n = 7)) >= 0)
        cout << "entry " << n << " in position " << k << endl;
    else
        cout << "entry " << n << " not in list\n";
    cout << endl;

    cout << "second:\n";
    for (int i = 0; i < sz_b; i++)
        second.insert(i, b[i]);
    cout << "  size = " << second.size() << "\nsecond: ";
    second.traverse(print_entry);
    cout << endl;

    second.traverse(increment);
    cout << "second: ";
    second.traverse(print_entry);
    cout << endl;

    if ((k = second.search(x = 3.7)) >= 0)
        cout << "entry " << x << " in position " << k << endl;
    else
        cout << "entry " << x << " not in list\n";
    cout << endl;

    cout << "third:\n";
    third.insert(0, s1).insert(1, s2);
    cout << "  size = " << third.size() << "\nthird: ";
    third.traverse(print_entry);
    cout << endl;

    third.replace(1, "Computer");
    cout << "third: ";
    third.traverse(print_entry);
    cout << endl;

    third.insert(1, "440:").insert(3, "Assignment 5");
    cout << "  size = " << third.size() << "\nthird: ";
    third.traverse(print_entry);
    cout << endl;

    third.remove(3, s);
    cout << "  size = " << third.size() << "\nthird: ";
    third.traverse(print_entry);
    cout << endl;

    if ((k = third.search(s = "Computer")) >= 0)
        cout << "entry \"" << s << "\" in position " << k << endl;
    else
        cout << "entry \"" << s << "\" not in list\n";

    fifth = third; third.clear();
    cout << "  size = " << third.size() << "\nthird: ";
    third.traverse(print_entry);
    cout << endl;
    
    
    cout << "\nfourth:\n";
    List<int> fourth(first);
    cout << "  size = " << fourth.size() << "\nfourth: ";
    fourth.traverse(print_entry);
    cout << endl;

    fourth.reverse();
    cout << "fourth: ";
    fourth.traverse(print_entry);
    cout << endl;
    fourth.half();
    cout << "  size = " << fourth.size() << "\nfourth: ";
    fourth.traverse(print_entry);
    cout << endl;

    cout << "\nfifth:\n";
    cout << "  size = " << fifth.size() << "\nfifth: ";
    fifth.traverse(print_entry);
    cout << endl;

    fifth.reverse().half();
    cout << "  size = " << fifth.size() << "\nfifth: ";
    fifth.traverse(print_entry);
    cout << endl;

    exit(EXIT_SUCCESS); 
}

