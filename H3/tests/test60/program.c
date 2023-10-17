#include <stdio.h>
#include <CAT.h>

void CAT_execution (int userInput, CATData d1, int userInput2){
    CATData d2,d3;

    d2	= CAT_new(8);
    if (userInput > 10){
        CAT_set(d1, 0xf00fba11);
    }
    printf("H1: 	Value 1 = %ld\n", CAT_get(d1));

    if (userInput2 > 0) {
        printf("H1: 	Value 2 = %ld\n", CAT_get(d2));
    }

    d3	= CAT_new(0);
    CAT_add(d3, d1, d2);
    printf("H1: 	Result = %ld\n", CAT_get(d3));

    return;
}

int main (int argc, char *argv[]) {
    CATData x;

    x = CAT_new(1);
    CAT_execution(argc, x, argc + 1);

    CAT_sub(x, x, x);
    CAT_set(x, 42);

    printf("CAT variables = %ld\n", CAT_variables()); 
    printf("CAT cost = %ld\n", CAT_cost());
    return 0;
}
