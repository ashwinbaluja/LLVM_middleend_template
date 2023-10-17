#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

__attribute__((noinline))
int escape_reason (CATData d1, CATData d2){
  if (d1 == d2){
    return 1;
  }
  return 0;
}

int main (int argc, char *argv[]) {
  CATData x = CAT_new(5);
  CATData y = CAT_new(7);
  
  int v = escape_reason(x, y);

  CAT_set(x, 42);
  printf("%d %ld %ld\n", v, CAT_get(x), CAT_get(y));
 
  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
