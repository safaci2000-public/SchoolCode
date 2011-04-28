#ifndef H_440
#define H_440
#include "440.h"
#endif
#include "binTree.h"
using namespace std;

int main(void)
{
	binTree<int> var;
	system("cls");

	var.insert2(10);
	var.insert2(15);
	var.insert2(5);
	var.insert2(2);
	var.insert2(7);
	var.insert2(12);
	var.insert2(17);
	cout << "size of Tree is:  " << var.size() << endl;
	cout << "height of Tree is: " << var.height() << endl;
	cout << "is the tree empty:  " << var.isEmpty() << endl;
	cout << "# of leaves of the tree is:  " << var.leaves() << endl;
	cout << "width of tree is:  " << var.width() << endl;
	cout << "PreOrder:  ";
	var.preOrder(print_entry);
	cout << "\nInOrder: ";
	var.inOrder(print_entry);
	cout << "\nPostOrder: ";
	var.inOrder(print_entry);
	cout << "\nLevelOrder: ";
	var.levelOrder(print_entry);
	cout << endl;

	binTree<int> var2(var);

	cout << "inOrder Traversal: ";
	var2.inOrder(print_entry);

	return 0;
//	exit(EXIT_SUCCESS);
}
