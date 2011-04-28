/****************************************************************************
 * Name:            Samir Faci
 * Class:           CSCI 480
 * Prof:            Dr. Jie Zhou
 * TA:              Joshua Sanders
 * Assignment:      Assignment #1
 * Due Date:        10/21/2002
 * **************************************************************************/
#include <string.h>
#include <strings.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>

#define MAXSIZE 512     // max size of buffer being read
#define ARGSIZE 20      // max size of allocate of argument and parameter array.

void clean(char *[]);
void parse(char *, char *[]);
void split(char *, char **);

int main(void)
{
 char buf[MAXSIZE];     // buffer of input command entered by user
 char **args = (char **) malloc(sizeof(char**) * ARGSIZE);
 char **pars = (char **) malloc(sizeof(char**) * ARGSIZE);
        // args = arguments of command lined being parsed
        // pars = array split the command line into 2 parts after piping
 pid_t pid;             // process ID
 pid_t pid2;            // id used with piping
 int status;            // status of process
 int  loc;              // counter which resets buf to 0
 int pfd[2] = {-1};     // process file descriptor
 int dup_status = 0;    // status code of dup() function


 printf("myshell> ");
 while (fgets(buf,MAXSIZE,stdin) != NULL)
 {
   buf[strlen(buf) -1] =0;
   args[0] = (char *) 0;

   if ((strcmp("quit", buf) == 0) || 
       (strcmp("q", buf) == 0))
           break;       // normal termination.

    if (strstr(buf, "||") != NULL)  // if you user entered a pipe..
     {          
            split(buf, pars);   // splits cmd line into 2 parts

            if (pipe(pfd)) {
                perror("error: pipe failed!\n");
                exit(127);
            }
            
            pid = fork();   // forks a new child 
            pid2 = fork();  // forks a second child

            if ( pid2 < 0 || pid < 0) {
                perror("error: fork failed!\n");
            }
            else if (pid2 == 0)     // read from pipe 
            {
                    parse(pars[1], args);
                    close(0);       // close input
                    dup(pfd[0]);    // duplicate streams in child
                    close(pfd[1]);  // close pipe used
                    execvp(args[0], args);  // exec child
                    printf("Error occured in child!!\n");   
            }
            else if (pid == 0)        // other child writest to pipe
            {
                    parse(pars[0], args);
                    close(1);   // close ouput 
                    dup(pfd[1]); // duplicate streams
                    close(pfd[0]);  // close pipe used
                    execvp(args[0], args);  // exec command 
                    printf("Error occured!!");  // error if it gets to here
            }
			close(pfd[0]);
			close(pfd[1]);
            pid = waitpid(pid, &status, 0);
            pid2 = waitpid(pid2, &status, 0);
            
            if (pid  < 0 || pid2 < 0)
                        perror("waitpid error on child1!");

     }
    else if (strstr(buf,"|") != NULL)   // checks for invalid pipe attempt
     { 
            printf("My Shell takes || not a single | to work.  \n");
            printf("Please rectify the problem and try again\n");
     }
    else        // handles standard exec (just one command)
    {
     parse(buf, args);    // parses the command entered.

     if (strcmp(buf,"") == 0) {     // handles null input
        printf("myshell> ");
        continue; }

     if ((pid = fork()) <0)         // forks a new child
           perror("fork error\n");
     else if (pid==0) 
     {                  /* child */
           execvp(buf, args);
           printf("couldn't execute: %s\n", buf);
           exit(127);
     }
     /* parent */
     if ( (pid = waitpid(pid, &status, 0)) <0)
          perror("waitpid error\n");
   }

    for (loc = 0; loc < ARGSIZE; loc++)
        args[loc] = '\0';

   printf("myshell> ");
 }
 exit(0);
}
/****************************************************************************
 * Prototype:       void parse(char *buf, char *args[]);
 * 
 * Function:        to parse the command line entered
 *                  
 *
 * Parameters:      *buf        Buffer read in
 *                  *args       array of char* holding the various cmd-line
 *                              arguments
 *
 * Returns:         None.
 * **************************************************************************/
void parse(char *buf, char *args[])
{
 char *ptr;		// pointer used in conjunction with strtok
 int counter = 0;	// loop counter
    
   while((*buf == ' ') || (*buf == '\t') || (*buf == '\n'))
            *buf++;
 
   ptr = strtok( buf, " \t\n");
   while( ptr != NULL )
   {
      args[counter] = ptr;
      counter++;
      ptr = strtok( NULL, " \t\n" );
   }
}
/****************************************************************************
 * Prototype:       void split(char *, char **);
 * 
 * Function:        splits the command line based on the piping symbol (||)
 *                  
 *
 * Parameters:      *buf        Buffer read in
 *                  *pars       array of char* holding the 2 resulting cmds
 *
 * Returns:         None.
 * **************************************************************************/
void split(char *buf, char *pars[])
{
 char *ptr;		// pointer used in conjunction with strtok
 int counter2 = 0; // loop counter
    
   while((*buf == ' ') || (*buf == '\t') || (*buf == '\n'))
            *buf++;

   ptr = strtok( buf, "||");
   while( ptr != NULL )
   {
      pars[counter2] = ptr;
      counter2++;
      ptr = strtok( NULL, "||" );
   }
}
