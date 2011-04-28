#include <queue.h>

template<class T>
class Queue : public queue<T> {
public:
    void insert(const T&);
    T remove();
};

template<class T>
void Queue<T>::insert(const T& x) { push(x); }

template<class T>
T Queue<T>::remove()
{
    assert(!empty());

    T tmp = front(); pop();
    return tmp;
}

