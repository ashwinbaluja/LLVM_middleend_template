#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

int main (int argc, char *argv[]){
  CATData x,y;
  void **ref1;
  void **ref2;

  ref1 = malloc(sizeof(void *));
  ref2 = malloc(sizeof(void *));

  x	= CAT_new(8);
  y = CAT_new(42);

  (*ref1) = x;
  (*ref2) = y;

  CAT_add(*ref2, x, y);

  printf("H1: 	X    = %ld\n", CAT_get(x));
  printf("H1: 	Y    = %ld\n", CAT_get(y));
  printf("H1: 	Ref1 = %ld\n", CAT_get(*ref1));
  printf("H1: 	Ref2 = %ld\n", CAT_get(*ref2));

  free(ref1);
  free(ref2);

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
