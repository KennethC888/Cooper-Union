// THIS IS THE PROVIDED CODE FOR PROGRAM #3, DSA 1, FALL 2024

#include <iostream>
#include <fstream>
#include <sstream>
#include <list>
#include <vector>
#include <string>
#include <algorithm>
#include <ctime>
#include <cmath>
#include <cstring>
#include <cctype>
#include <cstdlib>

using namespace std;

// A simple class; each object holds three public fields
class Data {
public:
  string lastName;
  string firstName;
  string ssn;
};

// Load the data from a specified input file
void loadDataList(list<Data *> &l, const string &filename) {

  ifstream input(filename);
  if (!input) {
    cerr << "Error: could not open " << filename << "\n";
    exit(1);
  }

  // The first line indicates the size
  string line;
  getline(input, line);
  stringstream ss(line);
  int size;
  ss >> size;

  // Load the data
  for (int i = 0; i < size; i++) {
    getline(input, line);
    stringstream ss2(line);
    Data *pData = new Data();
    ss2 >> pData->lastName >> pData->firstName >> pData->ssn;
    l.push_back(pData);
  }

  input.close();
}

// Output the data to a specified output file
void writeDataList(const list<Data *> &l, const string &filename) {

  ofstream output(filename);
  if (!output) {
    cerr << "Error: could not open " << filename << "\n";
    exit(1);
  }

  // Write the size first
  int size = l.size();
  output << size << "\n";

  // Write the data
  for (auto pData:l) {
    output << pData->lastName << " " 
	   << pData->firstName << " " 
	   << pData->ssn << "\n";
  }

  output.close();
}

// Sort the data according to a specified field
// (Implementation of this function will be later in this file)
void sortDataList(list<Data *> &);

// The main function calls routines to get the data, sort the data,
// and output the data. The sort is timed according to CPU time.
int main() {
  string filename;
  cout << "Enter name of input file: ";
  cin >> filename;
  list<Data *> theList;
  loadDataList(theList, filename);

  cout << "Data loaded.\n";

  cout << "Executing sort...\n";
  clock_t t1 = clock();
  sortDataList(theList);
  clock_t t2 = clock();
  double timeDiff = ((double) (t2 - t1)) / CLOCKS_PER_SEC;

  cout << "Sort finished. CPU time was " << timeDiff << " seconds.\n";

  cout << "Enter name of output file: ";
  cin >> filename;
  writeDataList(theList, filename);

  return 0;
}

// -------------------------------------------------
// YOU MAY NOT CHANGE OR ADD ANY CODE ABOVE HERE !!!
// -------------------------------------------------

// You may add global variables, functions, and/or
// class defintions here if you wish.
// MOST CODE WRITTEN BY CHATGPT

// Fixed array size better than vectors. Pre-allocation. Array of pointers, for loop. 


#include <cstdlib> // For malloc and free
#include <algorithm>

// Comparator function for sorting the data
inline bool compareData(const Data* a, const Data* b) {
    if (a->lastName != b->lastName)
        return a->lastName < b->lastName;
    if (a->firstName != b->firstName)
        return a->firstName < b->firstName;
    return a->ssn < b->ssn;
}

void sortDataList(std::list<Data*>& l) {
    size_t n = l.size();
    if (n <= 1) {
        // No need to sort if the list has 0 or 1 element
        return;
    }

    // Step 1: Allocate a fixed-size array
    Data** dataArray = static_cast<Data**>(std::malloc(n * sizeof(Data*)));
    if (!dataArray) {
        std::cerr << "Memory allocation failed for array of size " << n << "\n";
        exit(EXIT_FAILURE);
    }

    // Step 2: Move all nodes into the array
    size_t index = 0;
    for (Data* node : l) {
        dataArray[index++] = node;
    }

    // Step 3: Sort the array
    std::sort(dataArray, dataArray + n, compareData);

    // Step 4: Clear the original list and reassemble it
    l.clear(); // Clear the original list
    for (size_t i = 0; i < n; ++i) {
        l.push_back(dataArray[i]); // Add sorted nodes back to the list
    }

    // Step 5: Free the allocated memory
    std::free(dataArray);
}
