/***********************************************************************
 * Nom:			Samir Faci
 * Programme:	Programme Numero 1
 *
 * Note:		
 *
 * *********************************************************************/
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>
#include <fstream>
using namespace std;

void introduction();
void donnees(string *&dest, string *&hotel, string *&accmod, int *&prix);


ifstream in;

int main()
{
	int *x;

	string * dest, * hotel, * accmod;

	in.open("donne.txt");

	if (!in.is_open())
	{
		cerr << "Error:  could not open file." << endl;
		exit(-1);
	}

	string ans;


	system("cls");
	cout <<	"Voulez vous voir les instruction d'utilization?   ";
	cin >> ans;

	if (ans[0] == 'O' || ans[0] == 'o')
			introduction();

	cout << "Reading test data" << endl;
	donnees(dest, hotel, accmod, x);

	in.close();

	return 0;
}
/***********************************************************************
 * Nom de fonction:		introduction
 * Parametres:			Aucun
 *
 * Retour:				Rien
 *
 * **********************************************************************/

void introduction()
{
	cout << "\n\nLe mode d'emploi est assez simple. \n";
	cout << "suivez les instruction donner par le programme, \n";
	cout << "et tous ira bien.  Si vous avez d'autre question, lisez\n";
	cout << "le mode d'employ titulez ReadMe.txt qui sera fourni dans \n"
			<< "la version suivante!";

	cout << "\n\n\nAmusez vous bein, et bon chance!\n";
}
/***********************************************************************
 * Nom de fonction:		introduction
 * Parametres:			Aucun
 *
 * Retour:				Rien
 *
 * **********************************************************************/
void donnees(string *&dest, string *&hotel, string *&accmod, int *&prix)
{
	int nombre;
	in >> nombre;
	int cnt = 0;

	dest = new string[nombre];

	for (cnt = 0; cnt < nombre; cnt++)	// Boucle lit les destination
		in >> dest[cnt];

	in >> nombre;
	cout << "nombre d'hotel:  " << nombre << endl;

	hotel = new string[nombre];


	for (cnt = 0; cnt < nombre; cnt++)
		getline(in, hotel[cnt], '\n');

	accmod = new string[nombre];
	prix = new int[nombre];

	
	for (cnt = 0; cnt < nombre; cnt++)
		getline(in, accmod[cnt], '\n');


	for (cnt = 0; cnt < nombre; cnt++)
		in >> prix[cnt];

}
