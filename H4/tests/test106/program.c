#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

__attribute__((noinline))
void f (CATData p){
  CAT_set(p, 42);
}

void a_generic_C_function (int v){
  CATData d1 = CAT_new(5);
  CATData d2 = CAT_new(3);
  CATData d3 = CAT_new(0);

  if (v){
    f(d1);
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
