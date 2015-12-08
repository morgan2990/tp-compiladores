bison -d tp.y
flex tp.l
gcc tp.tab.c lex.yy.c -o testFinal
./testFinal < prueba
./testFinal < prueba2
