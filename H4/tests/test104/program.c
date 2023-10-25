#include <stdio.h>
#include "CAT.h"

CATData *g;

void CAT_execution (int userInput){
	CATData	d1,d2,d3;

	d1	= CAT_new(5);

  g = &d1;

  CAT_set(*g, 42);

	printf("H1: 	G Value = %ld\n", CAT_get(*g));

	return ;
}

int main (int argc, char *argv[]){
	CAT_execution(argc);

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
