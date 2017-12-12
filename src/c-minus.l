/** simple lexical analyzar for c-minus front end */

/* manifest constants */
%{
	/*#include "symbol.h"*/
	#include "token.h"
	int cur_line = 1;
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

"+"			{return PLUS;}
"-"			{return MINUS;}
"*"			{return MULTI;}
"/"			{return DEVIDE;}
"<"			{return LT;}
"<="		{return LE;}
">"			{return GT;}
">="		{return GE;}
"=="		{return SAME;}
"!="		{return NE;}
"="			{return EQ;}
";"			{return SEMI;}
","			{return COMMA;}
"("			{return LB;}
")"			{return RB;}
"["			{return LSB;}
"]"			{return RSB;}
"{"			{return LCB;}
"}"			{return RCB;}

if      	{return IF;}
else		{return ELSE;}
return		{return RETURN;}
void		{return VOID;}
while		{return WHILE;}
int			{return INT;}

{id}		{return ID;}
{number}	{return NUM;}
%%

int main(int argc,char *argv[]) {
	int token;
	init_scaner();
	while(token = yylex()) {
		print_token(token);
		puts(yytext);
	}
	return 0;
}

void init_scaner() {printf("%-20s%s\n", "TOKEN-TYPE", "TOKEN-VALUE");}
int yywrap(void) {return 1;}