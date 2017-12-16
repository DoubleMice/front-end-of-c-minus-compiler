OUT = c-miuns
CC = gcc
OBJ = lex.yy.o y.tab.o
LEXER = lexer.l
PARSER = parser.y

INPUT = test.c-
RESULT = out.txt

build: $(OUT)

run:
	./$(OUT) < $(INPUT) > $(RESULT)

clean:
	rm -f *.o lex.yy.c y.tab.c y.tab.h y.output $(OUT)

$(OUT): $(OBJ)
	$(CC) -o $(OUT) $(OBJ)

lex.yy.c: $(LEXER) y.tab.c
	flex $<

y.tab.c: $(PARSER)
	bison -vdty $<
