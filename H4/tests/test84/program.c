#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

__attribute__((noinline))
CATData myF (CATData d1, CATData d2, int c){
  CAT_set(d1, 11);
  CAT_set(d2, 12);
  if (c > rand()){
    return d2;
  }
  return d1;
}

int main (int argc, char *argv[]) {
  int condition = argc;

  CATData x = CAT_new(5);
  CATData y = CAT_new(7);
  do {

    CATData z = myF(x, y, condition);
    printf("%ld %ld %ld\n", CAT_get(z), CAT_get(x), CAT_get(y));

    CAT_set(x, 43);
    printf("%ld %ld %ld\n", CAT_get(z), CAT_get(x), CAT_get(y));

    condition += 20;

  } while (condition < 100);

  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
