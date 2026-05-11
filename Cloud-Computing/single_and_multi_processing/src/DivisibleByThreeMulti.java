import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class DivisibleByThreeMulti {

    public static boolean isDivisibleByThree(int n) {
        return n % 3 == 0;
    }

    public static int countNumberOfDivisThree(int start, int end) {
        int count = 0;
        for (int i = start; i < end; i++) {
            if (isDivisibleByThree(i)) {
                count++;
            }
        }
        return count;
    }

    public static int countDivisThreeInParallel(int N)
            throws ExecutionException, InterruptedException {

        int numWorkers = Runtime.getRuntime().availableProcessors(); //Number of cores available
        int chunkSize = N / numWorkers; 

        ExecutorService executor = Executors.newFixedThreadPool(numWorkers); // Create a thread pool with a fixed number of threads
        List<Future<Integer>> results = new ArrayList<>(); // List to hold Future results from each worker

        // Each worker will process a chunk of numbers to count how many are divisible by 3
        for (int i = 0; i < numWorkers; i++) {
            int start = i * chunkSize;
            int end;

            if (i == numWorkers - 1) {
                end = N + 1;
            } else {
                end = (i + 1) * chunkSize;
            }

            // Submit the task to the executor and store the Future result
            Callable<Integer> task = () -> countNumberOfDivisThree(start, end);
            results.add(executor.submit(task));
        }

        int total = 0;
        for (Future<Integer> future : results) {
            total += future.get();
        }

        executor.shutdown();
        return total;
    }

    public static void main(String[] args)
            throws ExecutionException, InterruptedException {

        long startTime = System.currentTimeMillis();

        int N = 200_000;
        int result = countDivisThreeInParallel(N);
        System.out.println("Number of numbers divisible by 3: " + result);

        long endTime = System.currentTimeMillis();
        System.out.println("Execution time: " +
                (endTime - startTime) / 1000.0 + " seconds");
        System.out.println("DONE!");
    }
}
