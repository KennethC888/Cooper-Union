#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

using namespace std; 

int main()
{
    string inputFile;
    cout << "Enter name of input file: ";
    cin >> inputFile;

    ifstream fin(inputFile);
    if (!fin.is_open()) {
        cout << "Could not open input file.\n";
        return 1;
    }

    string outputFile; 
    cout << "Enter name of output file: ";
    cin >> outputFile;
    ofstream fout(outputFile);

    if (!fout.is_open()) {
        cout << "Could not open output file.\n";
        return 1;
    }

    string A, B, C;

    while (getline(fin, A) && getline(fin, B) && getline(fin, C)) {
        int a = A.length(); 
        int b = B.length();
        int c = C.length(); 

        if (c != a + b) {
            fout << "*** NOT A MERGE ***\n";
            continue; 
        }
        
        // DP table: dp[i][j] = true if A[i..] and B[j..] can form C[i+j..]
        vector<vector<bool>> dp(a + 1, vector<bool>(b + 1, false));
        dp[a][b] = true;  // Base case: empty suffixes
        
        // Fill DP table backwards
        for (int i = a; i >= 0; i--) {
            for (int j = b; j >= 0; j--) {
                if (i == a && j == b) continue;
                
                int k = i + j;
                
                // Is it from A?
                if (i < a && A[i] == C[k] && dp[i+1][j]) {
                    dp[i][j] = true;
                }
                // Is it from B?
                if (j < b && B[j] == C[k] && dp[i][j+1]) {
                    dp[i][j] = true;
                }
            }
        }

        if (!dp[0][0]) {
            fout << "*** NOT A MERGE ***\n";
            continue;
        }

        // Reconstruct with A's letters as early as possible
        string result = C;
        int i = 0, j = 0;
        
        for (int k = 0; k < c; k++) {
            bool canTakeA = (i < a && A[i] == C[k] && dp[i+1][j]);
            bool canTakeB = (j < b && B[j] == C[k] && dp[i][j+1]);
            
            // Prefer taking from A when both are valid
            if (canTakeA) {
                result[k] = toupper(C[k]);
                i++;
            } else if (canTakeB) {
                j++;
            }
        }

        fout << result << "\n";
    }

    fin.close();
    fout.close();
    return 0;
}

