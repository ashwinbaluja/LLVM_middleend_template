#include <stdio.h>
#include "CAT.h"

void CAT_execution (int userInput){
	CATData	d1;

	d1	= CAT_new(5);
	printf("Before loop: 	Value = %ld\n", CAT_get(d1));

  for (int i=0; i < userInput; i++){
	  printf("Inside loop: Value = %ld\n", CAT_get(d1));
	  d1	= CAT_new(42);
	  printf("Inside loop 2: Value = %ld\n", CAT_get(d1));
  }
	printf("After loop:	Value = %ld\n", CAT_get(d1));

	return ;
}

int main (int argc, char *argv[]){
	CAT_execution(argc + 10);

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
