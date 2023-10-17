#include <stdio.h>
#include <CAT.h>

void a_generic_C_function (CATData d1, int argc){
L1:
  if (argc < 100) return;
  if (CAT_get(d1) > 10){
    d1	= CAT_new(CAT_get(d1) - 1);
  } else {
    argc--;
  }

  if (argc > 10){
    d1	= CAT_new(CAT_get(d1) - 1);
  }
  goto L1;
  
  return ;
}


int main (int argc, char *argv[]){
  CATData x = CAT_new(5);
  a_generic_C_function(x, argc);

  CAT_add(x, x, x);
  CAT_sub(x, x, x);
  CAT_set(x, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
