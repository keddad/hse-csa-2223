#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

const int SPEEDTEST_N = 100000000;
const double MAX_ABS_X = 0.6; // bigger then that leads to big delta

double calc(double x) {
    // a == 0
    double answ = 1;
    double x_powed = 1;

    for (int i = 0; i < 8; ++i) { // Reduce number of multiplications by not using pow()
        x_powed *= x;
        answ += x_powed;
    }

    return answ;
}

double read_double(FILE *f) {
    double x;
    fscanf(f, "%lf", &x);

    return x;
}

double rand_double() {
    srand((unsigned) time(0));
    return (rand() > RAND_MAX / 2 ? -1 : 1) *(MAX_ABS_X / RAND_MAX) * rand();
}

int main(int argv, char *argc[]) {
    double x;

    if (argv < 2) {
        printf("Not enough arguments!");
        return 1;
    }

    char input_type = argc[1][0];
    FILE *output = stdout;

    if (input_type == 'c') {
        x = read_double(stdin);
    } else if (input_type == 'r' || input_type == 's') {
        x = rand_double();
        printf("Generated x: %lf\n", x);
    } else if (input_type == 'f') {
        if (argv < 4) {
            printf("Not enough arguments!");
            return 1;
        }

        FILE *in_file = fopen(argc[2], "r");
        output = fopen(argc[3], "w");

        x = read_double(in_file);
    } else {
        printf("Input type argument not recognised!");
        return 1;
    }

    if (x < -0.6 || x > 0.6) {
        fprintf(stderr, "X is too far from 0; delta will be huge");
    }

    double answ;

    if (input_type == 's') {
        clock_t begin = clock();
        for (int i = 0; i < SPEEDTEST_N; ++i)
        {
            answ = calc(x);
        }
        clock_t end = clock();

        double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
        printf("Time spent: %f\n", time_spent);
    } else {
        answ = calc(x);
        fprintf(output, "%lf\n", answ);
    }

    fclose(output);
    return 0;
}