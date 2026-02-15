#include <iostream>
#include <string>
#include <stdio.h>
#include <cstring>
#include <fstream>
#include <vector>
#include <new>

using namespace std;

int main()
{
    string inputfile, outputfile;
    cout << "Enter name of input file: ";
    cin >> inputfile;
    cout << "\n";
    cout << "Enter name of output file: ";
    cin >> outputfile;

    ifstream input(inputfile);
    vector<Foobar*> foobarList;
    string line;
    int position_in_line = 0; 

    if (input.is_open())
    {

        while (getline(input, line)) // Read each line from the file
        {
            if (!line.empty())
            {
                string type_of_Foobar = line.substr(0, line.find(' '));
                string name = line.substr(line.find(' ') + 1);

                if (type_of_Foobar == "foobar")
                {
                    foobarList.push_back(new Foobar(name, 0));
                    position_in_line ++; 
                    
                }

                else if (type_of_Foobar == "foo")
                {
                    foobarList.push_back(new Foo(name, 0));
                    position_in_line ++; 
                }

                else if (type_of_Foobar == "bar")
                {
                    foobarList.push_back(new Bar(name, 0));
                    position_in_line ++; 
                }
                
            }
            
            // stringstream
        }
    }

    input.close();

    ifstream output(outputfile);

    int number_of_Foobars = foobarList.size(); 
    for (int i = 0; i < number_of_Foobars; ++i) 
    {
        foobarList[i]-> get_strength();
    }

    for (const auto& foobar : foobarList) {
        outputfile << foobar->get_Name() << " " << foobar->get_strength() << endl;
    }
    output.close();

    return 0;
}

class Foobar
{
    private:
        int position;
        string name;

    public:
        Foobar(string name, int position){
            this->position = position;
            this->name = name;
        }

        string get_Name(string name)
        {
            return name;
        }
        int get_position()
        {
            return position;
        }
        void setPosition(int pos)
        {
           position = pos;  
        }
        virtual int get_strength()
        {
            return position;
        }
};

class Foo : public Foobar
{
    public:
        Foo(string name, int position): Foobar(name, position){};
        int strength;
        inline virtual int get_strength()
        {
            strength = 3 * get_position();
            return strength;
        }
};

class Bar : public Foobar
{
    public:
    Bar(string name, int position): Foobar(name, position){};
    int strength;
    int set_strength()
    {
        strength = get_position() + 15;
        return strength;
    }
};