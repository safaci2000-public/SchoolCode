template<class T>struct Node
{
	T entry;
	Node<T>* next;
	Node(){ };
	Node(T new_val, Node<T>* passed_ptr= 0)
	{
		entry = new_val;
		next = passed_ptr;
	}

};


