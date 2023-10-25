#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

typedef struct {
  CATData d1;
  CATData d2;
  CATData d3;
} MyT ;

typedef struct {
  MyT *p1;
  MyT *p2;
} MyOutputT;

void a_generic_C_function (MyOutputT *o){
  MyT *s1 = (MyT *)malloc(sizeof(MyT));
  MyT *s2 = (MyT *)malloc(sizeof(MyT));

  s1->d1 = CAT_new(8);
  s1->d2 = CAT_new(9);
  s1->d3 = CAT_new(10);

  s2->d1 = CAT_new(1);
  s2->d2 = CAT_new(2);
  s2->d3 = CAT_new(3);

	printf("H5: Value of s1->d1 = %ld\n", CAT_get(s1->d1));
	printf("H5: Value of s1->d2 = %ld\n", CAT_get(s1->d2));
	printf("H5: Value of s1->d3 = %ld\n", CAT_get(s1->d3));

	printf("H5: Value of s2->d1 = %ld\n", CAT_get(s2->d1));
	printf("H5: Value of s2->d2 = %ld\n", CAT_get(s2->d2));
	printf("H5: Value of s2->d3 = %ld\n", CAT_get(s2->d3));

  CATData d = CAT_new(5);
  CAT_add(d, d, d);
  CAT_sub(d, d, d);
  CAT_set(d, 42);

  o->p1 = s1;
  o->p2 = s2;
  return ;
}

int main (int argc, char *argv[]){
  MyOutputT o;
  a_generic_C_function(&o);
  printf("CAT variables = %ld\n", CAT_variables()); printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
