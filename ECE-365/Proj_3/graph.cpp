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
const int INF = 1000000000; 

Graph:: Graph(int initialCapacity): vertexTable(initialCapacity) { }

Graph::~Graph() 
{
    for (Vertex *v : vertices)
        delete v;
}

// Searches for whether vertex exists or not, if it doesn't then it will create a new vertex, store in vector vertices and insert
// into hash table
Graph:: Vertex* Graph:: getVertex(const string &name) 
{
    bool found;
    void* ptr = vertexTable.getPointer(name, &found);

    if (found == true)
    {
        return (Vertex*)ptr; 
    }
    else 
    {
        Vertex *v = new Vertex; 
        v -> id = name; 
        v -> index = vertices.size();
        vertices.push_back(v);
        vertexTable.insert(name, v); 
        return v;
    }
}


// Reads the graph file where each line has:  src dst cost
// For each line of input get or create both vertices
// Add an edge to src's adjacency list
bool Graph:: loadGraph(const string &filename) {

    ifstream file(filename);
    
        if (!file.is_open())
        {
            cout << "Could not open file. ";
            return false;
        }

        string src;
        string dst;
        int cost;

        while (file >> src >> dst >> cost)
        {
            Vertex* v1 = getVertex(src);
            Vertex* v2 = getVertex(dst);

            Edge e; 
            e.dest = dst;
            e.cost = cost;
            v1->edges.push_back(e);
        }

        file.close(); 
        return true; 
}

bool Graph::containsVertex(const std::string &name) {
    return vertexTable.contains(name);
}


double Graph:: dijkstra(const string &startName,  vector<int> &dist, vector<int> &prev) {
    
    int n = vertices.size();
    dist.assign(n, INF);
    prev.assign(n, -1);
    
    heap Dijheap(n);
    for (int i = 0; i < n; i++)
    {
        Dijheap.insert(vertices[i]->id, INF, vertices[i]);
    } 

    bool found;
    void* ptr = vertexTable.getPointer(startName, &found);
    if (!found) {
        cout << "Starting vertex not found.\n";
        return 0;
    }

    Vertex* start = (Vertex*)ptr;
    dist[start->index] = 0; // starting vertex distance is 0
    Dijheap.setKey(start->id, 0);

    clock_t startTime = clock();

    string vertex_id;
    int key;
    void* pv;

    // while heap is not empty:
    //   deleteMin() to get vertex with smallest distance and look at each neighbor if a shorter path is found
    while (Dijheap.deleteMin(&vertex_id, &key, &pv) == 0) 
    {
        Vertex* u = (Vertex*)pv;
        for (const Edge& edge : u->edges) 
        {
            bool found;
            void* destPtr = vertexTable.getPointer(edge.dest, &found);
            if (!found) continue; 

            Vertex* v = (Vertex*)destPtr;
            int alt = dist[u->index] + edge.cost;
            if (alt < dist[v->index]) 
            {
                dist[v->index] = alt;
                prev[v->index] = u->index;
                Dijheap.setKey(v->id, alt);
            }
        }
    }

    // stop timing
    clock_t endTime = clock();

    // return elapsed time in seconds
    return (double)(endTime - startTime) / CLOCKS_PER_SEC;
}

// outputResults(filename)
// - Writes distances and paths to an output file
// - Format: vertex: distance [path list]
void Graph:: outputResults(const string &filename, const vector<int> &dist, const vector<int> &prev) {
    ofstream out(filename);
    if (!out.is_open()) {
        cout << "Could not open output file.\n";
        return;
    }
    int n = vertices.size();
    for (int i = 0; i < n; i++) {
        out << vertices[i]->id << ": ";
        if (dist[i] == INF) {
            out << "NO PATH\n";
        } else {
            out << dist[i] << " [";
            // reconstruct path
            vector<string> path;
            for (int at = i; at != -1; at = prev[at]) {
                path.push_back(vertices[at]->id);
            }
            reverse(path.begin(), path.end());
            for (size_t j = 0; j < path.size(); j++) {
                out << path[j];
                if (j < path.size() - 1) out << ", ";
            }
            out << "]\n";
        }
    }

    out.close(); 
}


