#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

int64_t my_f (CATData d, const CATData cat_1){
  int64_t d_v = CAT_get(d);

  if (d_v == 0){
    return CAT_get(d);
  }

  CAT_sub(d, d, cat_1);

  return my_f(d, cat_1);
}

int main (int argc, char *argv[]){
  CATData d = CAT_new(argc + 100);
  CATData cat_1 = CAT_new(1);

  int64_t v = my_f(d, cat_1);

  printf("Value at the end: %ld %ld\n", CAT_get(d), v);

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
