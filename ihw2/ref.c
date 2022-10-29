#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

const int SPEEDTEST_N = 100000;
const int MAX_STRING_SIZE = 1024 * 1024;
const int ALPHABET_SIZE = 127;

void read_strings(char* a, char* b, FILE *f) {
  fgets(a, MAX_STRING_SIZE, f);
  fgets(b, MAX_STRING_SIZE, f);
}

void write_arr(char* a, FILE *f) {
  fputs(a, f);
  fputc('\n', f);
}

void generate_arr(char* a, int size) {
  srand(time(NULL)+ (unsigned int) a);

  for (int i = 0; i < size; ++i)
  {
    a[i] = (rand() % ALPHABET_SIZE - 1) + 1;
  }
}

void fill_chararr(char* s, char* chararr) {
  char* cur = s;
  memset(chararr, 0, ALPHABET_SIZE);

  while (*cur != 0) {
    chararr[(*cur) % ALPHABET_SIZE] = 1;
    cur += 1;
  }
}

void gen_answer(char* a_charset, char* b_charset, char* a_diff, char* b_diff){
  memset(a_diff, 0, ALPHABET_SIZE+1);
  memset(b_diff, 0, ALPHABET_SIZE+1);

  char* a_cur = a_diff;
  char* b_cur = b_diff;

  for (int i = 0; i < ALPHABET_SIZE; ++i)
  {
    if (a_charset[i] && !b_charset[i]) {
      *a_cur = i;
      a_cur++;
    }

    if (!a_charset[i] && b_charset[i]) {
      *b_cur = i;
      b_cur++;
    }
  }
} 

int main(int argv, char *argc[]) {
  if (argv < 2) {
    printf("Not enough arguments!");
    return 1;
  }

  char a[MAX_STRING_SIZE], b[MAX_STRING_SIZE];
  char a_letters[ALPHABET_SIZE], b_letters[ALPHABET_SIZE];
  char a_diff[ALPHABET_SIZE+1], b_diff[ALPHABET_SIZE+1];

  char input_type = argc[1][0];
  FILE *output = stdout;

  if (input_type == 'c') {
    read_strings(a, b, stdin);
  } else if (input_type == 'r' || input_type == 's') {
    if (argv < 3) {
      printf("Not enough arguments!");
      return 1;
    }

    int input_size = atoi(argc[2]);
    generate_arr(a, input_size);
    generate_arr(b, input_size);

    printf("Generated strings:\n");

    write_arr(a, stdout);
    write_arr(b, stdout);

  } else if (input_type == 'f') {
    if (argv < 4) {
      printf("Not enough arguments!");
      return 1;
    }

    FILE *in_file = fopen(argc[2], "r");
    output = fopen(argc[3], "w");

    read_strings(a, b, in_file);
  } else {
    printf("Input type argument not recognised!");
    return 1;
  }

  if (input_type == 's') {
    clock_t begin = clock();
    for (int i = 0; i < SPEEDTEST_N; ++i)
    {
      fill_chararr(a, a_letters);
      fill_chararr(b, b_letters);
      gen_answer(a_letters, b_letters, a_diff, b_diff);
    }
    clock_t end = clock();

    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Time spent: %f\n", time_spent);
  } else {
    fill_chararr(a, a_letters);
    fill_chararr(b, b_letters);
    gen_answer(a_letters, b_letters, a_diff, b_diff);
    write_arr(a_diff, output);
    write_arr(b_diff, output);
  }

  fclose(output);
  return 0;
}