#include "hash.h"
#include <exception> // Required for std::bad_alloc
#include <iostream>  // Useful for debugging
#include <vector>    // Used for the prime number list

// The constructor initializes the hash table.
// Uses getPrime to choose a prime number at least as large as
// the specified size for the initial size of the hash table.

hashTable::hashTable(int size)
{
    capacity = getPrime(size);
    data.resize(capacity);
    filled = 0;
}

int hashTable::insert(const std::string& key, void* pv)
{
    // If key already exists, report 1
    if (contains(key)) {
        return 1;
    }

    // If load factor >= 0.5 try to rehash first; if rehash fails, return 2
    if (filled >= (capacity / 2)) {
        if (!rehash()) {
            return 2; // rehash failed (memory)
        }
    }

    int current_pos = hash(key);
    // find an available slot (either never occupied or deleted)
    while (data[current_pos].isOccupied && !data[current_pos].isDeleted) {
        current_pos = (current_pos + 1) % capacity;
    }

    // fill the slot
    data[current_pos].key = key;
    data[current_pos].isOccupied = true;
    data[current_pos].isDeleted = false;
    data[current_pos].pv = pv;
    filled++;

    return 0; // Success
}

bool hashTable::contains(const std::string& key)
{
    if (findPos(key) != -1) return true;
    return false;
}

// Get the pointer associated with the specified key.
void* hashTable::getPointer(const std::string& key, bool* b)
{
    int pos = findPos(key);
    if (pos == -1) {
        if (b) *b = false;
        return nullptr;
    } else {
        if (b) *b = true;
        return data[pos].pv;
    }
}

// Set the pointer associated with the specified key.
int hashTable::setPointer(const std::string& key, void* pv)
{
    int pos = findPos(key);
    if (pos == -1) {
        return 1; // key not found
    }
    data[pos].pv = pv;
    return 0;
}

// Delete the item with the specified key.
bool hashTable::remove(const std::string& key)
{
    int pos = findPos(key);
    if (pos != -1) {
        data[pos].isDeleted = true;
        // do not decrement filled: we consider this lazily deleted
        return true;
    }
    return false; // Key not found
}

// The hash function from Google Gemini
int hashTable::hash(const std::string& key)
{
    unsigned int hashVal = 0;
    for (char ch : key) {
        hashVal = 37 * hashVal + static_cast<unsigned char>(ch);
    }
    return static_cast<int>(hashVal % capacity);
}

int hashTable::findPos(const std::string& key)
{
    // Linear Probing
    int currentPos = hash(key);
    int start = currentPos;
    while (data[currentPos].isOccupied) {
        if (!data[currentPos].isDeleted && data[currentPos].key == key) {
            return currentPos;
        }
        currentPos = (currentPos + 1) % capacity;
        if (currentPos == start) break; // full loop, not found
    }
    return -1;
}

// The rehash function; makes the hash table bigger.
// Returns true on success, false if memory allocation fails.
// Function rehash made by Google Gemini
bool hashTable::rehash()
{
    std::vector<hashItem> oldData = data; // copy
    int new_capacity = getPrime(2 * capacity);
    if (new_capacity <= capacity) {
        return false;
    }

    data.clear();
    capacity = new_capacity;
    data.resize(capacity);
    filled = 0;

    for (const auto& item : oldData) {
        if (item.isOccupied && !item.isDeleted) {
            insert(item.key, item.pv);
        }
    }

    return true;
}

// Return a prime number at least as large as size.
// Uses a precomputed sequence of selected prime numbers.
unsigned int hashTable::getPrime(int size)
{
    static const unsigned int primes[] = {98317,     786433,    1572869,
                                          50331653,  100663319, 201326611,
                                          402653189, 805306457, 1610612741};

    for (unsigned int p : primes) {
        if (p >= static_cast<unsigned int>(size)) {
            return p;
        }
    }
    return primes[sizeof(primes) / sizeof(primes[0]) - 1];
}
