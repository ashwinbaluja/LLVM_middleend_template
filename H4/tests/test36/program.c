#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

int my_f (const CATData const d, int var) {
  if (d == NULL){
    return var+1;
  }
  
  return 0;
}

int main (int argc, char *argv[]){
  CATData d = CAT_new(5);

  int v = my_f(d, argc);

  printf("Value at the end: %ld\n", CAT_get(d) + v);

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
