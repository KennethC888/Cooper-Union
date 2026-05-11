from multiprocessing import Pool, cpu_count
import time
from tracemalloc import start

start = time.time()
def is_divisible_by_three(n):
    if n % 3 == 0:
        return True
    else: 
        return False

def count_number_of_divis_three(args):
    start, end = args
    count = 0
    for i in range (start, end):
        if is_divisible_by_three(i):
            count = count + 1
    return count 

def count_divis_three_in_parallel(N):
    num_workers = cpu_count()
    chunk_size = N // num_workers

    ranges = []
    for i in range(num_workers):
        start = i * chunk_size
        end = (i + 1) * chunk_size if i < num_workers - 1 else N + 1
        ranges.append((start, end))

    with Pool(num_workers) as pool:
        results = pool.map(count_number_of_divis_three, ranges)

    return sum(results)


if __name__ == "__main__":
    start = time.time()
    N = 200_000
    result = count_divis_three_in_parallel(N)
    print("Number of numbers divisible by 3:", result)
    end = time.time()
    print("Execution time:", end - start, "seconds")