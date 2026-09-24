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


#include <algorithm> // For std::sort
#include <iostream>  // For std::cerr
#include <cstdlib>   // For std::exit

// Comparator function for sorting the data
inline bool compareData(const Data* a, const Data* b) {
    if (a->lastName != b->lastName)
        return a->lastName < b->lastName;
    if (a->firstName != b->firstName)
        return a->firstName < b->firstName;
    return a->ssn < b->ssn;
}

void sortDataList(std::list<Data*>& l) {
    constexpr size_t MAX_SIZE = 100000000; // Fixed size for the array
    static Data* dataArray[MAX_SIZE];     // Pre-allocated array

    size_t n = l.size();

    // Step 1: Move nodes into the array using a for loop
    size_t index = 0;
    for (auto it = l.begin(); it != l.end(); ++it) {
        dataArray[index] = *it;
        ++index;
    }

    // Step 2: Sort the array
    std::sort(dataArray, dataArray + n, compareData);

    // Step 3: Clear the list
    l.clear();

    // Step 4: Reassemble the list using a for loop
    for (size_t i = 0; i < n; ++i) {
        l.push_back(dataArray[i]);
    }
}
