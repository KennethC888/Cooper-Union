#include <stdio.h>

// K&R pg. 158
// rudimentary calculator

int main()
{
    double sum, v;
    sum = 0;
    while (scanf("%lf", &v) == 1)
        printf("\t%.2f\n", sum+=v);

    return 0;
}
