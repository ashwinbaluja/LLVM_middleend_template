#include <stdio.h>
#include <CAT.h>

__attribute__((noinline))
void CAT_execution (int userInput, CATData d1, int userInput2){
	CAT_set(d1, 44);
	return ;
}

int main (int argc, char *argv[]){
  CATData x;

  x	= CAT_new(8);
	CAT_execution(argc, x, argc+1);

	printf("Result = %d\n", CAT_get(x));
  
  printf("CAT variables = %ld\n", CAT_variables()); 
  printf("CAT cost = %ld\n", CAT_cost());
	return 0;
}
