#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

void a_generic_C_function (void){
  CATData d1 = CAT_new(5);
  CATData d2 = CAT_new(3);
  CATData *p1 = &d1;
  CATData *p2 = &d2;

	printf("H5: 	Value of = %ld\n", CAT_get(*p1));
	printf("H5: 	Value of = %ld\n", CAT_get(*p2));

  if (rand() == 0){
    p1 = p2;
  }

	printf("H5: 	Value of = %ld\n", CAT_get(*p1));
	printf("H5: 	Value of = %ld\n", CAT_get(*p2));

  CAT_add(d1, d1, d1);
  CAT_sub(d1, d1, d1);

	printf("H5: 	Value of = %ld\n", CAT_get(*p1));
	printf("H5: 	Value of = %ld\n", CAT_get(*p2));

  CAT_set(d1, 5);
	printf("H5: 	Value of = %ld\n", CAT_get(*p1));
	printf("H5: 	Value of = %ld\n", CAT_get(*p2));

  return ;
}


int main (int argc, char *argv[]){
  a_generic_C_function();
  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
