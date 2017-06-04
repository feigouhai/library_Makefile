all:  libhello_print.a  libhello_lib.so  main

.PHONY : all

CFLAGS := -I.  -Wall -O2 -fPIC -DLINUX_OS -DTVOS_H -ffunction-sections -fdata-sections -Wl,--gc-sections


libhello_lib.so : hello_lib.o
	gcc -shared -o libhello_lib.so hello_lib.o -L. -lhello_print

libhello_print.a : hello_print.o
	ar cr libhello_print.a hello_print.o

main : main.o
	gcc -o main main.o -L. -lhello_print -lhello_lib

hello_print.o : hello_print.c
	gcc $(CFLAGS) -c -o hello_print.o hello_print.c 

hello_lib.o : hello_lib.c
	gcc $(CFLAGS) -c -o hello_lib.o hello_lib.c 

#main.o: main.c
	gcc $(CFLAGS) -c -o main.o main.c

clean:
	rm -f *.a *.so *.o main
