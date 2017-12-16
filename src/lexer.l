/** simple lexical analyzar for c-minus front end */

/* manifest constants */
%{
	// #include "symbol.h"
	#include "token.h"
	#include <memory.h>
	#include "y.tab.h"
	#define YYSTYPE char *
	int cur_line = 1;
	void yyerror(const char *msg);
	void unrecognized_char(char c);
	void init_scaner();
%}

/* regular */
delim   [ \t\n]
ws      {delim}+
letter  [A-Za-z]
digit   [0-9]
id      {letter}({letter}|{digit})*
/* number  {digit}+(\.{digit}+)?(E(+-)?{digit}+)? */
number  {digit}+

comment	"/*"[^"*/"]*"*/"

/* match regular */
/* lex avoids conflict by definition order and matched length */
/* reserver word&&sign : return(val) */
/* num && id(with regular) : set symbol table with its val */

%%
{ws}   		{/* space filter */}
{comment}	{/* comment filter */}

"+"			{return '+';}
"-"			{return '-';}
"*"			{return '*';}
"/"			{return '/';}

"int"		{return INT;}
"void"		{return VOID;}

">="		{return GE;}
"<="		{return LE;}
"=="		{return EQ;}
">"			{return GT;}
"<"			{return LT;}
"="			{return '=';}
";"			{return ';';}
","			{return ',';}
"("			{return '(';}
")"			{return ')';}
"["			{return '[';}
"]"			{return ']';}
"{"			{return '{';}
"}"			{return '}';}

if      	{return IF;}
else		{return ELSE;}
return		{return RETURN;}
while		{return WHILE;}

{id}		{return ID;}
{number}	{return NUM;}

\n			{cur_line++;}
%%





void init_scaner() {printf("%-20s%s\n", "TOKEN-TYPE", "TOKEN-VALUE");}
int yywrap(void) {return 1;}


void yyerror(const char *msg) {
    printf("Error at line %d:\n\t%s\n", cur_line, msg);
    // exit(1);
}