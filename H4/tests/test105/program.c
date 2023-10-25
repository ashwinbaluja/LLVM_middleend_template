#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

CATData * function_that_complicates_everything (int argc, CATData *par1, CATData *par2){
  if (argc > 5){
    return par1;
  }
  return par2;
}

int main (int argc, char *argv[]){
  CATData d1,d2;
  CATData *dp;
  int64_t value, value1, value2;

	d1	= CAT_new(5);
	d2	= CAT_new(7);
  
  dp = function_that_complicates_everything(argc, &d1, &d2);

  value = CAT_get(*dp);
  value1 = CAT_get(d1);
  value2 = CAT_get(d2);

  printf("Values: %ld %ld %ld\n", value, value1, value2);

  CAT_add(d1, d1, d1);
  CAT_sub(d1, d1, d1);
  CAT_set(d1, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
