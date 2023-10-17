#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

void my_f (CATData d){
  printf("Value: %ld\n", CAT_get(d));
  
  return ;
}

int main (int argc, char *argv[]){
  CATData d = CAT_new(5);

  my_f(d);

  printf("Value at the end: %ld\n", CAT_get(d));
  CATData d1new = CAT_new(52);
  CAT_add(d1new, d1new, d1new);
  CAT_sub(d1new, d1new, d1new);
  CAT_set(d1new, 42);

  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
