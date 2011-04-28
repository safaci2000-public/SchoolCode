/*****************************************************************************
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
#include "/usr2/onyuksel/courses/440/common/440.h"
#include <iostream>
#include <iomanip>
#include <string>
#include <cstdlib>
using namespace std;
//************************ Global Variables *********************************//

const int MAXLEN = 20;			// defines the maximum length of a word.
const int MAXWORDS = 1000;		// defines the maximum # of words.
const char *CLEAR = "clear"; 
int num_words = 0;				// the Number of words in the input stream.
char word_name[MAXWORDS][MAXLEN+1];		// contains words read in from the
										// the input stream.

//************************ Methods Prototypes *******************************//

void get_words();
void print_words();
void clean_entry(char entry[], char save[]);

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
	get_words();				// reads words from input buffer.
	system(CLEAR);				// clears the screen.
	print_words();				// prints the edited output.

	return 0;
}
/*****************************************************************************
 * Method:  		get_words
 * 
 * Function:		Reads words from the input stream and calls the clean 
 * 					method to clean the string from it's punctuations.
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


	while (cin >> entry)
	{
		clean_entry(entry,save);	// calls clean subroutine.
		length = strlen(save);		// gets the length of the string

		if (length == 0)
			continue;				// breaks out of itteration if no
									// valid alphanumerics were found.
		if (length > 0)
		{
			strcpy(word_name[num_words], save);
			num_words++;
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
 * Returns:         None, the method is void.
 *
 * Notes:			NA
 *
******************************************************************************/
void print_words(void)
{
	int carriage_return = 0;		// prints \n once 3 words have been 
									// printed on a single line.
	int count = 0;					// keeps track of number of words printed.

	cout << "Number of Words:  " << num_words << endl << endl;

	cout.setf(ios::left);			// sets output to left alignment.

	while (count < num_words)
	{
		cout << setw(20) << word_name[count];

		count++;
		carriage_return++;

		if (carriage_return == 3)
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

