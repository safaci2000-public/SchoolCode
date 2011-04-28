
#include <stdio.h>
#include <stdlib.h>

#ifndef FALSE
#define FALSE 	0
#endif
#ifndef TRUE
#define TRUE	1
#endif
#define BUF_SIZE 2000 /* Overkill */

int n_inputs = 0;
int n_full_inputs = 0; // Should be n_inputs * 2 at all times
int n_ands = 0;
int n_ors = 0;

int *input, *full_input;

int main(int argc, char *argv [])
{
  int * and_array_input, * or_array_input;
  int * and_array_output, * or_array_output;
  int * input;
  int * arrayP;

  char input_line[BUF_SIZE];

  FILE * desc, *inp;

  int i, j, n, line_pos;

  if(argc < 2){
    fprintf(stderr, "Usage:  %s   description_file  [input_file]\n", argv[0]);
    return 0;
  }

  /* Read in description file */
  if(NULL == (desc = fopen(argv[1], "r"))){
    fprintf(stderr, "Can't open description file %s\n", argv[1]);
    return 1;
  }

  fscanf(desc, "%d", &n_inputs);
  n_full_inputs = 2 * n_inputs;
  
  fscanf(desc, "%d", &n_ands);
  
  fscanf(desc, "%d", &n_ors); /* The number of output lines */
  
  and_array_input = malloc(n_full_inputs * n_ands * sizeof(int));
  or_array_input  = malloc(n_ands * n_ors * sizeof(int));

  /* Load connections for AND gates */
  arrayP = and_array_input;
  for(i = 0; i < n_ands; i++)
    for(j = 0; j < n_full_inputs; j++)
      fscanf(desc, "%d", arrayP++);

  /* Load connections for OR gates */
  arrayP = or_array_input;
  for(i = 0; i < n_ors; i++)
    for(j = 0; j < n_ands; j++)
      fscanf(desc, "%d", arrayP++);

  fclose(desc);

  /* Read in input */
  if(argc > 2){   /* There's an input file on the command line */
    if(NULL == (inp = fopen(argv[2], "r"))){
      fprintf(stderr, "Can't open %s for input\n", argv[2]);
      free(and_array_input); free(or_array_input);
      return 1;
    }
  }
  else
    inp = stdin;
  
  and_array_output = malloc(n_ands * sizeof(int));
  or_array_output  = malloc(n_ors * sizeof(int));
  input            = malloc(n_full_inputs);

  while(1){
    /* Read in input line */
    fgets(input_line, BUF_SIZE,inp);
    if(feof(inp))
      break;  /* Hit end of file. Exit */
    line_pos = 0;
    for(i = 0; i < n_full_inputs; i+= 2){
      sscanf(&input_line[line_pos], "%d%n", &input[i], &n);
      input[i+1] = !input[i];
      line_pos += n;
    }

    /* Evaluate */
    arrayP = and_array_input;
    for(i = 0; i < n_ands; i++, arrayP += n_full_inputs){
      and_array_output[i] = 1;
      for(j = 0; j < n_full_inputs; j++)
	if(arrayP[j] && ! input[j]){
	  and_array_output[i] = 0;  /* First 0 input pulls AND to 0 */
	  break;
	}
    }
    arrayP = or_array_input;
    for(i = 0; i < n_ors; i++, arrayP += n_ands){
      or_array_output[i] = 0;
      for(j = 0; j < n_ands; j++)
	if(arrayP[j] && and_array_output[j]){
	  or_array_output[i] = 1;  /* First 1 input pulls OR to 1 */
	  break;
	}
    }
    
    /* Print out results - input : output */
    for(i = 0; i < n_full_inputs; i+= 2)
      printf("%d ", input[i]);
    printf(": ");
    for(i = 0; i < n_ors; i++)
      printf("%d ", or_array_output[i]);
    printf("\n");
  }
  /* Cleanup */
  free(input);
  free(or_array_output);
  free(and_array_output);
  free(or_array_input);
  free(and_array_input);
  
  return 0;
}

