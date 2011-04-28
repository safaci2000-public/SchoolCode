/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Ibrahim Onyuksel
 * TA:		    Dessislava Nacheva
 * Assign:      Program 2
 * Sec:			440-Sec 2
 *
 * Purpose:     Reads string from the stdin into a 2d Char array, cleans it up,
 * 				and prints it in a user friendly manner.  It also removes all
 * 				punctuation as well as keeping a tally of the number of words 
 * 				read in.
 * 				
 * Notes:		"set tabstop=4" in vi will set it to 4.	
 * 				
*****************************************************************************/
//#include "/usr2/onyuksel/courses/440/common/440.h"
#include <iostream>
#include <iomanip>
#include <string>
#include <cstdlib>
using namespace std;
//************************ Global Variables *********************************//

const int MAXLEN = 20;			// defines the maximum length of a word.
const int MAXWORDS = 1000;		// defines the maximum # of words.
const char *CLEAR = "cls";		// constant string used to clear the screen. 
int word_count[MAXWORDS] = {0}; // array w/h stores the frequence of the
								// occurance of a word.
int num_words = 0;				// the Number of words in the input stream.
int n=0;						// Number of words in output list.
char word_name[MAXWORDS][MAXLEN+1];		// contains words read in from the
										// the input stream.

//************************ Methods Prototypes *******************************//

void get_words();
void print_words();
void clean_entry(char entry[], char save[]);
void swap(int, int);
void sort_words();

/****************************************************************************
 * Method Name:  main
 * purpose:      controls the flow of the program.
 * Parameters:   none
 *
 * returns:      int 
 *
 * notes:
****************************************************************************/

int main(void)
{
	system(CLEAR);
	get_words();				// reads words from input buffer.
	system(CLEAR);				// clears the screen.
	sort_words();				// sorts the words in alphabetic order
								// using the Buble sort algorithem.
	print_words();				// prints the edited output.

	return 0;
}
/*****************************************************************************
 * Method:  		get_words
 * 
 * Function:		Reads words from the input stream and calls the clean 
 * 					method to clean the string from it's punctuations.
 *
 * 					function now also calculates the number of frequencies
 * 					of each word.
 *
 * Arguments:  		None.
 * 
 * Returns:         None, the method is void.
 *
 * Notes:			NA
 *
******************************************************************************/
void get_words(void)
{
	char entry[MAXLEN+1];		// original value being read in.
	char save[MAXLEN+1];		// modified value.
	int length;					// length of char array.
	int freq_array = 0;			// keeps track of the frequency of the word.	


	while (cin >> entry)
	{
		clean_entry(entry,save);	// calls clean subroutine.
		length = strlen(save);		// gets the length of the string

		if (length == 0)
			continue;				// breaks out of itteration if no
									// valid alphanumerics were found.
		if (length > 0)
		{
			num_words++;

			// for loop changes the case of the string to lower case.
			// 
			for(int count=0; count < length; count++)
				save[count] = tolower(save[count]);	
			if(num_words == 1)
			{
				strcpy(word_name[freq_array], save);
				word_count[freq_array]++;
				freq_array++;
				n++;
			}
			else
			{
				int count1 = 1; 
				int count2 = 0;

				// count1 gets return value of the comparison.
				count1 = strcmp(save, word_name[count2]);

				while (count1 != 0 && count2 < freq_array)
				{
					count2++;
					count1 = strcmp(save, word_name[count2]);
				}
				
				if (count1 != 0)
				{
					strcpy(word_name[freq_array], save);
					word_count[freq_array]++;
					n++;
					freq_array++;
				}
				else
					word_count[count2]++;
			}
		}

		// if num_words is greater the maximum allowed, break out of loop.
		if (num_words > MAXWORDS)
		{
			break;
		}
	}
}

/*****************************************************************************
 * Method:  		print_words
 * 
 * Function:		Prints the words from the 2 Dimension array in a nice and
 * 					easy to read format.  It also prints the number of words
 * 					that have been read.
 *
 * Arguments:  		None.
 * 
 * Returns:         None
 *
 * Notes:			NA
 *
******************************************************************************/
void print_words(void)
{
	int carriage_return = 0;		// prints \n once 3 words have been 
									// printed on a single line.
	int location= 0;				// keeps track of location in array 
									// that should be printed

	cout << "Number of Words in Output Lists:  " << num_words << endl;
	cout << "Number of Distinct Words in Output Lists: " << n << endl<< endl;
	cout.setf(ios::left);			// sets output to left alignment.

	while (location < n)
	{
		cout << setw(20) << word_name[location] << ':'<<
				setw(20) << word_count[location];

		location++;					// increments the location position.
		carriage_return++;			// increments # of elements printed per
									// line.

		if (carriage_return == 2)
		{
			cout << endl;			// if 3 words were printed print \n.
			carriage_return = 0;
		}
	}
		
}
/*****************************************************************************
 * Method:  		clean_entry
 * 
 * Function:		To clean the data from the input buffer of any punctuation
 * 					or any character that is not alphanumeric.
 * 					
 *
 * Arguments:  		entry   orignal value passed in.
 * 					save	mofiied value being passed back.
 * 
 * Returns:         None, the method is void.
 *
 * Notes:			NA
 *
******************************************************************************/
void clean_entry(char entry[], char save[])
{
	int start;						// stores beggining of word.			
	int end;						// stores the last position of the word.
	int length = strlen(entry);		// length of entry passed in.


	// code below find first alphanumeric character and stores its 
	// position in start.
	
	for (int count=0; count <= length; count++)
	{
		if (isalnum(entry[count]))
		{
			start = count;
			break;
		}
	}

	// code below find last last character which is not alphanumeric and 
	// stores its position in end.
		
	for (int count=start; count <= length; count++)
	{
		if (!isalnum(entry[count]))
		{
			end = count;
			break;
		}
	}
	
	// copies content of entry to save from 1st alphanumeric char 'till the
	// first non-alphanumeric char is encountered.
	int count;
	for (count = start; count < end; count++)
	{
		save[count-start] = entry[count];
	}

	save[count-start] = '\0';			// sets the NULL character.	
	
}
/*****************************************************************************
 * Method:  	sort_words()	
 * 
 * Function:	alphabetises the words readin from the ifstream.	
 *
 * Arguments:  	none.	
 * 
 * Returns:     none. 
 *
 * Notes:		Uses Buble sort algorithem for sorting.	
 *
******************************************************************************/
void sort_words()
{
	int count1 = 0;			// counters used in buble sort algorithem.
	int count2 = 0;			// same as above.

	for (count1 = 0; count1 < n; count1++)
	{
		for(count2 = 0; count2 < n; count2++)
		{
			if(strcmp(word_name[count1], word_name[count2]) < 0)
				swap(count1, count2);
		}
	}
}
/*****************************************************************************
 * Method:  	swap()		
 * 
 * Function:	swaps 2 elements in an array.	
 *
 * Arguments:  	location1		integer w/h points to the location of the 1st
 * 								element.
 * 				location2		integer w/h points to the location of the 2nd
 * 								element.
 * Returns:		none.
 *
 * Notes:		NA
 *
******************************************************************************/
void swap(int location1, int location2)
{
	int tempVal = 0;		// temporary val used for sorting freq count.

	char tempString[MAXLEN+1];	// temporary string used for switching strings. 


	 // switches the string values.
     strcpy(tempString,word_name[location1]);		
     strcpy(word_name[location1],word_name[location2]);
     strcpy(word_name[location2],tempString);

	 // switches the frequency count w/h corresponds w/ the string switched.
     tempVal = word_count[location1];
     word_count[location1] = word_count[location2];
     word_count[location2] = tempVal;

}
