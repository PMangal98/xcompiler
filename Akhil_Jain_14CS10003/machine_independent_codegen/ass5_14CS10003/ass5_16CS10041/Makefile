tests:  a.out
	./a.out < ass5_16CS10041_test1.c > ass5_16CS10041_quad1.out
	./a.out < ass5_16CS10041_test2.c > ass5_16CS10041_quad2.out

a.out: y.tab.o lex.yy.o ass5_16CS10041_translator.o 
	g++ -g ass5_16CS10041_translator.o lex.yy.o y.tab.o -lfl
	#make run to generate the output
	#make clean to clear all the system generated files
lex.yy.c: ass5_16CS10041.l
	flex ass5_16CS10041.l
y.tab.c: ass5_16CS10041.y
	yacc -dtv ass5_16CS10041.y
ass5_16CS10041_translator.o: ass5_16CS10041_translator.cxx
	g++ -g -c ass5_16CS10041_translator.cxx
lex.yy.o: lex.yy.c
	g++ -g -c lex.yy.c
y.tab.o:    y.tab.c
	g++ -g -DYYDEBUG -c y.tab.c
clean:
	rm lex.yy.c y.tab.h y.output y.tab.c lex.yy.o y.tab.o ass5_16CS10041_translator.o a.out;

