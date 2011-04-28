template <class T> class binTree;

template<class T> struct binTNode
{
//	friend binTree<T>;
public:
	T data;
	binTNode<T> *left, *right;
	binTNode(const T& val ,binTNode<T>* r,binTNode<T>* l)
	{
		left = l; right = r; data = val;
	}
	binTNode(const T& val)
	{
		data = val;
		left = right = 0;
	}
	binTNode(){ left = 0; right=0; };
private:  
};
