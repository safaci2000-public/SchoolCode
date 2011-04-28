//#ifndef H_440
//#define H_440
//#include "/usr2/onyuksel/courses/440/common/440.h"
//#endif

#include "binTree.h"
#include "440.h"
using namespace std;


#define isEmpty(x)\
    cout << "tree is " << (x.isEmpty() ? "" : "not ") << "empty\n"

#define HDR(x) isEmpty(x);\
    cout << "\tno of nodes    = " << setw(2) << x.size()\
         << "\n\tno of leaves   = " << setw(2) << x.leaves()\
         << "\n\theight of tree = " << setw(2) << x.height()\
         << "\n\twidth of tree  = " << setw(2) << x.width()\
         << endl << endl;

#define ORD(x,y,s,t)\
    cout << "The elements of '" << s << "' in " << t << ":\n\t";\
    x.y(print_vals); cout << endl

template<class T>
void print_vals(T& x) { cout << x << ' '; }

template<class T>
void increase_vals(T& x) { x += 1; }

template<class T>
void decrease_vals(T& x) { x -= 1; }

template<class T>
void negate_vals(T& x) { x = -x; }

const int a[] = { 1, -2, 3, -4, 5, -6, 7, -8, 9, -10, 11, -12,
        13, -14, 15 };
const float b[] = { 0.5, 1.75, -3, 4.25, 5.50, -6.75, 8, 9.25,
        -10.5 };
const char* c[] = { "This", "is", "a", "list", "of", "string",
        "objects." };
const int d[] = { 29, 13, 37, 11, 19, 31, 41, 2, 17, 23, 61, 5,
        59, 67, 3, 7, 47, 71, 43, 53 };

const int sz_a = sizeof(a) / sizeof(int);
const int sz_b = sizeof(b) / sizeof(float);
const int sz_c = sizeof(c) / sizeof(char*);
const int sz_d = sizeof(d) / sizeof(int);


int main()
{
    binTree<int> first;
    for (int i = 0; i < sz_a; i++)
        first.insert1(a[i]);

    cout << "first: "; HDR(first);
    ORD(first, inOrder, "first", "inorder");
    ORD(first, preOrder, "first", "preorder");
    ORD(first, postOrder, "first", "postorder");
    ORD(first, levelOrder, "first", "levelorder");

    binTree<int> second(first);
    second.inOrder(negate_vals);

    first.clear();
    cout << "\nfirst: "; HDR(first);
    cout << "second: "; HDR(second);
    ORD(second, inOrder, "second", "inorder");
    cout << endl;

    binTree<float> third, fourth;
    for (int i = 0; i < sz_b; i++)
        third.insert1(b[i]);

    cout << "third: "; HDR(third);
    third.preOrder(increase_vals);
    ORD(third, preOrder, "third", "preorder");
    cout << endl;

    fourth = third;
    cout << "fourth: "; HDR(fourth);
    fourth.postOrder(decrease_vals);
    ORD(fourth, postOrder, "fourth", "postorder");
    cout << endl;

    binTree<string> fifth;
    for (int i = 0; i < sz_c; i++)
        fifth.insert1(c[i]);

    cout << "fifth: "; HDR(fifth);
    binTree<string> sixth = fifth;
    ORD(sixth, inOrder, "sixth", "inorder");
    ORD(sixth, preOrder, "sixth", "preorder");
    ORD(sixth, postOrder, "sixth", "postorder");
    ORD(sixth, levelOrder, "sixth", "levelorder");
    cout << endl;

    binTree<int> last;
    for (int i = 0; i < sz_d; i++)
        last.insert2(d[i]);

    cout << "last: "; HDR(last);
    ORD(last, levelOrder, "last", "levelorder");
    ORD(last, inOrder, "last", "inorder");

    return 0;
}

