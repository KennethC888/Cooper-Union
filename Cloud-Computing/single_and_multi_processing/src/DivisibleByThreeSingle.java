public class DivisibleByThreeSingle {

    public static boolean isDivisibleByThreeSingle(int n) {
        return n % 3 == 0;
    }

    public static int countNumberOfDivisThree(int N) {
        int count = 0;
        for (int i = 0; i <= N; i++) {
            if (isDivisibleByThreeSingle(i)) {
                count++;
            }
        }
        return count;
    }

    public static void main(String[] args) {
        long start = System.currentTimeMillis();

        int N = 200_000;
        int result = countNumberOfDivisThree(N);
        System.out.println("Number of numbers that are divisible by 3: " + result);

        long end = System.currentTimeMillis();
        System.out.println("Execution time: " + (end - start) / 1000.0 + " seconds");
        System.out.println("DONE!"); 
    }
}

// Implement producer-consumer model, choice of language. DINING PHILOSOPHER. 
// consumer is a worker,  
