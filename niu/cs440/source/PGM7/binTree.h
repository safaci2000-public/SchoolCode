/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Ibrahim Onyuksel
 * TA:          Dessislava Nacheva
 * Assign:      Program 7
 * Sec:         440-Sec 2
 *
 * Purpose:     Class used to define a binary search tree as well as provide
 *              Methods for handeling data and traversing the tree.
 *                 
 * Notes:       None.
 *                 
*****************************************************************************/

#ifndef H_BINTNODE
#define H_BINTNODE
#include "binTNode.h"
#endif
#ifndef H_440
#define H_440
#include "440.h"
#endif
#include "queue.h"

template<class T> class binTree 
{
public:
    binTree();                        // default constructor.
    binTree(const binTree<T>&);        // copy constructor.    
    ~binTree();                        // destructor

    bool isEmpty() const;        // checks if tree is empty
    int size() const;            // returns no of nodes.
    int height() const;            // find height of tree.
    int leaves() const;            // finds # of leaves
    int width() const;            // finds width of tree
    void insert1(const T&);        // insert a node in shortest subtree.
    void insert2(const T&);        // insert a node in binary search tree.
    void clear();                // destory dynamic memory or free if u prefer.
    binTree& operator=(const binTree<T>&);    // overloads = operator.


    void inOrder(void(&)(T&));    // inorder traversal
    void preOrder(void(&)(T&));    // preorder traversal
    void postOrder(void(&)(T&)); // postorder traversal
    void levelOrder(void (&)(T&)); // levelOrder traversal


protected:
    binTNode<T>* root;                // pointer to root of tree.
    binTNode<T>* currptr;             // traversal pointer
    void copyTree(const binTree<T>& );    // copy list data
    void r_copyTree(binTNode<T>*& , const binTNode<T>* );
    //prototypes of utility functions.
    //  recursive versions of the methods listed above.
    void r_clear(binTNode<T>* subroot);
    void r_preOrder(void(&)(T&), binTNode<T>* subroot);
    void r_inOrder(void(&)(T&), binTNode<T>* subroot);
    void r_postOrder(void(&p)(T& value), binTNode<T>* subroot);
    int  r_size(binTNode<T> *ptr) const;  // recursive implementation of size. 
    void r_insert2(binTNode<T>*& ptr, T val);
    void r_insert1(binTNode<T>*& , const T& );
    int r_height(binTNode<T>* ptr) const;    
    int r_leaves(binTNode<T>* ptr) const;
    int q_width(binTNode<T>* sub_root) const;
};


/***************** Begin constructors & destructors **************************/
/*****************************************************************************
 * Method:          binTree()
 * 
 * Function:        Default constructs w/h nulls the next pointer and sets
 *                  the length of the tree to 0.                          
 *
 * Arguments:       None.
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
template<class T> 
binTree<T>::binTree()
{
 root = 0;    
 currptr = root;
}
/*****************************************************************************
 * Method:          binTree(const binTree<T>& source)
 * 
 * Function:        copy constructs w/h allocates memory to the Tree
 *                  by making a duplicate copy of the Tree object being passed.
 *                  Constructer works by calling the private CopyList method
 *                  by using the overloaded operator (=).
 *
 * Arguments:       List<T> &   reference to the object which shall be copied 
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
template<class T>
binTree<T>::binTree(const binTree<T>& source)
{
    copyTree(source);    
}
/*****************************************************************************
 * Method:          ~binTree()    
 * 
 * Function:        Default destructor which de-allocates the dynamic 
 *                  memory used by the class 
 *
 * Arguments:       None.
 * 
 * Returns:         None 
 *
 * Notes:           calls the clear method to delete the dynamic memory.
 *
******************************************************************************/
template<class T>
binTree<T>::~binTree()
{
    (*this).clear();    
}
/************************** End Constructors & Destructors ******************/

/*****************************************************************************
 * Method:          isEmpty()
 * 
 * Function:        Checks to see if tree is empty.
 *                     
 * Arguments:       None
 * 
 * Returns:         True of false depending on if the list if empty or not.
 *
 * Notes:            NA
 *
******************************************************************************/
template<class T>
bool binTree<T>::isEmpty() const
{
    if (!root)
            return true;

    return false;
}

/*****************************************************************************
 * Method:          size()
 * 
 * Function:        returns number of nodes in tree.
 *                     
 * Arguments:       None
 * 
 * Returns:         int, which is the size of the tree.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
int  binTree<T>::size() const
{
    return r_size(root);
}
/*****************************************************************************
 * Method:          r_size()
 * 
 * Function:        returns number of nodes in tree using a recursive 
 *                     algorithem
 *                     
 * Arguments:       None
 * 
 * Returns:         int, which is the size of the tree.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
int binTree<T>::r_size(binTNode<T>* ptr) const
{
    if (!ptr) return 0;

    return r_size(ptr->left) + r_size(ptr->right) + 1;
}
/*****************************************************************************
 * Method:          height()
 * 
 * Function:        returns the height of the tree.
 *                     
 * Arguments:       None
 * 
 * Returns:         int, which is the height of the tree.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
int  binTree<T>::height() const
{
    return r_height(root);
}
/*****************************************************************************
 * Method:          r_height()
 * 
 * Function:        returns the height of the tree.
 *                     
 * Arguments:       None
 * 
 * Returns:         int, which is the height of the tree.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
int binTree<T>::r_height(binTNode<T>* ptr) const
{
    if (!ptr)    return 0;

    int height_left = r_height(ptr->left);
    int height_right = r_height(ptr->right);

    if (height_left > height_right) 
            return height_left + 1; 
    else 
            return height_right + 1;
}
/*****************************************************************************
 * Method:          leaves()
 * 
 * Function:        returns number of leaves on tree.
 *                     
 * Arguments:       None
 * 
 * Returns:         int, which is the # of leaves on the tree.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
int  binTree<T>::leaves() const
{
    return (!root)? 0 : r_leaves(root);
}
/*****************************************************************************
 * Method:          r_leaves()
 * 
 * Function:        returns number of leaves on tree using recursion.
 *                     
 * Arguments:       None
 * 
 * Returns:         int, which is the # of leaves on the tree.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
int binTree<T>::r_leaves(binTNode<T>* ptr) const
{
    if (!ptr->right && !ptr->left)
        return 1;

    else if (ptr->right  && !ptr->left)
        return r_leaves(ptr->right);

    else if (!ptr->right  && ptr->left)
        return r_leaves(ptr->left);

    else 
        return ( r_leaves(ptr->left ) + r_leaves(ptr->right));
}
/*****************************************************************************
 * Method:          width()
 * 
 * Function:        returns the width of the tree.
 *                     
 * Arguments:       None
 * 
 * Returns:         int, which is the width of the tree.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
int  binTree<T>::width() const
{
    return q_width(root);
}
/*****************************************************************************
 * Method:          q_width(binTNode<T>* sub_root)
 * 
 * Function:        returns the width of the tree using a queue.
 *                     
 * Arguments:       None
 * 
 * Returns:         int, which is the width of the tree.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
int binTree<T>::q_width(binTNode<T>* sub_root) const
{
 queue<binTNode<T>*> q;

 int counter = 0;
 int max_size = 0;

 binTNode<T>* currptr2 = sub_root;

 if (!sub_root)
    return 0;
 q.push(currptr2);
 q.push(0);

 while(!q.empty())            // while queue isn't empty...
 {
    currptr2 = q.front();
    q.pop();

    if (currptr2)
    {
        if (currptr2->left)
            q.push(currptr2->left);
        if (currptr2->right)
            q.push(currptr2->right);
        counter++;
    }
    else

        if (counter > max_size)
        {
            max_size = counter;        // sets max_size to correct value
            counter = 0;            // depending on conditions.

            if (!q.size())
                    break;
            q.push(0);
        }
 }

    return max_size;
}
/*****************************************************************************
 * Method:          clear()
 * 
 * Function:        destroys mem allocated to nodes of tree.
 *                     
 * Arguments:       None
 * 
 * Returns:         None.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::clear()
{

    r_clear(root);
    root = 0;
}
/*****************************************************************************
 * Method:          r_clear(binTNode<T>* sub_root)
 * 
 * Function:        destroys mem allocated to nodes of tree.
 *                     
 * Arguments:       None
 * 
 * Returns:         none.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::r_clear(binTNode<T>* sub_root)
{
    if (!sub_root)        return;

    r_clear(sub_root->left);
    r_clear(sub_root->right);

    delete sub_root;
}
/*****************************************************************************
 * Method:          copyTree(const binTree<T>& source)  
 * 
 * Function:        makes a duplicate of the object being passed in.
 *                     
 * Arguments:       source: w/h is the object to be copies.
 * 
 * Returns:         None.
 *
 * Notes:            NA
 *
******************************************************************************/
template<class T>
void binTree<T>::copyTree(const binTree<T>& source)
{
        r_copyTree(root, source.root);
}
/*****************************************************************************
 * Method:          r_copyTree(binTNode<T>*& dest, const binTNode<T>* source)
 * 
 * Function:        makes a duplicate of the object being passed in using
 *                     a recursive algorithem.
 *                     
 * Arguments:       source: w/h is the object to be copies.
 * 
 * Returns:         None.
 *
 * Notes:           NA
 *
******************************************************************************/
template <class T>
void binTree<T>::r_copyTree(binTNode<T>*& dest, const binTNode<T>* source)
{
    if (!source )      return;

    dest = new binTNode<T>;            // gets some mem for data
    assert(dest);
    dest->data = source->data;         

    r_copyTree(dest->left, source->left);
    r_copyTree(dest->right, source->right);
}
/*****************************************************************************
 * Method:          operator=(const List<T> & element)
 * 
 * Function:        overloads the = operator and copies content of list passed 
 *                  in to current list.
 *                     
 * Arguments:       reference to object of List generic class
 * 
 * Returns:         None 
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
binTree<T>& binTree<T>::operator=(const binTree<T> & element)
{
    if ( (*this).root != element.root)
        copyTree(element);        // calls copyList...    
    else
        cerr << "Error: self assignment" << endl;

    return *this;
}
/*****************************************************************************
 * Method:          insert1(const T&)
 * 
 * Function:        insert node in shortest subtree.
 *                     
 * Arguments:       None
 * 
 * Returns:         void
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::insert1(const T& element)
{

   r_insert1(root, element); 
}
/*****************************************************************************
 * Method:          r_insert1(binTNode<T>*& sub_root, const T& element)
 * 
 * Function:        insert node in shortest subtree using recursion.
 *                     
 * Arguments:       None
 * 
 * Returns:         void
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::r_insert1(binTNode<T>*& sub_root, const T& element)
{
     if(sub_root == NULL)  
       {
         sub_root = new binTNode<T>; assert(sub_root);
     sub_root->data = element;
     sub_root->left = sub_root->right = 0;
       }
      else if(r_height(sub_root->left ) <= r_height(sub_root->right)) 
            r_insert1(sub_root->left,element);   // insert in left subtree.
      else
         r_insert1(sub_root->right,element);    // insert in right subtree.

}
/*****************************************************************************
 * Method:          insert2(const T&)
 * 
 * Function:        inserts node in binary search tree.
 *                     
 * Arguments:       None
 * 
 * Returns:         None.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::insert2(const T& element)
{

    (*this).r_insert2(root, element);
}
/*****************************************************************************
 * Method:          r_insert2(const T&)
 * 
 * Function:        inserts node in binary search tree.
 *                     
 * Arguments:       None
 * 
 * Returns:         None.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::r_insert2(binTNode<T>*& ptr, T val)
{

    if ( ptr == 0)
    {
        ptr = new binTNode<T>; assert(ptr);
        ptr->data = val;
        ptr->left = ptr->right = 0;
    }

    else if ( val >= ptr->data )
        r_insert2(ptr->right, val);
    else if (val < ptr->data )
        r_insert2(ptr->left, val);
}

/*       ****************      Begin Traversals   *****************       */ 


/*****************************************************************************
 * Method:          inOrder(void (*)(T&));
 * 
 * Function:        inorder traversal.
 *                     
 * Arguments:       Pointer to a function.
 * 
 * Returns:         None.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::inOrder(void (&p)(T& value))
{
    r_inOrder(p, root);
}
/*****************************************************************************
 * Method:          r_inOrder(void (*)(T&), binTNode<T>* subroot);
 * 
 * Function:        inorder traversal.
 *                     
 * Arguments:       Pointer to a function.
 * 
 * Returns:         None.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::r_inOrder(void(&p)(T& value), binTNode<T>* subroot)
{
    if (!subroot )  return;


    if (subroot->left)
            r_inOrder(p, subroot->left);
    (p)(subroot->data);    
    if (subroot->right)
            r_inOrder(p, subroot->right);

}
/*****************************************************************************
 * Method:          preOrder(void (*)(T&));
 * 
 * Function:        preorder traversal.
 *                     
 * Arguments:       pointer to a function.
 * 
 * Returns:         None.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::preOrder(void (&p)(T& value))
{
        r_preOrder(p, root);
}
/*****************************************************************************
 * Method:          r_preOrder(void (*)(T&), binTNode<T>* subroot);
 * 
 * Function:        preorder traversal using a recursive algorithem.
 *                     
 * Arguments:       pointer to a function.
 * 
 * Returns:         None.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::r_preOrder(void(&p)(T& value), binTNode<T>* subroot)
{
    if (!subroot )  return;

    (p)(subroot->data);
    if (subroot->left)
            r_preOrder(p, subroot->left);
    if (subroot->right)
            r_preOrder(p, subroot->right);

}
/*****************************************************************************
 * Method:          postOrder(void (*)(T&));
 * 
 * Function:        postorder traversal.
 *                     
 * Arguments:       pointer to a function.
 * 
 * Returns:         None.
 *
 * Notes:            NA
 *
******************************************************************************/
template<class T>
void binTree<T>::postOrder(void (&p)(T& value))
{
    r_postOrder(p, root);
}
/*****************************************************************************
 * Method:          r_postOrder(void (*)(T&), binTNode<T>* subroot);
 * 
 * Function:        postorder traversal.
 *                     
 * Arguments:       pointer to a function.
 * 
 * Returns:         None.
 *
 * Notes:           NA
 *
******************************************************************************/
template<class T>
void binTree<T>::r_postOrder(void(&p)(T& value), binTNode<T>* subroot)
{
    if (!subroot )  return;
    
    r_postOrder(p, subroot->left);
    r_postOrder(p, subroot->right);
    (p)(subroot->data);
    
}
/*****************************************************************************
 * Method:          levelOrder(void (*)(T&));
 * 
 * Function:        levelorder traversal.
 *                     
 * Arguments:       pointer to a function.
 * 
 * Returns:         None.
 *
 * Notes:            NA
 *
******************************************************************************/
template<class T>
void binTree<T>::levelOrder(void (&p)(T& value))
{
    currptr = root;
    queue< binTNode<T>* > q;

    do
    {
        if (currptr->left )
            q.push(currptr->left);
        if (currptr->right) 
            q.push(currptr->right);
        (p)(currptr->data);
        currptr = q.front();
        q.pop();
    } while (!q.empty());

    (p)(currptr->data);

}
