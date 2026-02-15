// Using provided code from DSA I for this project
// d.txt is the dictionary, i.txt is the input text file
// To run the file:
// make
// ./spell.exe
#include "hash.h"
#include <algorithm>
#include <cctype>
#include <cmath>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <fstream>
#include <iostream>
#include <list>
#include <sstream>
#include <string>
#include <vector>

using namespace std;

// Loads the dictionary file into the hash table
void loadDictionary(hashTable& dictTable, const string& filename)
{
    ifstream dictFile(filename);
    if (!dictFile) {
        cerr << "Error: could not open dictionary file '" << filename << "'"
             << endl;
        exit(1);
    }

    string line;
    while (getline(dictFile, line)) {
        // Per instructions, dictionary words are one per line.
        // Convert to lowercase and insert. We assume dictionary words are
        // valid.
        for (char& c : line) {
            c = tolower(c);
        }
        if (!line.empty() && line.length() <= 20) {
            dictTable.insert(line);
        }
    }
    dictFile.close();
}

void SpellCheck(hashTable& dictTable, const string& inputFilename,
                const string& outputFilename)
{

    ifstream inputFile(inputFilename);
    if (!inputFile) {
        cerr << "Error: could not open input file '" << inputFilename << "'"
             << endl;
        exit(1);
    }

    ofstream outFile(outputFilename);
    if (!outFile) {
        cerr << "Error: could not open output file '" << outputFilename << "'"
             << endl;
        outFile.close();
        exit(1);
    }

    string currentWord = "";
    bool is_digit = false;
    bool is_dash_or_apostrophe = false;
    bool is_letter = false;
    bool is_valid = false;
    int lineNum = 1;
    char c;

    while (inputFile.get(c)) {
        if (isalpha(c)) // Looked up on internet to use isalpha()
        {
            c = tolower(c);
            currentWord += c;
            is_letter = true;
            // printf(currentWord.c_str());
        } else if (c == '0' || c == '1' || c == '2' || c == '3' || c == '4' ||
                   c == '5' || c == '6' || c == '7' || c == '8' || c == '9') {
            // currentWord += c;
            is_digit = true;
            currentWord = "";
            // This inner loop will read characters until it finds a space or
            // newline
            while (inputFile.get(c) && c != ' ' && c != '\n') {
                if (!isalpha(c) && !isdigit(c) && c != '-' && c != '\'') {
                    // Found a word separator like #, break out of the loop
                    break;
                }
            }
            if (c == '\n') {
                lineNum++;
            }
        } else if (c == '-' || c == '\'') // '\'' is apostrophe
        {
            currentWord += c;
            is_dash_or_apostrophe = true;
        } else {
            is_digit = false;
            is_dash_or_apostrophe = false;
            is_letter = false;

            if (c == ' ' ||
                (is_digit == false && is_dash_or_apostrophe == false &&
                 is_letter == false)) {

                if (currentWord.length() > 20) {
                    outFile << "Long word at line " << lineNum
                            << ", starts: " << currentWord.substr(0, 20)
                            << endl;
                    currentWord = "";
                }

                else if (currentWord.empty()) {
                    currentWord = "";
                }

                else if (!dictTable.contains(currentWord)) {
                    outFile << "Unknown word at line " << lineNum << ": "
                            << currentWord << endl;
                    currentWord = "";
                }
                currentWord = "";
            }

            else if (is_letter == false && is_digit == false &&
                     is_dash_or_apostrophe == false && c != ' ') {
                if (currentWord.empty()) {

                } else if (!currentWord.empty() &&
                           !dictTable.contains(currentWord)) {
                    outFile << "Unknown word at line " << lineNum << ": "
                            << currentWord << endl;
                }

                currentWord = "";
            }

            if (c == '\n') {
                lineNum++;
            }
        }
    } // End of loop
    // Check the last word of the file
    if (!currentWord.empty()) {
        if (currentWord.length() > 20) {
            outFile << "Long word at line " << lineNum
                    << ", starts: " << currentWord.substr(0, 20) << endl;
        } else if (is_letter == false && is_digit == false &&
                   is_dash_or_apostrophe == false && c != ' ' &&
                   !dictTable.contains(currentWord)) {
            outFile << "Unknown word at line " << lineNum << ":" << currentWord
                    << endl;
        }
    }

} // End of function

int main()
{
    // Initialize hash table with a reasonable starting size
    hashTable dict(50000);

    string dictFilename, inputFilename, outputFilename;

    cout << "Enter name of dictionary: ";
    cin >> dictFilename;

    clock_t start = clock();
    loadDictionary(dict, dictFilename);
    clock_t end = clock();
    cout << "Total time (in seconds) to load dictionary: "
         << ((double)(end - start)) / CLOCKS_PER_SEC << endl;

    cout << "Enter name of input file: ";
    cin >> inputFilename;
    cout << "Enter name of output file: ";
    cin >> outputFilename;

    start = clock();
    SpellCheck(dict, inputFilename, outputFilename);
    end = clock();
    cout << "Total time (in seconds) to check document: "
         << ((double)(end - start)) / CLOCKS_PER_SEC << endl;

    return 0;
}