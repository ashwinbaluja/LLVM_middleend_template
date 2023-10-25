#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

void you_cannot_take_decisions_based_on_function_names (CATData par1){
  CAT_add(par1, par1, par1);
  return ;
}

int main (int argc, char *argv[]){
	CATData d1	= CAT_new(5);
  
  you_cannot_take_decisions_based_on_function_names(d1);

  int64_t value = CAT_get(d1);

  printf("Values: %ld\n", value);

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
