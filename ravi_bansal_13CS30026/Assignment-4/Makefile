a.out:	y.tab.o lex.yy.o Ass4_13CS30026.o 
	g++ Ass4_13CS30026.o lex.yy.o y.tab.o -lfl
	echo "Enter "make run" to run."
lex.yy.c:	ass4_13CS30026.l
	flex ass4_13CS30026.l
y.tab.c:	ass4_13CS30026.y
	yacc -dtv ass4_13CS30026.y
Ass4_13CS30026.o:	Ass4_13CS30026.c
	g++ -c Ass4_13CS30026.c
lex.yy.o:	lex.yy.c
	g++ -c lex.yy.c
y.tab.o:	y.tab.c
	g++ -c y.tab.c

clean:
	rm lex.yy.c y.tab.h y.output y.tab.c lex.yy.o y.tab.o Ass4_13CS30026.o a.out

run:
	./a.out < ass4_13CS30026_test.c
