class parTree;

template<class T> class parTNode
{
//	friend parTree;
 public:
	parTNode(const int , const T& );

// private:
 public:
	int id;
	T entry;
	parTNode * left; 
	parTNode * right;
};

template<class T>
parTNode<T>::parTNode(const int x=0, const T& val = T() )
{
	id = x;
	left = 0;
	right = 0;
	entry = val;
}
