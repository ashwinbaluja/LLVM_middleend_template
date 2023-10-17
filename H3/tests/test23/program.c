#include <stdio.h>
#include "CAT.h"

void CAT_execution (int userInput){
	CATData	d1,d2,d3,d4,d5,d6,d7;

	d1	= CAT_new(5);
	printf("H3: 	Value 1 = %ld\n", CAT_get(d1));

  d2	= CAT_new(8);
	printf("H3: 	Value 2 = %ld\n", CAT_get(d2));

	d3	= CAT_new(42);
	printf("H3: 	Value 3 = %ld\n", CAT_get(d3));

	CAT_add(d3, d1, d2);
	printf("H3: 	Value 3 = %ld\n", CAT_get(d3));
	
	CAT_sub(d3, d1, d2);
	printf("H3: 	Value 3 = %ld\n", CAT_get(d3));

  CAT_set(d3, 5);

	return ;
}

int main (int argc, char *argv[]){
	CAT_execution(argc);

    printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
