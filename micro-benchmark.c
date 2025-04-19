#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <string.h>
#include <errno.h>

#define PAGE_SIZE (2 * 1024 * 1024) // 2MB huge page

void exit_with_error(const char *msg) {
    perror(msg);
    exit(EXIT_FAILURE);
}

// Get current time in microseconds
long long get_time_us() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec * 1000000LL + tv.tv_usec;
}

// Child process work function
void child_work(void *addr, size_t length, int child_id) {
    long long start = get_time_us();

    if (munmap(addr, length) == -1) {
        exit_with_error("munmap failed");
    }

    long long end = get_time_us();
    printf("Child %d unmap time: %.3f ms\n", child_id, (end - start)/1000.0);
    exit(0);
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <memory_size_MB> <repeat_times> <child_processes>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    size_t mem_size = atol(argv[1]) * 1024 * 1024;
    int repeat = atoi(argv[2]);
    int num_children = atoi(argv[3]);

    if (mem_size <= 0 || repeat <= 0 || num_children <= 0) {
        fprintf(stderr, "All parameters must be positive integers\n");
        exit(EXIT_FAILURE);
    }

    // Check if transparent hugepages are enabled
    if (system("cat /sys/kernel/mm/transparent_hugepage/enabled") != 0) {
        fprintf(stderr, "Warning: Failed to check transparent hugepage status\n");
    }

    for (int r = 0; r < repeat; r++) {
        printf("\n=== Round %d ===\n", r+1);

        // Allocate regular memory (not forcing hugepages)
        void *addr = mmap(NULL, mem_size, PROT_READ|PROT_WRITE,
                         MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
        if (addr == MAP_FAILED) {
            exit_with_error("mmap failed");
        }

        // Suggest kernel to use hugepages (transparent hugepages)
        if (madvise(addr, mem_size, MADV_HUGEPAGE) == -1) {
            exit_with_error("madvise MADV_HUGEPAGE failed");
        }

        // Write to memory (ensure actual allocation)
        printf("Writing to memory (size=%zu MB)...\n", mem_size/(1024*1024));
        memset(addr, 0xFF, mem_size);

        long long fork_start = get_time_us();

        // Create child processes
        pid_t pids[num_children];
        for (int i = 0; i < num_children; i++) {
            pids[i] = fork();
            if (pids[i] < 0) {
                exit_with_error("fork failed");
            } else if (pids[i] == 0) {
                // Child process
                child_work(addr, mem_size, i+1);
            }
        }

        // Parent waits for all children
        for (int i = 0; i < num_children; i++) {
            waitpid(pids[i], NULL, 0);
        }

        long long fork_end = get_time_us();
        printf("Total time (fork to last child exit): %.3f ms\n",
              (fork_end - fork_start)/1000.0);
    }

    return 0;
}