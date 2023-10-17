#include <stdio.h>
#include <CAT.h>

void CAT_execution (CATData	d1){
	CATData d2,d3;

  d2	= CAT_new(8);
	CAT_add(d1, d2, d2);
	printf("H1: 	Value 2 = %ld\n", CAT_get(d2));

	d3	= CAT_new(0);
	CAT_add(d3, d1, d2);
	printf("H1: 	Result = %ld\n", CAT_get(d3));

	return ;
}

int main (int argc, char *argv[]){
  CATData d1;
	d1	= CAT_new(5);
	
  CAT_execution(d1);

  CATData d1new = CAT_new(52);
  CAT_add(d1new, d1new, d1new);
  CAT_sub(d1new, d1new, d1new);
  CAT_set(d1new, 42);

  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
