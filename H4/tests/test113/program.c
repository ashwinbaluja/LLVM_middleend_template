#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

void f (CATData *p){
  CAT_set(*p, 5);
  CAT_add(*p, *p, *p);
  CAT_sub(*p, *p, *p);
}


void a_generic_C_function (int v, CATData **p){
  CATData d1 = CAT_new(5);
  CATData d2 = CAT_new(3);
  CATData *p1 = &d1;
  CATData *p2 = &d2;
  (*p) = p2;

	printf("H5: 	Value of = %ld\n", CAT_get(*p1));
	printf("H5: 	Value of = %ld\n", CAT_get(*p2));

  if (v){
    f(p1);
  }

	printf("H5: 	Value of = %ld\n", CAT_get(*p1));
	printf("H5: 	Value of = %ld\n", CAT_get(*p2));

  return ;
}


int main (int argc, char *argv[]){
  CATData *p;
  a_generic_C_function(argc, &p);
  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
