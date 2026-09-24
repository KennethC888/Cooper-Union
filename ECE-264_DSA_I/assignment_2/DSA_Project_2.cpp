// Kenneth Chan
// This program reads an input file and based on the input, creates, pops, or pushes a stack or queue based on data type. 

#include <iostream>
#include <string>
#include <list>
#include <stdexcept>
#include <fstream>
#include <sstream>

using namespace std;

//Instantiating a template T
template <typename T>

//SimpleList class with nodes
class SimpleList {
protected:
    class Node 
    {
        public:
            T data;
            Node* next;
            Node(T value) : data(value), next(nullptr)
            {
            } 
    };

    // Pointers to the start and end of the list
    Node* head;
    Node* tail;

    // List name
    std::string name;

    // Protected member functions
    void insertStart(T value) 
    {
        Node* newNode = new Node(value);
        newNode->next = head;
        head = newNode;
        if (tail == nullptr) 
        {
            tail = head;
        }
    }

    void insertEnd(T value) 
    {
        Node* newNode = new Node(value);
        if (tail != nullptr) 
        {
            tail->next = newNode;
        }
        tail = newNode;
        if (head == nullptr) 
        {
            head = tail;
        }
    }

    T removeStart() 
    {
        if (head == nullptr) 
        {
            throw runtime_error("ERROR: This list is empty!");
        }
        Node* temp = head;
        T value = temp->data;
        head = head->next;
        if (head == nullptr) 
        {
            tail = nullptr;
        }
        delete temp;
        return value;
    }

public:
    // Constructor
    SimpleList(const std::string& listName) : head(nullptr), tail(nullptr), name(listName) 
    {
    }

    // Retrieve the name of the input list 
    std::string getName() const
    {
        return name;
    }

    //Virtual functions
    virtual void push(T value) = 0;
    virtual T pop() = 0;
};

// Stack class that "inherits" from SimpleList class
template <typename T>
class Stack : public SimpleList<T> 
{
public:
    Stack(const string& listName) : SimpleList<T>(listName) 
    {

    }

    void push(T value) override 
    {
        this->insertStart(value);
    }

    T pop() override 
    {
        return this->removeStart();
    }
};

// Queue class that also "inherits" from SimpleList class
template <typename T>
class Queue : public SimpleList<T> 
{
public:
    Queue(const string& listName) : SimpleList<T>(listName) 
    {
    }

    void push(T value) override 
    {
        this->insertEnd(value);
    }

    T pop() override 
    {
        return this->removeStart();
    }
};

// Function to find a SimpleList by name in a list
template <typename T>
SimpleList<T>* findList(const string& name, list<SimpleList<T>*>& list) 
{
    for (auto* sl : list) 
    {
        if (sl->getName() == name) 
        {
            return sl;
        }
    }
    return nullptr;
}

// get_List function that reads the input file
void get_List(const string& inputFileName, const string& outputFileName) {
    ifstream inputFile(inputFileName);
    ofstream outputFile(outputFileName);

    // Lists to store all SimpleList objects
    list<SimpleList<int>*> listSLi;
    list<SimpleList<double>*> listSLd;
    list<SimpleList<string>*> listSLs;

    string line;

    while (getline(inputFile, line)) 
    {
        outputFile << "PROCESSING COMMAND: " << line << "\n";

        istringstream commandStream(line);
        string command, name, arg;
        commandStream >> command >> name;

        // Determine the type of the list based on the first character
        char type = name[0];

        //Will add the input line to the stack or queue based on data type as well
        if (command == "create") 
        {
            commandStream >> arg;
            if (type == 'i') 
            {
                if (findList(name, listSLi)) 
                {
                    outputFile << "ERROR: This name already exists!\n";
                }
                else 
                {
                    if (arg == "stack") 
                    {
                        //Creates a new integer stack
                        listSLi.push_front(new Stack<int>(name));
                    } 
                    else if (arg == "queue") 
                    {
                        //Creates a new integer queue
                        listSLi.push_front(new Queue<int>(name));
                    }
                }
            }
             
             else if (type == 'd') 
             {
                if (findList(name, listSLd)) 
                {
                    outputFile << "ERROR: This name already exists!\n";
                } 
                else 
                {
                    if (arg == "stack") 
                    {
                        //Creates a new double stack
                        listSLd.push_front(new Stack<double>(name));
                    } 
                    else if (arg == "queue") 
                    {
                        //Creates a new double queue
                        listSLd.push_front(new Queue<double>(name));
                    }
                }
             } 
                else if (type == 's') 
                {
                    if (findList(name, listSLs)) 
                    {
                        outputFile << "ERROR: This name already exists!\n";
                    } 
                    else 
                    {
                        if (arg == "stack") 
                        {
                            //Creates a new string stack
                            listSLs.push_front(new Stack<string>(name));
                        } 
                        else if (arg == "queue") 
                        {
                            //Creates a new string queue
                            listSLs.push_front(new Queue<string>(name));
                        }
                    }
                }
        } 
            
            else if (command == "push") 
            {
                commandStream >> arg;
                if (type == 'i')
                {
                    auto* list = findList(name, listSLi);
                    if (!list) 
                    {
                        outputFile << "ERROR: This name does not exist!\n";
                    } 
                    else 
                    {
                        //Pushes integer to the list 
                        list->push(stoi(arg));
                    }
                } 
                else if (type == 'd') 
                {
                    auto* list = findList(name, listSLd);
                    if (!list) 
                    {
                        outputFile << "ERROR: This name does not exist!\n";
                    } 
                    else 
                    {
                        //Pushes double to the list
                        list->push(stod(arg));
                    }
                } 
                else if (type == 's') 
                {
                    auto* list = findList(name, listSLs);
                    if (!list) 
                    {
                        outputFile << "ERROR: This name does not exist!\n";
                    } else 
                    {
                        //Pushes string to the list
                        list->push(arg);
                    }
                }
        } 
        else if (command == "pop") 
        {
            if (type == 'i') 
            {
                auto* list = findList(name, listSLi);
                if (!list) 
                {
                    outputFile << "ERROR: This name does not exist!\n";
                } 
                else 
                {
                    //This part was aided by CHATGPT
                    try 
                    {
                        outputFile << "Value popped: " << list->pop() << "\n";
                    } 
                    catch (const runtime_error& e) 
                    {
                        outputFile << e.what() << "\n";
                    }
                }
            } 
            else if (type == 'd') 
            {
                auto* list = findList(name, listSLd);
                if (!list) 
                {
                    outputFile << "ERROR: This name does not exist!\n";
                } 
                else 
                {
                    try 
                    {
                        outputFile << "Value popped: " << list->pop() << "\n";
                    } 
                    catch (const runtime_error& e) 
                    {
                        outputFile << e.what() << "\n";
                    }
                }
            } 
            else if (type == 's') 
            {
                auto* list = findList(name, listSLs);
                if (!list) 
                {
                    outputFile << "ERROR: This name does not exist!\n";
                } 
                else 
                {
                    try 
                    {
                        outputFile << "Value popped: " << list->pop() << "\n";
                    } 
                    catch (const runtime_error& e) 
                    {
                        outputFile << e.what() << "\n";
                    }
                }
            }
        }
    }
}

int main() 
{
    string inputFileName, outputFileName;
    cout << "Enter input file name: ";
    cin >> inputFileName;
    cout << "Enter output file name: ";
    cin >> outputFileName;

    get_List(inputFileName, outputFileName);

    return 0;
}
