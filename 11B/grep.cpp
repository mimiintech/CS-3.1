// ----------------------------------------------------------------------
//  CS 218 -> Assignment #11
//  Word count program.
//  Provided main...

#include <cstdlib>
#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
#include <cmath>

using	namespace	std;

// ----------------------------------------------------------------------
//  External functions (in seperate file).

extern "C" bool checkParameters(int, char *[], char [], bool *, FILE **);
extern "C" bool getWord(char [], int, FILE *);
extern "C" void checkWord(char [], char [], bool, unsigned int *);

// ----------------------------------------------------------------------
//  Main routine.

int main(int argc, char* argv[])
{
	static	const	unsigned int	MAXWORDLENGTH=80;
	char		searchWord[MAXWORDLENGTH+1];
	char		currentWord[MAXWORDLENGTH+1];
	FILE		*rdFileDesc=0;
	bool		matchCase = false;
	unsigned int	wordCount=0;


	// for(int i =0; i<MAXWORDLENGTH+1; i++){
	// 	searchWord[i] = 'z';
	// 	currentWord[i] = 'z';
	// }

	// check command line parameters
	if (checkParameters(argc, argv, searchWord, &matchCase, &rdFileDesc)) {

		// for(int i =0; i<MAXWORDLENGTH+1; i++){
		// std::cout << searchWord[i] << "";
		// std::cout << matchCase << endl; 
		// get next word
		while (getWord(currentWord, MAXWORDLENGTH, rdFileDesc)) {
			// check word against search word, update count as appropriate
		// std::cout << currentWord <<endl; 
			//  cout<<"here"<<endl;

			// cout << currentWord << endl; 
			
			checkWord(searchWord, currentWord, matchCase, &wordCount);
		}
		// std:: cout << endl; 

		// for(int i =0; i<MAXWORDLENGTH+1; i++){
		// std::cout << searchWord[i] << "";
		// std::cout << currentWord[i] << "";}
	
		// std:: cout << endl; 

		// show final results
		cout << "Found '" << searchWord << "' "
				<< wordCount << " times." << endl;
	}

	return EXIT_SUCCESS;
}

