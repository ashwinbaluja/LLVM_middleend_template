#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <CAT.h>

typedef struct {
  CATData *d1;
  CATData *d2;
} myT;

void f (CATData *p){
  CAT_set(*p, 5);
  CAT_add(*p, *p, *p);
  CAT_sub(*p, *p, *p);
}


void a_generic_C_function (int v){
  CATData d1 = CAT_new(5);
  CATData d2 = CAT_new(3);
  myT t;

  t.d1 = &d1;
  t.d2 = &d2;
  if (sqrt(rand()) < sqrt(v)){
    t.d2 = &d1;
  }
  f(t.d2);

	printf("H5: 	Value of = %ld\n", CAT_get(d1));

  return ;
}


int main (int argc, char *argv[]){
  a_generic_C_function(argc);
  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
