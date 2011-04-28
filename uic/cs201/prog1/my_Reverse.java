/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Bhaskar DasGupta
 * TA:		    Guanrao Chen
 * Assign:      Assignment 2/ Program 1
 *
 * Purpose:     The Program will ask the user to input a string, it will 
 * 				then print the output in reverse order.	
 * 				
******************************************************************************/
import java.io.*;

public class my_Reverse {
/*****************************************************************************
 * Method:  		Main, driver method for program
 * Function:		to execute program
 * Arguments:  		Strings[] args, command line arguments
 * Returns:         None 
******************************************************************************/
    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(
               new InputStreamReader(System.in) );
	    String str; // var that stores the initial string before it's reversed
							        
        System.out.print( "Enter the string you wish to reverse:  " );
        str  = reader.readLine();
		System.out.println(" Size of string is :  " + str.length());

		while (str.length() > 100)  // ensures that string is 100 chars long
		{
			System.err.println("Error:  The string you've entered is greater then 100 characters.");
        	System.out.print( "Enter the string you wish to reverse:  " );
        	str  = reader.readLine();
		}

		System.out.println("This is the string you've entered:  " + str );
		System.out.println("This is the reversed string:  " + reverse(str));
		return;
    }
/*****************************************************************************
 * Method:  		reverse(String arg)
 * Function:		to reverse a string, turning abcd into dcba recursively
 * Arguments:  		a String
 * Returns:         None 
******************************************************************************/
static public String reverse(String arg)
	 {
		if (arg.length() == 0)  // if string is null, return
		{  return arg; }
		else
		{	// recursively return the last character + the output of 
			// the substring n-1 
			int n = arg.length();   
			return arg.charAt(n-1) + reverse( arg.substring(0,n-1));
		}
    }
}

