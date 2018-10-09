a.out: y.tab.o lex.yy.o ass5_13CS30026_translator.o 
	g++ -g ass5_13CS30026_translator.o lex.yy.o y.tab.o -lfl
	#make run to generate the output
	#make clean to clear all the system generated files
lex.yy.c: ass5_13CS30026.l
	flex ass5_13CS30026.l
y.tab.c: ass5_13CS30026.y
	yacc -dtv ass5_13CS30026.y
ass5_13CS30026_translator.o: ass5_13CS30026_translator.cxx
	g++ -g -c ass5_13CS30026_translator.cxx
lex.yy.o: lex.yy.c
	g++ -g -c lex.yy.c
y.tab.o:    y.tab.c
	g++ -g -DYYDEBUG -c y.tab.c
clean:
	rm lex.yy.c y.tab.h y.output y.tab.c lex.yy.o y.tab.o ass5_13CS30026_translator.o a.out ass5_13CS30026_quad1.c ass5_13CS30026_quad2.c ass5_13CS30026_quad3.c ass5_13CS30026_quad4.c ass5_13CS30026_quad5.c
run: 
	./a.out < ass5_13CS30026_test1.c > ass5_13CS30026_quad1.c
	./a.out < ass5_13CS30026_test2.c > ass5_13CS30026_quad2.c
	./a.out < ass5_13CS30026_test3.c > ass5_13CS30026_quad3.c
	./a.out < ass5_13CS30026_test4.c > ass5_13CS30026_quad4.c
	./a.out < ass5_13CS30026_test5.c > ass5_13CS30026_quad5.c

