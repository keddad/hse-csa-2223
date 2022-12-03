#include "pthread.h"
#include "stdio.h"
#include <bits/pthreadtypes.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

int pot = 0;
int pot_max_size;
static pthread_mutex_t pot_mutex;
static pthread_cond_t pot_full;

int pot_empty = 0;

FILE *in_stream;
FILE *out_stream;

void *bee_thread(void *) {
  fprintf(out_stream, "Bee is alive! Target pot size: %d\n", pot_max_size);

  while (1) {
    sleep(rand() % 2);

    pthread_mutex_lock(&pot_mutex);

    pot++;

    fprintf(out_stream, "Bee got more mead. Curretnly at %d\n", pot);

    if (pot == pot_max_size) {
      fprintf(out_stream, "Full of mead. Call the bear.\n");
      pthread_cond_signal(&pot_full); // poke the bear
    }

    pthread_mutex_unlock(&pot_mutex);
  }
}

void *xi_junping_thread(void *) {
  fprintf(out_stream, "Bear is alive\n");
  while (1) {
    pthread_mutex_lock(&pot_mutex);

    while (pot < pot_max_size) {
      fprintf(out_stream, "Bear is sleeping\n");
      pthread_cond_wait(&pot_full,
                        &pot_mutex); // Wake up the bear when the pot is full
    }

    fprintf(out_stream, "Bear ate all the mead.\n");
    pot = 0;

    pthread_mutex_unlock(&pot_mutex);
  }
}

int main(int argc, char *argv[]) {
  setbuf(stdout, NULL); // say goodbye to buffering
  int bee_number;

  in_stream = stdin;
  out_stream = stdout;

  if (argc == 4 && !strcmp(argv[1], "-f")) {
    in_stream = fopen(argv[2], "r");
    out_stream = fopen(argv[3], "w");
  }

  if (argc == 2 && !strcmp(argv[1], "-r")) {
    srand(time(NULL));
    pot_max_size = (rand() + 1) % 257;
    bee_number = (rand() + 1) % 129;

    printf("Randomly generated pot size: %d\n", pot_max_size);
    printf("Randomly generated bee number: %d\n", bee_number);
  } else {
    fscanf(in_stream, "%d %d", &pot_max_size, &bee_number);

    if (pot_max_size <= 0 || bee_number <= 0 ||
        bee_number >= 512) { // Don't create too much threads
      fprintf(out_stream, "Weird number.");
      return 42;
    }
  }

  pthread_mutex_init(&pot_mutex, NULL);
  pthread_cond_init(&pot_full, NULL);

  pthread_t *threads = malloc(sizeof(pthread_t) * bee_number);
  pthread_t bear_thread;

  pthread_create(&bear_thread, NULL, xi_junping_thread, NULL);

  for (int i = 0; i < bee_number; ++i) {
    pthread_create(&threads[i], NULL, bee_thread, NULL);
  }

  pthread_join(bear_thread, NULL); // Need to join something, might as well be a bear

  return 0;
}