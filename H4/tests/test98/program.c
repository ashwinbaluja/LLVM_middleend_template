#include <stdio.h>
#include <stdlib.h>
#include "CAT.h"

CATData p (int value){
  if (value > 10){
    return CAT_new(5);
  }

  return CAT_new(6);
}

CATData q1 (int valueQ){
  return p(1);
}

CATData q2 (int valueQ){
  return p(valueQ + 8);
}

CATData q3 (int valueQ){
  return p(valueQ + 1);
}

int main (int argc, char *argv[]){
  CATData r = q1(1);
  CATData t = q2(3);
  CATData z = q3(1);

  printf("%ld %ld %ld\n", CAT_get(r), CAT_get(t), CAT_get(z));

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
