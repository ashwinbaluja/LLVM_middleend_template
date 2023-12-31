#include <stdio.h>
#include "CAT.h"

void CAT_execution (int userInput){
	CATData	d1,d2,d3;

  if (userInput < 100){
    goto WHAT_IS_GOING_ON;
  }

REALLY:
  for (int i=0; i < userInput; i++){
    d2	= CAT_new(8);
    if (userInput > 10){
	    CAT_add(d2, d2, d2);
    }
	  printf("H1: 	Value 2 = %ld\n", CAT_get(d2));

	  d3	= CAT_new(0);
	  CAT_add(d3, d1, d2);
	  CAT_add(d3, d1, d3);
	  CAT_add(d3, d3, d3);
    if (userInput > 20){
	    CAT_add(d3, d1, d1);
	    CAT_sub(d3, d3, d1);
	    CAT_set(d1, 42);
    }
	  printf("H1: 	Result = %ld\n", CAT_get(d3));
  }
  goto WAS_IT_NECESSARY;

WHAT_IS_GOING_ON:
	d1	= CAT_new(5);
	printf("H1: 	Value 1 = %ld\n", CAT_get(d1));
  goto REALLY;

WAS_IT_NECESSARY:
	return ;
}

int main (int argc, char *argv[]){
	CAT_execution(argc);

    printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
