#include <stdio.h>
#include <CAT.h>

int main(int argc, char **argv) {
  CATData x = CAT_new(5);
  CATData y = CAT_new(8);
  CATData *p;

  if (argc > 5) p = &x; else p = &y;

  *p = CAT_new(10);

  printf("%ld %ld\n", CAT_get(x), CAT_get(y));

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
