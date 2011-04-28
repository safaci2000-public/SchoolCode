/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Bhaska DasGupta
 * TA:		    Guanrao Chen
 * Assign:      Assignment 3
 *
 * Purpose:     Read in input.  sort the data, then enter the data into a 
 * 				Binary tree.  Once that's done, print the data from the tree
 * 				using an InOrder traversal.
* 				
******************************************************************************/
import java.io.*;

public class my_SortedTree {
/*****************************************************************************
 * Method:  		main()
 * Function:		to execute the program
 * Arguments:  		Strings
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
	public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(
               new InputStreamReader(System.in) );	// used to read in console
													//input 
		my_Tree t = new my_Tree();     // declares an instand of a my class definition of my tree
		String str;   // new String to read in user input as one continueous string
		int count = 0;  // keeps track of size of Integer array
		int input[] = new int[100]; // temporary integer array of all values to be put in tree
		String[] split; // temporary string array using for parsing input


		System.out.print("Please enter the input of numbers:  ");
		str = reader.readLine();  
		while ( str.equals(""))   // prompts user to enter input again while input is null
		{
			System.err.println("Error:  String is null/empty, try again.");
			System.out.print("Enter a series of integers separated by spaces:  ");
			str = reader.readLine();  
		}
		split = str.split(" ");

		/* Parse string and retrieves integers */
		for (int loc=0; loc< split.length; loc++)
		{
			try{ input[count] = Integer.parseInt(split[loc]); }  
			catch( NumberFormatException e)
			{ count--; continue;  } 
			finally{ count++; } 
		}

		bubble(input, count);  // bubble sort on array
		System.out.print("\nInput after sorting:  ");
		for (int x=0; x < count; x++) 
			System.out.print(input[x] + "  ");
		  
		buildtree(input,count, t);  // build tree datastructure

		System.out.print("\nWould you like to print the tree? (y/n):   ");
		str = reader.readLine();  
		if (str.charAt(0) == 'y' || str.charAt(0) == 'Y')
		{
			System.out.print("\nLevel Order Traversal: ");
			t.level();
			System.out.println("Height of Tree is: " + t.height());
		}

		
		return;
	}
/*****************************************************************************
 * Method:  		bubble()
 * Function:		performs a very primitive bubble sort on the array
 * Arguments:  		int []  // array of integers to be sorted
 * 					int max // size of array
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
   public static void bubble(int array[], int max)
   {
		int out = 0, in =0;  // counters used in for loops
		for (out=max-1; out >1; out--) {
			for(in = 0; in < out; in++) {
				if (array[in] > array[in+1]) {
					int temp=0;
					temp = array[in];
					array[in] = array[in+1];
					array[in+1] = temp;
				}
			}
		}
   }
/*****************************************************************************
 * Method:  		buildtree()
 * Function:		traverses array in InOrder sorting the data respectively
 * 					before inserting the data into the tree
 * Arguments:  		int array[]	data to be inserted in array
 * 					int count;  # of elements in the array
 * 					my_Tree t;  instance of the tree class where the data is 
 * 								stored
 * Returns:         None 
 * Notes:			NA
******************************************************************************/
   public static void buildtree (int array[], int count, my_Tree t)
   {
      
		int mid = count / 2;
		int i =0;

		for (i=mid; i > 0;  i-=2) 
			t.insert(array[i]); 
		for (i=0; i < mid; i += 2) 
			t.insert(array[i]);
		for (i=mid+2; i < count; i+=2) 
			t.insert(array[i]);
		for (i=mid+1; i < count; i+=2) 
			t.insert(array[i]);

		System.out.println("\nThe tree has been constructed");
  }
}   // end class definition
