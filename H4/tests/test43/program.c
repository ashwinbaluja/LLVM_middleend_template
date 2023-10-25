#include <stdio.h>
#include <stdlib.h>
#include "CAT.h"

void p (uint64_t v, CATData d){
  CATData m;

  if (v == 0){
    return CAT_add(d, d, CAT_new(1));
  }

  CATData tmp = CAT_new(v + 5);
  CAT_add(d, d, tmp);

  p(v - 1, d);
  return ;
}

int main (int argc, char *argv[]){
  CATData x = CAT_new(7);
  for (int i=1; i <= 5; i++){
    p(i, x);
    printf("%ld\n", CAT_get(x));
  }

  CATData d1new = CAT_new(52);
  CAT_add(d1new, d1new, d1new);
  CAT_sub(d1new, d1new, d1new);
  CAT_set(d1new, 42);

  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
