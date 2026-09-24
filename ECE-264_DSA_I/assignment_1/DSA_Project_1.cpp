// Kenneth Chan 
// This program processes a list of different types of Foobars and lists their names and strengths based on their position in a line

#include <iostream>
#include <string>
#include <stdio.h>
#include <cstring>
#include <fstream>
#include <vector>

using namespace std;

//Instantiation of the Foobar Class
class Foobar 
{
    private:

        string name;
        int position;

    public: //Public methods of Foobar listed here

        //Constructor of Foobar, it takes the name of the foobar and stores it in name and sets the position to 0. 
        Foobar(const string& name) 
        {
            this -> name = name; 
            position = 0; 
        } 

        // Sets position of Foobar when they are lined up
        void setPosition(int pos) 
        {
            position = pos;
        }

        //virtual because both Foos and Bars use this method, polymorphism
        virtual int getStrength() const 
        {
            return position; 
        }

        //Returns name of Foobar
        string getName() const 
        {
            return name;
        }

    protected:

        //Protected function
        int getPosition() const 
        {
            return position;
        }
};

class Foo : public Foobar 
{
    public:

        //Foo constructor takes in the same parameters as its base class Foobar
        Foo(const string& name) : Foobar(name) 
        {

        } 

        //Foo's strength is 3 times its position
        int getStrength() const  
        {
            return getPosition() * 3;
        }
};

class Bar : public Foobar 
{
    public:

        // Bar constructor takes in the same parameters as its base class Foobar
        Bar(const string& name) : Foobar(name) {}

        //Bar's strength is 15 greater than its position
        int getStrength() const  
        {
            return getPosition() + 15;
        }
};

//Function that reads the input file, adds the Foobar objects and then prints out the Foobars with their strengths in an output file
void read_Foobar_list(const string& inputFileName, const string& outputFileName) 
{
    ifstream inputFile(inputFileName);
    vector<Foobar*> foobars; //Vector of Foobar objects
    string type, name;

    while (inputFile >> type >> name) 
    //The code on line 98 was looked up by CHATGPT on 10/26/2024, OpenAI. (2024). ChatGPT (Version 4.0 mini) [ChatGPT]. https://chat.openai.com
    //Each line of the file is checked; the first word will declare whether the Foobar is a Foo, Bar, or Foobar
    //The next word is the Foo, Bar, or Foobar's name
    {
        if (type == "foobar") 
        {
            foobars.push_back(new Foobar(name));
        } 

        else if (type == "foo") 
        {
            foobars.push_back(new Foo(name));
        } 

        else if (type == "bar") 
        {
            foobars.push_back(new Bar(name));
        }
    }
    
    inputFile.close();

    // Sets positions (back to front)
    int numFoobars = foobars.size();
    for (int i = 0; i < numFoobars; ++i) 
    {
        foobars[i]->setPosition(numFoobars - i);
    }

    // Put info of the Foobars on the output file
    ofstream outputFile(outputFileName);
  
    //Loops through the foobars list and gets the name of the foobar and concatenates it with their strength
    for (int i = 0; i < numFoobars; i++) 
    {
        outputFile << foobars[i] -> getName() << " " << foobars[i]->getStrength() << "\n";
    }
   
    outputFile.close();
}

int main() 
{
    string inputfile, outputfile;
    cout << "Enter name of input file: ";
    cin >> inputfile;
    cout << "Enter name of output file: ";
    cin >> outputfile;
    read_Foobar_list(inputfile, outputfile);

    return 0;
}