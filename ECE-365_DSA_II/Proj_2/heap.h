#ifndef _HEAP_H
#define _HEAP_H

#include <string>
#include <vector>
#include "hash.h"

class heap {
public:
  // constructor
  heap(int capacity);

  // insert
  int insert(const std::string &id, int key, void *pv = nullptr);

  // setKey: returns 0 on success, 1 if id not found
  int setKey(const std::string &id, int key);

  // deleteMin: returns 0 on success, 1 if empty
  int deleteMin(std::string *pId = nullptr, int *pKey = nullptr, void *ppData = nullptr);

  // remove: delete node with given id. returns 0 on success, 1 if id not found
  int remove(const std::string &id, int *pKey = nullptr, void *ppData = nullptr);

private:
  class node {
  public:
    std::string id;
    int key;
    void *pData;
    node() : id(""), key(0), pData(nullptr) {}
  };

  int capacity; // maximum allowed
  int currentSize; // number of elements currently in heap
  std::vector<node> data; // 1-indexed: data[0] unused
  hashTable mapping; // maps id -> &data[pos]

  // helpers
  void percolateUp(int posCur);
  void percolateDown(int posCur);
  int getPos(node *pn);
};

#endif // _HEAP_H
