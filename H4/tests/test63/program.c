#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

int main (int argc, char *argv[]) {
  CATData x = CAT_new(5);
  CATData y = CAT_new(7);
  
  CAT_set(x, 42);
  printf("%ld %ld\n", CAT_get(x), CAT_get(y));
 
  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
