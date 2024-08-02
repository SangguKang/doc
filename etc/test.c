#include <stdio.h>

int main()
{
    int source = 0x0064032;
    int s1 = source & 0xff;
    printf("source = %x\n", source);
    printf("s1 = %x\n", s1);
    int s2 = (source >> 8) & 0xff;
    printf("s2 = %x\n", s2);
    int arr[32] = {0,};
    return 0;
}