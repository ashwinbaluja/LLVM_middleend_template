#include <stdio.h>
#include <stdlib.h>
#include "CAT.h"

int main (int argc, char *argv[]){
  CATData x = CAT_new(40);
  CATData y = CAT_new(2);
  CATData z = CAT_new(0);

  for (int i=0; i < 10; i++){
    CAT_add(z, x, y);
    CAT_add(x, x, x);
    CAT_add(y, y, y);

    z = CAT_new(1);

    for (int j=0; j < 10; j++){
      printf("Z2: %ld\n", CAT_get(z));

      CAT_add(z, x, y);
      CAT_add(x, x, x);
      CAT_add(y, y, y);

      if (rand() < 0){
        z = CAT_new(1);
      }
    }
  }

  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
