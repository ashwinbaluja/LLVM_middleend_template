#include <stdio.h>
#include <CAT.h>

int main (int argc, char *argv[]){
  CATData d1;
  
  if (argc > 10){
    d1	= CAT_new(8);
  } else {
    d1	= CAT_new(8);
  }

	printf("H5: 	Value of d1 = %ld\n", CAT_get(d1));

  CATData d1new = CAT_new(52);
  CAT_add(d1new, d1new, d1new);
  CAT_sub(d1new, d1new, d1new);
  CAT_set(d1new, 42);

  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
