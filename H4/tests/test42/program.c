#include <stdio.h>
#include <stdlib.h>
#include "CAT.h"

CATData p (CATData v){
  CATData m;

  if (CAT_get(v) < 10){
    m = CAT_new(1);
  } else {
    m = CAT_new(2);
  }
  return m;
}

int main (int argc, char *argv[]){
  CATData x = CAT_new(7);
  CATData r = p(x);
  
  CATData y = CAT_new(80);
  CATData t = p(y);

  printf("%ld %ld\n", CAT_get(r), CAT_get(t));

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
