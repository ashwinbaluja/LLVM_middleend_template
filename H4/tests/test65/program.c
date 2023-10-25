#include <stdio.h>
#include <stdlib.h>
#include "CAT.h"

int main (int argc, char *argv[]){
  CATData x = CAT_new(40);
  CATData y = CAT_new(2);
  CATData z = CAT_new(0);

  for (int i=0; i < 10; i++){
    printf("Z: %ld\n", CAT_get(z));

    CAT_add(z, x, y);
    printf("Z: %ld\n", CAT_get(z));

    CAT_add(x, x, x);
    CAT_add(y, y, y);
    CATData z2 = z;

    z = CAT_new(1);

    CAT_set(z2, rand());
    printf("Z2: %ld %ld\n", CAT_get(z), CAT_get(z2));
  }

  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
