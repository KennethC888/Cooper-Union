import time

def is_divisible_by_three(n):
    if n % 3 == 0:
        #print(n, " is divisible by 3!")
        return True
    else: 
        return False

def count_number_of_divis_three(a):
    count = 0
    for i in range (N+1):
        if is_divisible_by_three(i):
            count = count + 1
    return count 

if __name__ == "__main__":
    start = time.time()
    N = 200_000
    result = count_number_of_divis_three(N)
    print("Number of numbers that are divisible by 3:", result)
    end = time.time() 
    print("Execution time:", end - start, "seconds")
