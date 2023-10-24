#include <stdio.h>
#include <CAT.h>

void a_generic_C_function (CATData d1, int argc){
  goto L1 ;

L3:
  if (argc > 100){
    d1	= CAT_new(8);
  }
	printf("H5: 	Value of d1 = %ld\n", CAT_get(d1));
  return ;

L2:
  if (argc > 10){
    d1	= CAT_new(8);
  }
  goto L3;

L1:   
  d1	= CAT_new(8);
  goto L2;
}


int main (int argc, char *argv[]){
  a_generic_C_function(CAT_new(5), argc);
  CATData d1new = CAT_new(52);
  CAT_add(d1new, d1new, d1new);
  CAT_sub(d1new, d1new, d1new);
  CAT_set(d1new, 42);

  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}