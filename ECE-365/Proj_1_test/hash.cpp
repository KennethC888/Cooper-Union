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
    if (contains(key)) {
        return 1;
    }

    if (filled >= (capacity / 2)) {
        rehash();
        return 2;
    }

    int current_pos = hash(key);
    while (data[current_pos].isOccupied) {
        current_pos = (current_pos + 1) % capacity;
    }

    if (!data[current_pos].isOccupied) {
        data[current_pos].key = key;
        data[current_pos].isOccupied = true;
        data[current_pos].isDeleted = false;
        data[current_pos].pv = pv;
        filled++;
    }

    return 0; // Success
}

bool hashTable::contains(const std::string& key)
{
    // If findPos() returns -1, the key is not in the hash table.
    if (findPos(key) != -1) {
        return true;
    }

    else {
        return false;
    }
}

// Get the pointer associated with the specified key.
void* hashTable::getPointer(const std::string& key, bool* b)
{
    // TODO: Implement this function.
    // This is not required for the current assignment but will be for future
    // ones. Use findPos() to locate the item. If found, return its 'pv'
    // pointer. Update the optional bool 'b' if it's provided.

    return nullptr; // Placeholder
}

// Set the pointer associated with the specified key.
int hashTable::setPointer(const std::string& key, void* pv)
{
    // TODO: Implement this function.
    // This is not required for the current assignment.
    // Use findPos() to locate the item. If found, update its 'pv' pointer.

    return 1; // Placeholder
}

// Delete the item with the specified key.
bool hashTable::remove(const std::string& key)
{
    int pos = findPos(key);
    if (pos != -1) {
        data[pos].isDeleted = true;
        return true;
    }
    return false; // Key not found
}

// The hash function from Google Gemini
int hashTable::hash(const std::string& key)
{
    unsigned int hashVal = 0;
    for (char ch : key) {
        hashVal = 37 * hashVal + ch;
    }
    return hashVal % capacity;
}

int hashTable::findPos(const std::string& key)
{
    // Linear Probing
    int currentPos = hash(key);
    while (data[currentPos].isOccupied) {
        if (!data[currentPos].isDeleted && data[currentPos].key == key) {
            return currentPos;
        }
        currentPos = (currentPos + 1) % capacity;
    }
    return -1; // Placeholder
}

// The rehash function; makes the hash table bigger.
// Returns true on success, false if memory allocation fails.
// Function rehash made by Google Gemini
bool hashTable::rehash()
{
    std::vector<hashItem> oldData =
        data; // Copies data and puts it on a new vector called oldData
    int new_capacity;
    new_capacity = getPrime(2 * capacity);
    if (capacity >= new_capacity) {
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
    // selected random increasing primes from a website
    static const unsigned int primes[] = {98317,     786433,    1572869,
                                          50331653,  100663319, 201326611,
                                          402653189, 805306457, 1610612741};

    for (unsigned int p : primes) {
        if (p >= size) {
            return p;
        }
    }
    // Return a default or handle error if size is too large
    return primes[sizeof(primes) / sizeof(primes[0]) -
                  1]; // Last line by Google Gemini
}