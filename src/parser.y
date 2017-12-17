%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<memory.h>
	void yyerror(const char*);
	#define YYSTYPE char *
	#define TOKEN_LENGTH 16-1
	extern char *yytext;
%}

%token IF ELSE RETURN WHILE
%token ID NUM
%token LT LE GT GE NE EQ
%token INT VOID
%token '=' ';' ',' '(' ')' '[' ']' '{' '}'
%token '+' '-' '*' '/'

%left '+' '-'
%left '*' '/'
                                                                                                 
%start program

%%
program
	:declarationlist
	;

declarationlist
	:declarationlist declaration
	|declaration
	;

declaration
	:vardeclaration
	|fundeclaration
	;

vardeclaration
	:typespecifier ID ';'
	|typespecifier ID '[' NUM ']' ';'
	;

typespecifier
	:INT
	|VOID
	;

fundeclaration
	:typespecifier ID '(' params ')'
	|compoundstmt
	;

params
	:paramlist
	|VOID
	;

paramlist
	:paramlist ',' param
	|param
	;

param
	:typespecifier ID 
	| typespecifier ID '[' ']'
	;

compoundstmt
	:'{' localdeclarations stmtlist '}'
	;

localdeclarations
	:localdeclarations vardeclaration
	|
	;

stmtlist
	:stmtlist stmt
	|
	;

stmt
	:expressionstmt
	|compoundstmt
	|selectionstmt
	|iterationstmt
	|returnstmt
	;

expressionstmt
	:expression
	;

selectionstmt
	:IF '(' expression ')' stmt
	|IF '(' expression ')' stmt ELSE stmt
	;

iterationstmt
	:WHILE '(' expression ')' stmt
	;

returnstmt
	:RETURN ';'
	|RETURN expression ';'
	;

expression
	:var '=' expression ';'
	|simpleexpression
	;

var
	:ID
	|ID '[' expression ']'
	;

simpleexpression
	:additiveexpression relop additiveexpression
	|additiveexpression
	;

relop
	:LE
	|GT
	|GE
	|EQ
	|NE
	;

additiveexpression
	:additiveexpression addop term
	|term
	;

addop
	:'+'
	|'-'
	;

term
	:term mulop factor
	|factor
	;

mulop
	:'*'
	|'/'
	;

factor
	:'(' expression ')' 
	|var
	|call
	|NUM
	;

call
	:ID '(' args ')'
	;

args
	:arglist 
	| 
	;

arglist
	:arglist ',' expression
	|expression
	;
%%




int main(int argc,char *argv[]) {
	int token;
	yyparse();
	init_scaner();
	while(token = yylex()) {
		print_token(token);
		puts(yytext);
	}
	return 0;
}