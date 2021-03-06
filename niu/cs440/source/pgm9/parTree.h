/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Ibrahim Onyuksel
 * TA:          Dessislava Nacheva
 * Assign:      Program 9
 * Sec:         440-Sec 2
 *
 * Purpose:     Class used to define a parse tree as well as provide
 *              Methods for handeling data.
 *                 
 * Notes:       None.
 *                 
*****************************************************************************/
#include "parTNode.h"
#include <string>
using namespace std;

class parTree
{
  public:
    parTree();                            // constructor
    ~parTree();                            // destructor.

    void makeTree(map<char,double>&, const string &);        
										// public method to create a parseTree
    void printTree() const;                // public method to print the tree.
    void clear();                        // clears the tree.
	double evalExpr(map<char,double>&) const; // public version of evalExpr

  private:
    parTNode<string>* root;                // root node of Tree.
    void makeTree(parTNode<string>*&, map<char,double>&, const string&);    
											// private implementation 
                                            // of make Tree
    void printTree(const parTNode<string>*) const;        // private version of print
    void clear(parTNode<string>*);                        // recursive destructor.
	double evalExpr(const parTNode<string>*, map<char,double>&) const;
				// private recursive implementation of it.
};

/***************** Begin constructors & destructors **************************/
/*****************************************************************************
 * Method:          parTree
 * 
 * Function:        Default constructs w/h nulls the root pointer
 *
 * Arguments:       None.
 * 
 * Returns:         None 
 *
 * Notes:           NA
 *
******************************************************************************/
parTree::parTree()
{
    root = 0;
}

/*****************************************************************************
 * Method:          ~parTree
 * 
 * Function:        Default destructer w/h nulls the root pointer
 *
 * Arguments:       None.
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
parTree::~parTree()
{
    (*this).clear();
}
/***************** End constructors & destructors ****************************/

/***************** Begin Public Classes definitions **************************/
/*****************************************************************************
 * Method:          makeTree(const string & expr)
 * 
 * Function:        calls a private method to create a parse Tree.
 *
 * Arguments:       expr = w/h is a string containing the expression.
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
void parTree::makeTree(map<char,double>&M, const string & expr)
{
    makeTree(root, M, expr);
}
/*****************************************************************************
 * Method:          printTree() const;
 * 
 * Function:        calls a recursive version of print to print the parse 
 *                    Tree.
 *
 * Arguments:       None.
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
void parTree::printTree() const
{
    (*this).printTree(root);
    cout << endl;                // prints an endline after the recursive
                                // print routine.
}
/*****************************************************************************
 * Method:          clear();
 * 
 * Function:        calls a recursive version of itself to destroy the 
 *                     dynamically allocated memory.
 *
 * Arguments:       None.
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
void parTree::clear()
{
    (*this).clear(root);
    root = 0;
}
/****************** End Public Classes definitions ***************************/

/****************** Begin Public Classes definitions *************************/
/*****************************************************************************
 * Method:         makeTree(parTNode<string>*& currNode, const string& expr) 
 * 
 * Function:       to create a ParseTree.
 *
 * Arguments:       currNode:  a pointer reference to root
 *                     expr:      the expression being looked @
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
void parTree::makeTree
(parTNode<string>*& currNode, map<char,double>&M, const string& expr)
{
    int node_count = 1;                // node id tracker.

    Stack<parTNode<string> *> s;    // stack
    unsigned int pos = 0;            // position in array/string
    string inexpr;                    // current expr being looked @
    char number[10];                // numberic expression.


    while ( pos < expr.size() )
    {
        parTNode<string>* newNode = new  parTNode<string>();

        if ( isalpha(expr[pos] ))        // if val is a letter
        {
            inexpr = expr[pos];
            newNode->entry = inexpr;
            newNode->id = node_count++;
            s.push(newNode);
        }
        else if ( isdigit(expr[pos]))    // if val is a number
        {
          int i = 0;
          while ( isdigit(expr[pos]) )
          {
            number[i] = expr[pos];
            pos++;
            i++;
          }
        pos--;
        number[i] = '\0';                // conver to string.
        inexpr = number;
        newNode->entry = inexpr;
        newNode->id = node_count++;
        s.push(newNode);
        }
    else if ((expr[pos] == '+') ||        // if val is an operator.
             (expr[pos] == '-') ||
             (expr[pos] == '*') ||
             (expr[pos] == '/'))
        {
        inexpr = expr[pos];                // deal w/ the pointers and
        newNode->right = s.POP();			// add finishing touch to tree.
        newNode->left = s.POP();
        newNode->entry = inexpr;
        newNode->id = node_count++;
        s.push(newNode);
        }
    pos++;
   }
    currNode = s.POP();        // sets last node to root 

}
/*****************************************************************************
 * Method:          printTree(const parTNode<string>* currNode) const;
 * 
 * Function:        to print the tree 
 *
 * Arguments:       currNode:   pointer to root node.
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
void parTree::printTree(const parTNode<string>* currNode) const
{
    int left = -1,             // left side of tree.
        right = -1;            // right side of tree.

    if (currNode->left != NULL)
        printTree(currNode->left);
    if (currNode->right != NULL)
        printTree(currNode->right);
    if (currNode->left == NULL)
        left = 0;
    else
        left = currNode->left->id;
    if (currNode->right == NULL)
        right = 0;
    else
        right = currNode->right->id;

    cout.setf(ios::right);
    cout << setw(9) <<currNode->id << "\t    " << currNode->entry;
    cout << "\t\t    " << left << "\t\t    " << right << endl;

}
/*****************************************************************************
 * Method:          clear(parTNode<string>* currNode);
 * 
 * Function:        deletes dynamic memory using a postorder traversal.
 *
 * Arguments:       currNode = current node being deleted.
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
void parTree::clear(parTNode<string>* currNode)
{
    if (currNode->left != NULL)
        clear(currNode->left);
    if (currNode->right !=NULL)
        clear(currNode->right);
    else
        delete currNode;
}
/*****************************************************************************
 * Method:          evalExpr(map<char,double>&);
 * 
 * Function:        calls a private version of this function.
 *
 * Arguments:       Map object.
 * 
 * Returns:         result of operation.
 *
 * Notes:            NA
 *
******************************************************************************/
double parTree::evalExpr(map<char,double>& m) const
{
	return this->evalExpr(root, m);
}
/*****************************************************************************
 * Method:          evalExpr(parTNode<string>* currptr map<char,double>&);
 * 
 * Function:        evaluates the expression.
 *
 * Arguments:       currptr :   current node being looked at.
 * 					m:          map
 * 
 * Returns:         result of operation.
 *
 * Notes:            NA
 *
******************************************************************************/
double parTree::evalExpr(const parTNode<string>* currptr, map<char,double>& m) const
{
	int i = 0;
	double l_result = 0;			// result from left subtree
	double r_result = 0;			// result from right subtree
	double final_ans = 0;			// final result

	if (currptr)					// if currptr ! = NULL
	{
		l_result= evalExpr(currptr->left, m);	// go left
		r_result= evalExpr(currptr->right, m);	// go right

		cout.setf(ios::scientific, ios::floatfield); 	// sets flags.
		cout.precision(2);

		if (ispunct( *currptr->entry.c_str()))		// deal w/ operators
		{
			switch(*currptr->entry.c_str())
			{
				case '+':
					final_ans = l_result + r_result;
					break;
				case '*':
					final_ans = l_result * r_result;
					break;
				case '-':
					final_ans = l_result - r_result;
					break;
				case '/':
					final_ans = l_result / r_result;
					break;
			}
			cout<< setw(12) << "    " << *currptr->entry.c_str() << setw(10) << " " << setw(9) << l_result;
			cout << setw(17) << r_result << setw(16) << final_ans << endl;
			return final_ans;
		}
		else if (isalpha(*currptr->entry.c_str()))
		{
			return m[*currptr->entry.c_str()];
		}
		else
		{
			return atof(currptr->entry.c_str());
		}
	}
	return final_ans;
}
