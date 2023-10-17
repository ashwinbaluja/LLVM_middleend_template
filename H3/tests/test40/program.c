#include <stdio.h>
#include "CAT.h"

int main (int argc, char *argv[]){
	CATData	ref;
  CATData ref1 = CAT_new(1);
  CATData ref2 = CAT_new(1);
  CATData ref3 = CAT_new(1);
  CATData ref4 = CAT_new(1);

  if (argc > 100){
    if (strcmp(argv[80], "ciao") == 0){
      ref	= CAT_new(CAT_get(ref1));
    } else {
      ref	= CAT_new(CAT_get(ref2));
    }

  } else {
    if (argc > 10){
      ref	= CAT_new(CAT_get(ref3));
    } else {
      ref	= CAT_new(CAT_get(ref4));
    }
  }

  printf("%ld\n", CAT_get(ref));

CATData d1new = CAT_new(52);
CAT_add(d1new, d1new, d1new);
CAT_sub(d1new, d1new, d1new);
CAT_set(d1new, 42);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
