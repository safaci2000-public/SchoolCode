# simple make file, just type make to run exe.
prog:
	g++ main.cc finger.cc -g -ltiff -o biometric  -pthread -L/usr/lib64 -lmpi_cxx -lmpi -lopen-rte -lopen-pal -ldl -Wl,--export-dynamic -lnsl -lutil -lm -ldl  
#	mpic++ main.cc finger.cc -g -ltiff -o biometric

run:	clean
	mpirun -n 8 ./biometric 101.tif
	
clean:
	rm -fr outdb/*
	touch final.tif
	rm  final.tif 
edit:
	gvim -p finger.cc main.cc finger.h

