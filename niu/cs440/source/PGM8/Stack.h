#include <stack.h>

template<class T>
class Stack : public stack<T> {
public:
    T POP();
};

template<class T>
T Stack<T>::POP()
{
    assert(!empty());

    T tmp = top(); pop();
    return tmp;
}

