#include <stdio.h>
#include <CAT.h>

int main (int argc, char *argv[]) {
    CATData x = CAT_new(5);

    int c=0;
    do {
      printf("Funny: %d\n", CAT_get(x));

      CAT_set(x, 3);
      x = CAT_new(5);

      c++;
    } while (c < 100);

    CAT_add(x, x, x);
    CAT_sub(x, x, x);

    printf("CAT variables = %ld\n", CAT_variables()); 
    printf("CAT cost = %ld\n", CAT_cost());
    return 0;
}
