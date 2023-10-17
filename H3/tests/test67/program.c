#include <stdio.h>
#include <stdlib.h>
#include "CAT.h"

int main (int argc, char *argv[]){
  CATData x = CAT_new(40);
  CATData y = CAT_new(2);
  CATData z = CAT_new(1);

  CATData z2 = z;

  if (argc > 100){
    z = CAT_new(1);
  }

  CAT_set(z2, argc);
  printf("Z2: %ld %ld\n", CAT_get(z), CAT_get(z2));

  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
