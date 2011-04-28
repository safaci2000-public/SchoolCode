/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Bhaska DasGupta
 * TA:		    Guanrao Chen
 * Assign:      Assignment 3 / Program 2
 *
 * Purpose:     Declares the Tree data type and methods which will manipulate 
 * 				the tree
 * 				
******************************************************************************/
import java.util.*;  // this contains the Vector class
class my_Tree {
	private node root;		// root node of tree
	//
	//
	public my_Tree()
	{

	}
/*****************************************************************************
 * Method:  		insert()
 * Function:		Insert a node into the tree and handles every conceivable
 * 					case
 * Arguments:  		id		value of node to be inserted
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
	public void insert(int id) 
	{ 
	  node newnode = new node();
	  newnode.value = id;
	  if(root == null)      // null case
		root = newnode;
	  else
	  {
		node currptr = root;
		node parent;
		while(true)
		{
			parent = currptr;
			if(id < currptr.value)  // left branch case
			{
				currptr = currptr.left;
				if (currptr == null)
				{
				parent.left = newnode;
				return;
				}
			}
			else    // right branch case
			{
				currptr = currptr.right;
				if(currptr==null) // if end of line
				{
					parent.right = newnode;
					return;
				}
			} // end else go right
		}	// end while
	  }	// end else not root
	} 
/*****************************************************************************
 * Method:  		preOrder()
 * Function:		Performs an preOrder traversal of the tree datastructure 
 * 					by calling a recursive version of this function
 * Arguments:  		None
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
 public void preOrder()
 {     r_preOrder(root);  /* calls the recursive version of this method */ }
/*****************************************************************************
 * Method:  		r_preOrder()
 * Function:		Performs an preOrder traversal of the tree datastructure 
 * 					using a recursive implementation
 * Arguments:  		node ptr;   // node to analyze 
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
 private void r_preOrder(node ptr)
 {
   if (ptr == null) return;

   System.out.println(ptr.value);
   if (ptr.left != null)
	  r_inOrder(ptr.left);
   if(ptr.right != null)
	  r_inOrder(ptr.right);
 } 
 
 /*****************************************************************************
 * Method:  		inOrder()
 * Function:		Performs an inOrder traversal of the tree datastructure 
 * 					by calling a recursive version of this function
 * Arguments:  		None
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
 public void inOrder()
 {     r_inOrder(root);  /* calls the recursive version of this method */ }
/*****************************************************************************
 * Method:  		r_inOrder()
 * Function:		Performs an inOrder traversal of the tree datastructure 
 * 					using a recursive implementation
 * Arguments:  		node ptr;   // node to analyze 
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
 private void r_inOrder(node ptr)
 {
   if (ptr == null) return;

   if (ptr.left != null)
	  r_inOrder(ptr.left);
   System.out.println(ptr.value);
   if(ptr.right != null)
	  r_inOrder(ptr.right);
 } 
/*****************************************************************************
 * Method:  		postOrder()
 * Function:		Performs an postOrder traversal of the tree datastructure 
 * 					by calling a recursive version of this function
 * Arguments:  		None
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
 public void postOrder()
 {     r_postOrder(root);  /* calls the recursive version of this method */ }
/*****************************************************************************
 * Method:  		r_postOrder()
 * Function:		Performs an preOrder traversal of the tree datastructure 
 * 					using a recursive implementation
 * Arguments:  		node ptr;   // node to analyze 
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
 private void r_postOrder(node ptr)
 {
   if (ptr == null) return;

   if (ptr.left != null)
	  r_inOrder(ptr.left);
   if(ptr.right != null)
	  r_inOrder(ptr.right);
   System.out.println(ptr.value);
 } 
 /*****************************************************************************
 * Method:  		level()
 * Function:		Performs a level traversal of the tree datastructure using
 * 					a Queue implementation.
 * Arguments:  		None
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
 public void level()
 {
    node currptr = new node();  // creates a pointer to be used to traverse the 
								// tree
	currptr = root;				// sets currptr to root of tree
    Queue q = new Queue();

    do
    {
        if (currptr.left != null )
            q.enqueue(currptr.left);
        if (currptr.right != null) 
            q.enqueue(currptr.right);
        System.out.print(currptr.value + "  ");
        currptr = (node) q.dequeue();
    } while (!q.isEmpty());

    System.out.println(currptr.value);
   } 
/*****************************************************************************
 * Method:  		height()
 * Function:		Returns Height of Tree
 * Arguments:  		None
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
 public int height()
 {
	return r_height(root);
 }
/*****************************************************************************
 * Method:  		height()
 * Function:		Returns Height of Tree
 * Arguments:  		node ptr;   // node to analyze 
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
 private int r_height(node ptr)
 {
	if (ptr == null)    return 0;

    int height_left = r_height(ptr.left);
    int height_right = r_height(ptr.right);

    if (height_left > height_right) 
            return height_left + 1; 
    else 
            return height_right + 1;

 }

}  // end class definition

/*****************************************************************************
 *****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Bhaska DasGupta
 * TA:		    Guanrao Chen
 * Assign:      Assignment 3 / Program 2
 *
 * Purpose:     Declares the node class used in the tree data structure
 * 				
 *****************************************************************************
******************************************************************************/
class node {
	public int value;  // value of tree node
	public node right; // pointer to right node
	public node left;  // pointer to left node

	node()
	{
		right=left=null;
		value = 0;
	}
	node(int x, node r, node l)
	{
		value = x;
		right = r;
		left = l;
	}
}  // end node class definition
