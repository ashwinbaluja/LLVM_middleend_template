#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

int main (int argc, char *argv[]){
  CATData x, y;
  void **mem;

  mem = malloc(sizeof(void *));

  x	= CAT_new(8);
  (*mem) = x;

  y = (*mem);

	printf("H1: 	Y = %ld\n", CAT_get(y));
	printf("H1: 	X = %ld\n", CAT_get(x));

  CAT_add(*mem, *mem, *mem);
	printf("H1: 	Y = %ld\n", CAT_get(y));
	printf("H1: 	X = %ld\n", CAT_get(x));

  CATData d1new = CAT_new(52);
  CAT_add(d1new, d1new, d1new);
  CAT_sub(d1new, d1new, d1new);
  CAT_set(d1new, 42);

  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
