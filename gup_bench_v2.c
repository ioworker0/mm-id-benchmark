#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <pthread.h>
#include <fcntl.h>
#include <math.h>
#include <string.h>
#include <errno.h>
#include <stdint.h>
#include <time.h>

#define MB (1UL << 20)

// Copy from kernel: mm/gup_test.h
#define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_test)
#define PIN_FAST_BENCHMARK	_IOWR('g', 2, struct gup_test)

struct gup_test {
	uint64_t get_delta_usec;
	uint64_t put_delta_usec;
	uint64_t addr;
	uint64_t size;
	uint32_t nr_pages_per_call;
	uint32_t gup_flags;
	uint32_t test_flags;
	uint32_t which_pages[8];
};

struct thread_stats {
	double *get_times;  // nanoseconds
	double *put_times;
	int count;
	int thread_id;
};

struct global_config {
	int gup_fd;
	int threads;
	int iterations;
	unsigned long size_mb;
	int pages_per_call;
	int use_pin;      // Use PIN instead of GUP
	int quiet;        // Quiet mode: one-line output
	unsigned long cmd;  // IOCTL command to use
	pthread_mutex_t print_lock;
} cfg;

static void calc_stats(double *data, int n,
                       double *min, double *max, double *avg, double *stddev)
{
	*min = data[0];
	*max = data[0];
	double sum = 0;

	for (int i = 0; i < n; i++) {
		if (data[i] < *min) *min = data[i];
		if (data[i] > *max) *max = data[i];
		sum += data[i];
	}

	*avg = sum / n;

	double variance = 0;
	for (int i = 0; i < n; i++) {
		double diff = data[i] - *avg;
		variance += diff * diff;
	}
	*stddev = sqrt(variance / n);
}

void *bench_thread(void *arg)
{
	struct thread_stats *stats = arg;
	struct gup_test gup = {0};
	void *addr;
	unsigned long size = cfg.size_mb * MB;

	addr = mmap(NULL, size, PROT_READ | PROT_WRITE,
	            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (addr == MAP_FAILED) {
		if (!cfg.quiet) {
			pthread_mutex_lock(&cfg.print_lock);
			fprintf(stderr, "Thread %d: mmap failed: %s\n",
			        stats->thread_id, strerror(errno));
			pthread_mutex_unlock(&cfg.print_lock);
		}
		return NULL;
	}

	// Touch all pages to ensure they're mapped
	for (unsigned long i = 0; i < size; i += 4096) {
		((char*)addr)[i] = 1;
	}

	// Run iterations
	for (int i = 0; i < cfg.iterations; i++) {
		gup.addr = (unsigned long)addr;
		gup.size = cfg.pages_per_call * 4096;
		gup.nr_pages_per_call = cfg.pages_per_call;
		gup.gup_flags = 0;

		int ret = ioctl(cfg.gup_fd, cfg.cmd, &gup);
		if (ret < 0) {
			if (!cfg.quiet) {
				pthread_mutex_lock(&cfg.print_lock);
				fprintf(stderr, "Thread %d iter %d: ioctl failed: %s\n",
				        stats->thread_id, i, strerror(errno));
				pthread_mutex_unlock(&cfg.print_lock);
			}
			break;
		}

		// Store times in nanoseconds
		stats->get_times[i] = gup.get_delta_usec * 1000.0;  // us to ns
		stats->put_times[i] = gup.put_delta_usec * 1000.0;
	}

	munmap(addr, size);
	return NULL;
}

int main(int argc, char **argv)
{
	pthread_t *threads;
	struct thread_stats *all_stats;
	int opt;

	// Default values
	cfg.threads = 4;
	cfg.iterations = 100;
	cfg.size_mb = 128;
	cfg.pages_per_call = 8;
	cfg.use_pin = 0;
	cfg.quiet = 0;
	cfg.cmd = GUP_FAST_BENCHMARK;

	// Parse arguments
	while ((opt = getopt(argc, argv, "j:r:m:p:Pqh")) != -1) {
		switch (opt) {
		case 'j':
			cfg.threads = atoi(optarg);
			break;
		case 'r':
			cfg.iterations = atoi(optarg);
			break;
		case 'm':
			cfg.size_mb = atoi(optarg);
			break;
		case 'p':
			cfg.pages_per_call = atoi(optarg);
			break;
		case 'P':
			cfg.use_pin = 1;
			cfg.cmd = PIN_FAST_BENCHMARK;
			break;
		case 'q':
			cfg.quiet = 1;
			break;
		case 'h':
			printf("Usage: %s [-j threads] [-r iterations] [-m size_mb] [-p pages] [-P] [-q]\n", argv[0]);
			printf("  -j: Number of threads (default: 4)\n");
			printf("  -r: Iterations per thread (default: 100)\n");
			printf("  -m: Memory size per thread in MB (default: 128)\n");
			printf("  -p: Pages to pin per call (default: 8)\n");
			printf("  -P: Use PIN_FAST instead of GUP_FAST\n");
			printf("  -q: Quiet mode - one line output: GET_avg PUT_avg\n");
			return 0;
		default:
			fprintf(stderr, "Use -h for help\n");
			return 1;
		}
	}

	if (geteuid() != 0) {
		fprintf(stderr, "Error: Must run as root\n");
		return 1;
	}

	cfg.gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
	if (cfg.gup_fd < 0) {
		fprintf(stderr, "Failed to open /sys/kernel/debug/gup_test: %s\n",
		        strerror(errno));
		fprintf(stderr, "Make sure CONFIG_GUP_TEST=y and debugfs is mounted\n");
		return 1;
	}

	pthread_mutex_init(&cfg.print_lock, NULL);

	if (!cfg.quiet) {
		printf("=== %s Benchmark ===\n", cfg.use_pin ? "PIN-fast" : "GUP-fast");
		printf("Threads:    %d\n", cfg.threads);
		printf("Iterations: %d per thread\n", cfg.iterations);
		printf("Memory:     %lu MB per thread (allocated)\n", cfg.size_mb);
		printf("Pages:      %d pages per operation (%.1f KB)\n",
		       cfg.pages_per_call, cfg.pages_per_call * 4.0);
		printf("Total:      %d operations\n\n", cfg.threads * cfg.iterations);
		printf("Running benchmark...\n");
		fflush(stdout);
	}

	// Allocate resources
	threads = calloc(cfg.threads, sizeof(pthread_t));
	all_stats = calloc(cfg.threads, sizeof(struct thread_stats));

	for (int i = 0; i < cfg.threads; i++) {
		all_stats[i].get_times = calloc(cfg.iterations, sizeof(double));
		all_stats[i].put_times = calloc(cfg.iterations, sizeof(double));
		all_stats[i].count = cfg.iterations;
		all_stats[i].thread_id = i;
	}

	// Run benchmark
	for (int i = 0; i < cfg.threads; i++) {
		pthread_create(&threads[i], NULL, bench_thread, &all_stats[i]);
	}

	for (int i = 0; i < cfg.threads; i++) {
		pthread_join(threads[i], NULL);
	}

	// Aggregate all data
	int total_samples = cfg.threads * cfg.iterations;
	double *all_get_times = malloc(total_samples * sizeof(double));
	double *all_put_times = malloc(total_samples * sizeof(double));

	int idx = 0;
	for (int t = 0; t < cfg.threads; t++) {
		for (int i = 0; i < cfg.iterations; i++) {
			all_get_times[idx] = all_stats[t].get_times[i];
			all_put_times[idx] = all_stats[t].put_times[i];
			idx++;
		}
	}

	// Calculate statistics (all in nanoseconds)
	double get_min, get_max, get_avg, get_stddev;
	double put_min, put_max, put_avg, put_stddev;

	calc_stats(all_get_times, total_samples, &get_min, &get_max, &get_avg, &get_stddev);
	calc_stats(all_put_times, total_samples, &put_min, &put_max, &put_avg, &put_stddev);

	// Output results
	if (cfg.quiet) {
		// Quiet mode: one line output in microseconds
		printf("%.2f %.2f\n", get_avg / 1000.0, put_avg / 1000.0);
	} else {
		// Verbose mode: detailed output
		double get_se = get_stddev / sqrt(total_samples);
		double get_ci95 = 1.96 * get_se;
		double put_se = put_stddev / sqrt(total_samples);
		double put_ci95 = 1.96 * put_se;

		auto void print_time(const char *label, double ns_val) {
			if (ns_val < 1000) {
				printf("  %s %.1f ns\n", label, ns_val);
			} else if (ns_val < 1000000) {
				printf("  %s %.2f us\n", label, ns_val / 1000.0);
			} else {
				printf("  %s %.2f ms\n", label, ns_val / 1000000.0);
			}
		}

		auto void print_time_with_error(const char *label, double avg_ns, double err_ns, const char *err_type) {
			if (avg_ns < 1000) {
				printf("  %s %.1f ± %.3f ns (%s)\n", label, avg_ns, err_ns, err_type);
			} else if (avg_ns < 1000000) {
				printf("  %s %.2f ± %.3f us (%s)\n", label, avg_ns/1000.0, err_ns/1000.0, err_type);
			} else {
				printf("  %s %.2f ± %.3f ms (%s)\n", label, avg_ns/1000000.0, err_ns/1000000.0, err_type);
			}
		}

		printf("\nDone!\n\n");
		printf("=== Results (n=%d) ===\n\n", total_samples);

		printf("GET (pin pages):\n");
		print_time("Min:   ", get_min);
		print_time("Max:   ", get_max);
		print_time_with_error("Avg:   ", get_avg, get_stddev, "SD");
		print_time_with_error("       ", get_avg, get_se, "SE");
		print_time_with_error("       ", get_avg, get_ci95, "95% CI");
		printf("  CV:     %.2f%%\n\n", (get_stddev / get_avg) * 100);

		printf("PUT (unpin pages):\n");
		print_time("Min:   ", put_min);
		print_time("Max:   ", put_max);
		print_time_with_error("Avg:   ", put_avg, put_stddev, "SD");
		print_time_with_error("       ", put_avg, put_se, "SE");
		print_time_with_error("       ", put_avg, put_ci95, "95% CI");
		printf("  CV:     %.2f%%\n\n", (put_stddev / put_avg) * 100);

		printf("TOTAL (get + put):\n");
		double total_avg_ns = get_avg + put_avg;
		print_time("Avg:   ", total_avg_ns);
		printf("  Throughput: %.2f operations/sec\n",
		       1e9 / total_avg_ns);
	}

	// Cleanup
	for (int i = 0; i < cfg.threads; i++) {
		free(all_stats[i].get_times);
		free(all_stats[i].put_times);
	}
	free(all_stats);
	free(threads);
	free(all_get_times);
	free(all_put_times);
	close(cfg.gup_fd);

	return 0;
}
