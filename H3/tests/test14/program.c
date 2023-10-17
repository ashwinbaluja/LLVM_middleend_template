#include <stdio.h>
#include "CAT.h"

void myF (void){
	CATData	d1;

	d1	= CAT_new(5);

  CAT_set(d1, 42);
  CAT_set(d1, 42);

	printf("H1: 	Result = %ld\n", CAT_get(d1));

  CAT_add(d1, d1, d1);
  CAT_sub(d1, d1, d1);
	printf("H1: 	Result = %ld\n", CAT_get(d1));

	return ;
}

int main (int argc, char *argv[]){
	myF();

    printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
