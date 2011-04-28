/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Bhaskar DasGupta
 * TA:		    Guanrao Chen
 * Assign:      Assignment 2/ Program 1 /Part A
 *
 * Purpose:     Driver program.  reads input as a single string.  Then prints
 * 				the data entered with the middle node first. Going left until 
 * 				null, then going back to the middle, going right until the last
 * 				node is reached.
 * 	Notes:      for best view set the tabspace to 4,this applies to all source
 * 				files
*****************************************************************************/
import java.io.*;

public class  my_Special_Order { //extends Exception {
	public static void main(String[] args) throws IOException {
		list ll = new list(); // defines my linked list
        BufferedReader reader = new BufferedReader(
               new InputStreamReader(System.in) );
		String str;   // new String to read in user input as one continueous string

		System.out.print("Enter a series of integers separated by spaces:  ");
		str = reader.readLine();  
		while ( str.equals(""))
		{
			System.err.println("Error:  String is null/empty, try again.");
			System.out.print("Enter a series of integers separated by spaces:  ");
			str = reader.readLine();  
		}  
		int loc=0;  // integer that keeps track of the location in 
					  // the string array
		String[] split; // temporary string array 
		split = str.split(" ");
		for (loc=0; loc< split.length; loc++)
		{
			try{ ll.insertLast(Integer.parseInt(split[loc])); } 
			catch( NumberFormatException e)
			{ continue;  }
		}
			
		System.out.print("\nThis is the data that was entered by the user:  " );
		ll.displayForward();
		System.out.print("Data printed per program instructions:  ");
		ll.parta();
		System.out.println("");
	}
}
