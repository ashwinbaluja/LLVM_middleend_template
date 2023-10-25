#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

typedef struct {
  CATData complexPtr;
} myT;

__attribute__((noinline))
void f (myT *p, CATData v0){
  p->complexPtr = v0;
}

__attribute__((noinline))
void g (myT *p){
  CAT_set(p->complexPtr, 42);
}

void a_generic_C_function (int v){
  CATData d1 = CAT_new(5);
  CATData d2 = CAT_new(3);
  CATData d3 = CAT_new(0);
  myT a;
 
  printf("Value of d1 = %ld\n", CAT_get(d1));
  printf("Value of d2 = %ld\n", CAT_get(d2));
  printf("Value of d3 = %ld\n", CAT_get(d3));

  f(&a, d1);

  printf("Value of d1 = %ld\n", CAT_get(d1));
  printf("Value of d2 = %ld\n", CAT_get(d2));
  printf("Value of d3 = %ld\n", CAT_get(d3));

  if (v > -42){
    printf("Value of d1 = %ld\n", CAT_get(d1));
    printf("Value of d2 = %ld\n", CAT_get(d2));
    printf("Value of d3 = %ld\n", CAT_get(d3));

    g(&a);

    printf("Value of d1 = %ld\n", CAT_get(d1));
    printf("Value of d2 = %ld\n", CAT_get(d2));
    printf("Value of d3 = %ld\n", CAT_get(d3));

    CAT_set(d1, 99);
    printf("Value of d1 = %ld\n", CAT_get(d1));

    if (v > 0){
      g(&a);
    }
    printf("Value of d1 = %ld\n", CAT_get(d1));
  }

  printf("Value of d1 = %ld\n", CAT_get(d1));
  printf("Value of d2 = %ld\n", CAT_get(d2));
  printf("Value of d3 = %ld\n", CAT_get(d3));

  return ;
}


int main (int argc, char *argv[]){
  a_generic_C_function(argc);

  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
