#include <unistd.h>
#include <string.h>

int main() {
    char * st = "Hello World!\n";
    write(1, st, strlen(st));

    return 0;
}