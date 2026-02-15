#include <stdio.h>

struct point {
    int x;
    int y;
};

int main()
{
    struct point pt1 = {1, 1};
    struct point pt2 = {3, 3};

    struct rect screen = {pt1, pt2};

    int area;
    area = (screen.pt2.x-screen.pt1.x) * (screen.pt2.y-screen.pt1.y);
    printf("area = %d", area);

    return 0;
}
