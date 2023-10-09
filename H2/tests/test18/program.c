#include <stdio.h>
#include "CAT.h"

void CAT_execution (int userInput){
	CATData	d1;
	CATData	d2;
	CATData	d3;

	d1	= CAT_new(1);
	d2	= CAT_new(2);
	d3	= CAT_new(42);
	printf("Value d1  = %ld\n", CAT_get(d1));
	printf("Value d2  = %ld\n", CAT_get(d2));
	printf("Value d3  = %ld\n", CAT_get(d3));

  CAT_set(d3, 0);

	printf("Value d1  = %ld\n", CAT_get(d1));
	printf("Value d2  = %ld\n", CAT_get(d2));
	printf("Value d3  = %ld\n", CAT_get(d3));

  CAT_add(d3, d1, d2);

	printf("Value d1  = %ld\n", CAT_get(d1));
	printf("Value d2  = %ld\n", CAT_get(d2));
	printf("Value d3  = %ld\n", CAT_get(d3));

  CAT_sub(d3, d1, d2);
	printf("Value d3  = %ld\n", CAT_get(d3));

  return ;
}

int main (int argc, char *argv[]){
	CAT_execution(argc);

    printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
