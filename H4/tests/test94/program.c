#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

int64_t generic_C_function (CATData y, int64_t scalarValue){
  CATData x;
  void **ref;

  ref = malloc(sizeof(void *));

  x = CAT_new(scalarValue);
  (*ref) = x;

  if (CAT_get(y) > 10){
    int64_t v = CAT_get(x);
    free(ref);
    return (v * 51) / 2;
  }
  free(ref);

  return 0;
}

int main (int argc, char *argv[]){
  printf("%ld\n", generic_C_function(CAT_new(12), 50));

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
