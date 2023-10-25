#include <stdio.h>
#include <stdlib.h>
#include "CAT.h"

CATData p (void){
  return CAT_new(1);
}

int main (int argc, char *argv[]){
  CATData r = p();
  
  CATData t = p();

  printf("%ld %ld\n", CAT_get(r), CAT_get(t));

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
