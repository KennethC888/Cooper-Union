#include <stdio.h>

void ranges(int x[], int npts, int *max_ptr, int *min_ptr) {
    if (npts <= 0) {
        printf("Error: Array has no elements\n");
        return;
    }

    *max_ptr = x[0];
    *min_ptr = x[0];

    for (int i = 1; i < npts; i++) {
        if (x[i] > *max_ptr) {
            *max_ptr = x[i];
        }
        if (x[i] < *min_ptr) {
            *min_ptr = x[i];
        }
    }
}

int main() {
    int npts = 0, x[10], max_val, min_val;
    char c;

    printf("Enter up to 10 integers separated by spaces: ");

    while (1) {
        c = getchar();
        if (c == ' ' || c == '\n') {
            if (npts >= 10 || c == '\n') {
                break;
            }
            npts++;
        } else if ('0' <= c && c <= '9') {
            x[npts] = x[npts] * 10 + (c - '0');
        }
    }

    ranges(x, npts, &max_val, &min_val);

    printf("Maximum value: %d\n", max_val);
    printf("Minimum value: %d\n", min_val);

    return 0;
}

