#include "heap.h"
#include <stdexcept>

// heap constructor. mapping size chosen as capacity*2 (as suggested)
heap::heap(int cap) : capacity(cap), currentSize(0), mapping(cap*2) {
  // allocate data vector with capacity+1 (slot 0 unused)
  data.resize(capacity + 1);
  // currentSize already zero
}

// helper: return position index of node pointer pn (pointer arithmetic)
int heap::getPos(node *pn) {
  // address of data[0], pointer arithmetic returns difference
  ptrdiff_t pos = pn - &data[0];
  return static_cast<int>(pos);
}

void heap::percolateUp(int posCur) {
  if (posCur <= 1) return;
  node tmp = data[posCur];
  int cur = posCur;
  while (cur > 1) {
    int parent = cur / 2;
    if (data[parent].key <= tmp.key) break;
    // move parent down
    data[cur] = data[parent];
    // update mapping to point to new location
    mapping.setPointer(data[cur].id, &data[cur]);
    cur = parent;
  }
  data[cur] = tmp;
  mapping.setPointer(data[cur].id, &data[cur]);
}

void heap::percolateDown(int posCur) {
  int cur = posCur;
  node tmp = data[cur];
  while (true) {
    int left = cur * 2;
    if (left > currentSize) break;
    int right = left + 1;
    int child = left;
    if (right <= currentSize && data[right].key < data[left].key) child = right;
    if (data[child].key >= tmp.key) break;
    // move child up
    data[cur] = data[child];
    mapping.setPointer(data[cur].id, &data[cur]);
    cur = child;
  }
  data[cur] = tmp;
  mapping.setPointer(data[cur].id, &data[cur]);
}

int heap::insert(const std::string &id, int key, void *pv) {
  if (currentSize >= capacity) {
    return 1; // heap already filled
  }

  // check id does not already exist
  if (mapping.contains(id)) {
    return 2; // id already exists
  }

  // place new node at the end
  currentSize++;
  data[currentSize].id = id;
  data[currentSize].key = key;
  data[currentSize].pData = pv;

  // insert mapping to point to this node
  int res = mapping.insert(id, &data[currentSize]);
  // mapping.insert should succeed; but if it reports "already exists", undo and return 2
  if (res == 1) {
    // shouldn't normally happen because of contains check, but handle gracefully
    currentSize--;
    return 2;
  }
  // if rehash failed (res == 2), best to undo insertion and signal failure.
  if (res == 2) {
    currentSize--;
    return 1; 
  }

  // percolate up to restore heap property
  percolateUp(currentSize);
  return 0; // successful
}

int heap::setKey(const std::string &id, int key) {
  bool found = false;
  node *pn = static_cast<node *>(mapping.getPointer(id, &found));
  if (!found || pn == nullptr) return 1;

  int oldKey = pn->key;
  pn->key = key;

  int pos = getPos(pn);
  if (key < oldKey) {
    percolateUp(pos);
  } else if (key > oldKey) {
    percolateDown(pos);
  }
  return 0;
}

int heap::deleteMin(std::string *pId, int *pKey, void *ppData) {
  if (currentSize == 0) return 1; // empty

  // copy root data out
  if (pId != nullptr) *pId = data[1].id;
  if (pKey != nullptr) *pKey = data[1].key;
  if (ppData != nullptr) {
    // ppData is a void* to a void* variable; cast then assign
    *(static_cast<void **>(ppData)) = data[1].pData;
  }

  // remove mapping for root id
  mapping.remove(data[1].id);

  // move last node into root (if last node is root, just remove)
  if (currentSize > 1) {
    data[1] = data[currentSize];
    // update mapping to point to new root location
    mapping.setPointer(data[1].id, &data[1]);
  }
  currentSize--;

  // percolate down from root if necessary
  if (currentSize >= 1) percolateDown(1);

  return 0;
}

int heap::remove(const std::string &id, int *pKey, void *ppData) {
  bool found = false;
  node *pn = static_cast<node *>(mapping.getPointer(id, &found));
  if (!found || pn == nullptr) return 1;

  int pos = getPos(pn);

  if (pKey != nullptr) *pKey = data[pos].key;
  if (ppData != nullptr) *(static_cast<void **>(ppData)) = data[pos].pData;

  // remove mapping for this id
  mapping.remove(id);

  // If removing last element, just pop
  if (pos == currentSize) {
    currentSize--;
    return 0;
  }

  // Move last node to pos
  data[pos] = data[currentSize];
  currentSize--;

  // Update mapping to point to new location of moved node
  mapping.setPointer(data[pos].id, &data[pos]);

  // Restore heap property: try percolateUp (in case new key smaller), otherwise percolateDown
  // Need to compare new key at pos with parent's key and children keys
  if (pos > 1 && data[pos].key < data[pos / 2].key) {
    percolateUp(pos);
  } else {
    percolateDown(pos);
  }

  return 0;
}
