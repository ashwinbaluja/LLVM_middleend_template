#include <stdio.h>
#include "CAT.h"

void my_execution (void){
	CATData	d1;
	CATData	d2;
	CATData	d3;

	d1	= CAT_new(5);
	printf(" 	Value 1 = %ld\n", CAT_get(d1));
	d2	= CAT_new(8);
	printf(" 	Value 2 = %ld\n", CAT_get(d2));

	d3	= CAT_new(0);
	CAT_add(d3, d1, d2);
	printf(" 	Result = %ld\n", CAT_get(d3));

	CAT_sub(d3, d1, d2);
	printf(" 	Result = %ld\n", CAT_get(d3));

	CAT_set(d3, 42);
	printf(" 	Result = %ld\n", CAT_get(d3));

  if (rand() > 0){
    CAT_add(d3, d3, d1);
    CAT_sub(d3, d3, d2);
	  CAT_set(d2, 41);
	  CAT_set(d1, 39);
  }
  CAT_add(d3, d3, d2);
  CAT_add(d3, d3, d1);
	printf(" 	Result = %ld\n", CAT_get(d3));

  CAT_destroy(d1);
  CAT_destroy(d2);
  CAT_destroy(d3);

	return ;
}

int main (int argc, char *argv[]){
	printf(" Begin\n");
	my_execution();
	printf(" End\n");

  printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
