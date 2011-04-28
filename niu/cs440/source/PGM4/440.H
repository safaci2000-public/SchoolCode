#include <iostream>
#include <fstream>
#include <iomanip>

#include <cstdlib>
#include <climits>
#include <cmath>
#include <ctime>
#include <string>
using namespace std;

enum Error_code { success, fail, range_error, underflow, overflow,
        fatal, not_present, duplicate_error, entry_inserted,
        entry_found, internal_error };
