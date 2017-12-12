out: lexer
lexer: lex.yy.c token.h
	gcc -o $@ $<
lex.yy.c: c-minus.l
	lex $<