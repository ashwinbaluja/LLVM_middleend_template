#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

void function_that_complicates_everything (CATData par1){
  CAT_add(par1, par1, par1);
  return ;
}

int main (int argc, char *argv[]){
	CATData d1	= CAT_new(5);
  
  function_that_complicates_everything(d1);

  int64_t value = CAT_get(d1);

  printf("Values: %ld\n", value);

  CATData d1new = CAT_new(52);
  CAT_add(d1new, d1new, d1new);
  CAT_sub(d1new, d1new, d1new);
  CAT_set(d1new, 42);

  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
