#include <stdio.h>
#include "CAT.h"

void myF (void){
	CATData	d1,d2,d3;

	d1	= CAT_new(5);
	d2	= CAT_new(6);
	d3	= CAT_new(0);

  CAT_add(d3, d1, d2);
  CAT_sub(d3, d3, d1);

	printf("H1: 	Result = %ld\n", CAT_get(d3));
  CAT_set(d3, 42);

	printf("H1: 	Result = %ld\n", CAT_get(d3));
	return ;
}

int main (int argc, char *argv[]){
	myF();
CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);

    printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
