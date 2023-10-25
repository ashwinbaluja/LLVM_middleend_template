#include <stdio.h>
#include "CAT.h"

CATData selector1(CATData d1, CATData d2, int in) {
    if (in > 0) {
        return d1;
    } else {
        return d2;
    }
}

CATData selector2(CATData d1, CATData d2, int in) {
    if (in <= 0) {
        return d1;
    } else {
        return d2;
    }
}

void setrandom(CATData d1, CATData d2, int in) {
    if (in < 0) {
        CAT_set(d1, -1);
    } else {
        CAT_set(d2, 0xfeeff00f);
    }
}

void my_execution (int ui) {
    CATData d1 = CAT_new(0xf00fba11);
    CATData d2 = CAT_new(0xbaadbaad);

    CATData d3 = selector1(d1, d2, ui);
    CATData d4 = selector2(d1, d2, ui);

    setrandom(d3, d4, ui);

    CAT_set(d1, 0xf00fba11);

    printf("d1: %lx\n", CAT_get(d1));
    printf("d2: %lx\n", CAT_get(d2));

    CAT_add(d1, d1, d1);
    CAT_sub(d1, d1, d1);
    printf("d1: %lx\n", CAT_get(d1));

    return ;
}

int main (int argc, char *argv[]){
    printf("H1: Begin\n");
    my_execution(argc);
    printf("H1: End\n");

    printf("CAT variables = %ld\n", CAT_variables());
    printf("CAT cost = %ld\n", CAT_cost());
    return 0;
}
