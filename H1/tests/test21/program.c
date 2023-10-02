#include <stdio.h>
#include "CAT.h"

void CAT_execution (int userInput){
	CATData	d1;

	d1	= CAT_new(5);
  CAT_set(d1, 3);
	printf("H1: 	Value 1 = %ld\n", CAT_get(d1));
  CAT_add(d1, d1, d1);
  CAT_sub(d1, d1, d1);
	printf("H1: 	Value 1 = %ld\n", CAT_get(d1));

  return ;
}

int main (int argc, char *argv[]){
	CAT_execution(argc);

    printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
