/*****************************************************************************
 * Programmer:  Samir Faci
 * Proffessor:  Ibrahim Onyuksel
 * TA:          Dessislava Nacheva
 * Assign:      Program 9
 * Sec:         440-Sec 2
 *
 * Purpose:     driver program for the program.
 *                 
 * Notes:       use file redirection to test input data.
 *                 
*****************************************************************************/
#define _WIN        // defines w/h OS i'm using.

#ifdef _UNIX        // if mp then get files from location.
#include "/usr2/onyuksel/courses/440/common/Stack.h"
#include "/usr2/onyuksel/courses/440/common/440.h"
#include "/usr2/onyuksel/courss/440/common/Map.h"
#include "parTree.h"
#define CLEAR "clear"    
using namespace std;
#endif

#ifdef _WIN        // if windows then get files locally
#include "Stack.h"
#include "440.h"
#include "Map.h"
#include "parTree.h"
#define CLEAR "cls"            
using namespace std;
#endif

void sort(char []);
int  trim(char [], char eval[][10]);
int  trim(char backup[] );
void  buildMap(char [10][10], char [], map<char,double>& M,int loc);

int main(void)
{
    //                    *** Prints lovely heading isn't nice :-P ?      //
    system(CLEAR);
    cout << "\t*********************************************************\n"
         << "\t*                                                       *\n"
         << "\t*                CSCI 440 - Program 9                   *\n"
         << "\t*                     Spring 2002                       *\n"
         << "\t*        Parse Trees and Expression Evaluation          *\n"
         << "\t*                       Phase 2                         *\n"
         << "\t*                                                       *\n"
         << "\t*********************************************************\n";
    cout << endl;        // finishing touch 
    
    string in;    // reads in code world (EXPR, QUIT)
    char *expr = new char[80];    // expression w/h will be built into a tree
    parTree obj;            // parTree Object.

    map<char,double> M;        // declares a map object.
    double eval;
    typedef map<char,double>::const_iterator iter;

    cin >> in;
    while (cin)
    {
        int flag;
        flag = 1;                // resets flag
        if (in =="EXPR")
        {
            cin >> expr;
            cout << "EXPR\t" << expr << endl << endl;
            cout << "\tThe parse tree for the above expression is: \n" << endl;
            cout << "\tk\tentry[k]\tleft[k]\t\tright[k]\n";
            cout << "\t_\t--------\t-------\t\t--------\n";
            obj.makeTree(M, expr);
            obj.printTree();
            cin >> in;
            char *backup = new char[40];
            while ( in == "EVAL")
            {
                if (!M.empty())
                    M.clear();
                cout << "EVAL";
                char eval[10][10]={0};            // used to store the trimmed value of the eval string
                if (flag)
                {
                    strcpy(backup,expr);            // saves the string read in to build the tree
                    int count;                        
                    count = trim(backup);            // removes non-alpha chars. and returns length
                    flag = 0;
                }
                int loc;
                cin.getline(expr, 80, '\n');    // reads 80 chars 'till carriage return
                cout << expr << endl;            // prints the EVAL values
                loc = trim(expr,eval);            // builds 2D array based on the 80 char string read in.
                cout << "\n\tThe variables are assigned the values: " << endl << endl;
                buildMap(eval, backup, M, loc);    
                   cout << "\tTo evaluate the expression, following computations were performed: \n\n";                
                cout << "\toperator\tL operand\tR operand\t result" << endl;
                cout << "\t--------\t---------\t---------\t---------" << endl;
                cout << "\n\tValue of the Expression = " << obj.evalExpr(M) << endl << endl;
                cin >> in;
                if (in == "QUIT")
                {
                    if (!M.empty()) 
                        obj.clear();
                    goto exit;
                }
            }
            if (!M.empty())
                obj.clear();
        }
        else 
        {
exit:
            cout << "QUIT\n";
            exit(EXIT_SUCCESS);
        }

    }  
}
/*****************************************************************************
 * Method:          void sort(char temp[]);
 * 
 * Function:        sorts the characters of a string in alphabatic order.
 *
 * Arguments:       c-string
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
void sort(char temp[])
{
    char temp_val;        // simple bubble sort, this should obvious.
    int i =0; 
    int j = 0; 
    int min = 0;

    for (i = 0; i < strlen(temp) -1; i++)
    {
        for (min = i, j= i+1; j< strlen(temp); j++)
        {
            if (temp[j] < temp[min])
                min = j;
        }
        temp_val = temp[i];
        temp[i] = temp[min];        // swap vals.
        temp[min] = temp_val;
 
    }
}
/*****************************************************************************
 * Method:          int trim(char in[], char eval[][]);
 * 
 * Function:        to divide an 80 char string into smaller parts of a 2D
 *                    array.
 *
 * Arguments:       char in[]        source
 *                     char eval[][]    destination.
 * 
 * Returns:         # of elements inserted into eval array
 *
 * Notes:            NA
 *
******************************************************************************/
int trim(char in[], char eval[10][10])
{
 int cnt = 0, loc = 0;
 int start = 0; int end = 0;

 while (in)            // while != '\0'
 {
    start = end;

    if (cnt > strlen(in))
        break;

    while(in[cnt] != ' ')
    {
        cnt++;
        end++;
		if (in[cnt] == '\0')
			break;
    }
    cnt++;                    // increments past the space.

    if (start != end) {
        strncpy(eval[loc], in+start, end-start);
        loc++;
		end = cnt;
    }
    
    if (in[cnt] == '\0')
        break;
 }

 return loc;
}

/*****************************************************************************
 * Method:          trim(char backup[])
 * 
 * Function:        a different kinda trim, removes all non-alpha chars from
 *                    the string and sorts it (by calling sort);
 *
 * Arguments:       c-string;
 *                     
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
int  trim(char backup[] )
{
    int temp_cnt = 0;
    char temp[10] = {0};
    int back_cnt;

    for ( back_cnt= 0; back_cnt <= strlen(backup); back_cnt++)
    {
        if (isalpha(backup[back_cnt]))                // gets ride of the junk leaving 
        {                                    // only variables 
            temp[temp_cnt] = backup[back_cnt];
            temp_cnt++;
        }
    }

    sort(temp);
    strcpy(backup,temp);
        
  return temp_cnt;

}
/*****************************************************************************
 * Method:          void  buildMap(char eval[10][10], char backup[], 
 *                                 map<char,double>& M, int loc)
 * 
 * Function:        to build an Associative Array of the two array passed in.
 *                    
 *
 * Arguments:       eval[][]        character array of the float value 
 *                                  corresponding to the variables
 *                     backup[]     the variables of the expression.
 *                     loc          # of variabes/values
 *                     M            the associative array object.
 *                     
 * 
 * Returns:         None 
 *
 * Notes:            NA
 *
******************************************************************************/
void  buildMap(char eval[10][10], char backup[], map<char,double>& M, int loc)
{

    for (int count = 0; count < loc; count++)
    {
        cout.setf(ios::fixed,ios::floatfield|ios::showpoint);
        cout.precision(2);
        M[backup[count]] = (double) atof(eval[count]);
        cout << "\t" << backup[count]  << " =  " << M[backup[count]] << endl;
    }
    cout << endl;
}
