#include <stdio.h>
#include "CAT.h"

void my_execution (int userInput){
	CATData	d1,d2,d3;

	d1	= CAT_new(userInput);
  d2	= CAT_new(0);
  d3  = CAT_new(0);
	CAT_add(d3, d1, d2);
	printf("Value = %ld\n", CAT_get(d3));

	CAT_add(d3, d3, d2);
	printf("Value = %ld\n", CAT_get(d3));

  CAT_set(d3, 0);
  CAT_sub(d3, d1, d3);
	printf("Value = %ld\n", CAT_get(d3));

	return ;
}

int main (int argc, char *argv[]){
	my_execution(argc);
  printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
