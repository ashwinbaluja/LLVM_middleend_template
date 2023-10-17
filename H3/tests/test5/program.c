#include <CAT.h>

int main (int argc, char *argv[]){
  CATData d = CAT_new(5);
  CAT_add(d, d, d);
  CAT_sub(d, d, d);
  CAT_set(d, 42);
  CAT_get(d);

  CAT_destroy(d);
  printf("CAT variables = %ld\n", CAT_variables());
  printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
