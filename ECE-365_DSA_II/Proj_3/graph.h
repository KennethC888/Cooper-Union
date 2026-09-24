#ifndef GRAPH_H
#define GRAPH_H
#include <string>
#include <vector>
#include "hash.h"
#include "heap.h"

class Graph 
{
public:
    Graph(int initialCapacity = 101);  // constructor
    ~Graph();                          // destructor

    bool loadGraph(const std::string &filename);
    double dijkstra(const std::string &startVertex,std::vector<int> &dist,std::vector<int> &prev);
    void outputResults(const std::string &filename, const std::vector<int> &dist, const std::vector<int> &prev);
    bool containsVertex(const std::string &name);

private:
    struct Edge 
    {
        int cost;
        std::string dest;
    };

    struct Vertex 
    {
        std::string id;
        std::vector<Edge> edges;
        int index;
    };
    
    std::vector<Vertex*> vertices; 
    hashTable vertexTable;         
    Vertex* getVertex(const std::string &name);
};

#endif
