#include <stdio.h>
#include "CAT.h"

void CAT_execution (int userInput){
	CATData	d1,d2,d3;

	d1	= CAT_new(5);
	printf("H1: 	Value 1 = %ld\n", CAT_get(d1));

  d2	= CAT_new(8);
  if (userInput > 10){
	  CAT_add(d2, d2, d2);
  }
	printf("H1: 	Value 2 = %ld\n", CAT_get(d2));

	d3	= CAT_new(0);
	CAT_add(d3, d1, d2);
	CAT_add(d3, d1, d3);
	CAT_add(d3, d3, d3);
	CAT_add(d3, d1, d1);
	printf("H1: 	Result = %ld\n", CAT_get(d3));

	CAT_sub(d3, d3, d1);
	printf("H1: 	Result = %ld\n", CAT_get(d3));

	CAT_set(d3, 42);
	printf("H1: 	Result = %ld\n", CAT_get(d3));

	return ;
}

int main (int argc, char *argv[]){
	CAT_execution(argc);

    printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
