all:  comp gui

gui:
	./gui.sh
	cp src/gui/StegoX .

comp:
	g++ -o stego src/core.cc

run_gui:
	./StegoX

run_jpg:
	./stego --input images/test.jpg --output images/out.jpg --embed jobs/resume.pdf

run_gif:
	./stego --input images/test.gif --output images/out.gif --embed images/serial.txt

run_tiff:
	./stego --input images/test.tiff --output images/out.tiff --embed jobs/resume.pdf

run_png:
	./stego --input images/test.png --output images/out.png --embed jobs/resume.pdf

edit:
	gvim -p src/core.cc  src/gui/*.cc src/gui/mainwidget.h

archive:
	tar cfzv code.tar.gz  src/core.cc src/gui/*.[^o]* makefile gui.sh
