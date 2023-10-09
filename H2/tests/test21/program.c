#include <stdio.h>
#include "CAT.h"

int main (int argc, char *argv[]){
  CATData d = CAT_new(argc);
  CAT_add(d, d, d);
  CAT_sub(d, d, d);
  CAT_set(d, 42);
  printf("%ld\n", CAT_get(d));

    printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
