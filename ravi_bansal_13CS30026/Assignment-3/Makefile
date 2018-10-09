a.out : lex.yy.o Ass3_13CS30026.o y.tab.o
	g++ lex.yy.o Ass3_13CS30026.o y.tab.o -lfl
	echo "Enter "make run" to run."
y.tab.o : y.tab.c y.tab.h
	g++ -c y.tab.c
lex.yy.o: lex.yy.c
	g++ -c lex.yy.c
lex.yy.c: ass3_13CS30026.l y.tab.h
	flex ass3_13CS30026.l
Ass3_13CS30026.o : ass3_13CS30026.c y.tab.h
	g++ -c Ass3_13CS30026.c
y.tab.h: ass3_13CS30026.y
	yacc -dtv ass3_13CS30026.y
y.tab.c: ass3_13CS30026.y
	yacc -dtv ass3_13CS30026.y
clean:
	rm a.out lex.yy.o Ass3_13CS30026.o lex.yy.c y.tab.c y.tab.h y.tab.o ass3_13CS30026.c y.output
run:
	./a.out < ass3_13CS30026_test.c


	
