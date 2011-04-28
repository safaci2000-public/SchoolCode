#include <map.h>

template<class T, class U>
void read_and_assign(map<T,U>& M)
{
    typedef map<T,U>::const_iterator MI;

    for (MI i = M.begin(); i != M.end(); i++) {
        const pair<T,U>& r = *i;
        U d; cin >> d; cout << d << ' ';
        M[r.first] = d;
    }
}

template<class T, class U>
void print_entry(const map<T,U>& M)
{
    typedef map<T,U>::const_iterator MI;

    for (MI i = M.begin(); i != M.end(); i++) {
        const pair<T,U>& r = *i;
        cout << '\t' << r.first << " = "
             << setw(5) << r.second << endl;
    }
}

