#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const int SPEEDTEST_N = 100000;

void read_arr(int s, int *arr, FILE *f) {
  for (int i = 0; i < s; ++i) {
    fscanf(f, "%d", arr + i);
  }
}

void write_arr(int s, int *arr, FILE *f) {
  for (int i = 0; i < s; ++i) {
    fprintf(f, "%d ", *(arr + i));
  }

  fprintf(f, "\n");
}

void generate_arr(int s, int *arr) {
  srand(time(NULL));

  for (int i = 0; i < s; ++i) {
    arr[i] = rand();

    if (rand() % 2) {
      arr[i] = -arr[i];
    }
  }
}

void process(int s, int *arr, int *out_arr) {
  for (int i = 0; i < s; ++i) {
    if (arr[i] > 0) {
      out_arr[i] = 2;
    } else if (arr[i] < 0) {
      out_arr[i] = arr[i] + 5;
    }
  }
}

int main(int argv, char *argc[]) {
  if (argv < 3) {
    printf("Not enough arguments!");
    return 1;
  }

  char input_type = argc[1][0];
  int input_size = atoi(argc[2]);
  FILE *output = stdout;

  int *arr = malloc(sizeof(int) * input_size);
  int *out_arr = malloc(sizeof(int) * input_size);

  if (input_type == 'c') {
    read_arr(input_size, arr, stdin);
  } else if (input_type == 'r' || input_type == 's') {
    generate_arr(input_size, arr);

    printf("Generated array: ");
    write_arr(input_size, arr, output);

  } else if (input_type == 'f') {
    if (argv < 5) {
      printf("Not enough arguments!");
      return 1;
    }

    FILE *in_file = fopen(argc[4], "r");
    output = fopen(argc[5], "w");
    read_arr(input_size, arr, in_file);

    fclose(in_file);
  } else {
    printf("Input type argument not recognised!");
    return 1;
  }

  if (input_type == 's') {
    clock_t begin = clock();
    for (int i = 0; i < SPEEDTEST_N; ++i)
    {
      process(input_size, arr, out_arr);
    }
    clock_t end = clock();

    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Time spent: %f\n", time_spent);
  } else {
    process(input_size, arr, out_arr);
    write_arr(input_size, out_arr, output);
  }

  fclose(output);
  free(arr);
  free(out_arr);
  return 0;
}