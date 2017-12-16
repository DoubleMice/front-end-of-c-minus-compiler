%{
	#include<stdio.h>
	#include<stdlib.h>
	#include"lex.yy.c"
	void yyerror(const char*);
	#define YYSTYPE char *
%}

%token IF ELSE RETURN WHILE
%token ID NUM FUNC
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
	|RETURN expression
	;

expression
	:var '=' expression
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
	int token = -1;
	Token_Table *tthead = NULL,*ttable = NULL,*last_ttable = NULL;
	int poolsz = 32*512;
	uint canary;
	if (!(ttable = (Token_Table*)malloc(poolsz))) { printf("could not malloc(%d) token area\n",poolsz); return -1; }
	memset(ttable,0,poolsz);
	tthead = ttable;
	init_scaner();
	while(token = yylex()) {
        if(yyleng <= TOKEN_LENGTH) {
			strncpy(ttable->TT_Value,yytext,TOKEN_LENGTH+1);
			ttable->TT_Type = token;
			ttable->Next = ttable + 1;
		}
		else {
			printf("token(%s) is too long\n",yytext);
			return -1;
		}
		switch(token) {
			case '(':
				if(last_ttable&&(last_ttable->TT_Type == ID))
					last_ttable->TT_Type = FUNC;

				break;
			default:
				break;
		}
		last_ttable = ttable;
		ttable += 1;
	}
	ttable = tthead;
	list_token(ttable);
	memset(tthead,0,poolsz);
	free(tthead);
	return yyparse();
}