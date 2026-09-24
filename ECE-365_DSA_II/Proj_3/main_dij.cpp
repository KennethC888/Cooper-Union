#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <limits>
#include <ctime>
#include <algorithm>
#include "heap.h"
#include "hash.h"
#include "graph.h"

using namespace std;

int main() {

    Graph graph; 
    string graphFile;
    cout << "Enter name of graph file: ";
    cin >> graphFile;

     if (!graph.loadGraph(graphFile)) 
     {
        return 1;
    }

    string start;
    cout << "Enter name of starting vertex: ";
    cin >> start;

    while (!graph.containsVertex(start)) {
        cout << "Vertex not found. Enter again: ";
        cin >> start;
    }

    vector<int> dist;
    vector<int> prev;

    double time_to_run_dijkstra = graph.dijkstra(start, dist, prev); 
    cout << "Total time (in seconds) to apply Dijkstra's algorithm: " << time_to_run_dijkstra << endl; 

    string outputFile;
    cout << "Enter name of output file: ";
    cin >> outputFile;

    graph.outputResults(outputFile, dist, prev);

    return 0;
}
