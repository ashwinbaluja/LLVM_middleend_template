#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

int main (int argc, char *argv[]){
  CATData d1,d2;
  CATData *dp;
  int64_t value, value1, value2;

	d1	= CAT_new(5);
	d2	= CAT_new(7);
  
  int newValue = (argc > 10) ? 10 : 42;
  CAT_set(d1, newValue);

  value1 = CAT_get(d1);
  value2 = CAT_get(d2);

  printf("Values: %ld %ld\n", value1, value2);
  CATData d1new = CAT_new(52);
  CAT_add(d1new, d1new, d1new);
  CAT_sub(d1new, d1new, d1new);
  CAT_set(d1new, 42);

  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
