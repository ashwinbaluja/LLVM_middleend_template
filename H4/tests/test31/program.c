#include <stdio.h>
#include <CAT.h>

int main (int argc, char *argv[]){
  CATData x;
  x	= CAT_new(8);
  x	= CAT_new(9);
	printf("H1: 	X = %ld\n", CAT_get(x));
  CAT_add(x, x, x);
	printf("H1: 	X = %ld\n", CAT_get(x));
  CATData d1new = CAT_new(52);
  CAT_add(d1new, d1new, d1new);
  CAT_sub(d1new, d1new, d1new);
  CAT_set(d1new, 42);

  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
