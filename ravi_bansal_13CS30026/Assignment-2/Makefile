a.out: mainIO.o libass2_13CS30026.a
	cc mainIO.o -L. -lass2_13CS30026

mainIO.o:	mainIO.c myl.h
	cc -Wall -c mainIO.c

libass2_13CS30026.a:	ass2_13CS30026.o
		ar -rcs libass2_13CS30026.a ass2_13CS30026.o

ass2_13CS30026.o:	ass2_13CS30026.c myl.h
	cc -Wall -c ass2_13CS30026.c
clean:
	rm a.out mainIO.o libass2_13CS30026.a ass2_13CS30026.o
