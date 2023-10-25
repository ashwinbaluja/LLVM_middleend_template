#include <stdio.h>
#include <stdlib.h>
#include <CAT.h>

CATData CAT_create_aaaaaa_aaaaa (int v){
  return CAT_new(v + 1);
}

int main (int argc, char *argv[]){
  CATData d1	= CAT_create_aaaaaa_aaaaa(5);
  printf("Values: %ld\n", CAT_get(d1));

  CAT_add(d1, d1, d1);
  CAT_sub(d1, d1, d1);
  CAT_set(d1, 42);

  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
  return 0;
}
