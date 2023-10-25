#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

int main (int argc, char *argv[]){
  CATData x, y, z;
  void **mem;

  mem = malloc(sizeof(void *));

  z	= CAT_new(2);
  x	= CAT_new(8);
  (*mem) = x;

  y = (*mem);

	printf("H1: 	Y = %ld\n", CAT_get(y));
	printf("H1: 	X = %ld\n", CAT_get(x));
	printf("H1: 	Z = %ld\n", CAT_get(z));

  CAT_add(*mem, *mem, *mem);
	printf("H1: 	Y = %ld\n", CAT_get(y));
	printf("H1: 	X = %ld\n", CAT_get(x));
	printf("H1: 	Z = %ld\n", CAT_get(z));

  CAT_sub(*mem, *mem, *mem);
  CAT_set(*mem, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
