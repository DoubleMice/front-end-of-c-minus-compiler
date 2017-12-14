/** simple lexical analyzar for c-minus front end */

/* manifest constants */
%{
	#include "symbol.h"
	#include "token.h"
	#include <memory.h>
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
func	{id}"("

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

{func}		{return FUNC;}
{id}		{return ID;}
{number}	{return NUM;}
%%



int main(int argc,char *argv[]) {
	int token = -1,last_token = -1;
	void *symbol,*ttable;
	int poolsz = 4*1024;
	if (!(ttable = (Token_Table*)malloc(poolsz))) { printf("could not malloc(%d) token area\n",poolsz); return -1; }
	if (!(symbol = (CM_Sym*)malloc(poolsz))) { printf("could not malloc(%d) symbol area\n",poolsz); return -1; }
	memset(ttable,0,poolsz);
	memset(symbol,0,poolsz);
	init_scaner();
	while(token = yylex()) {
		switch(token) {
			case ID:
				;
			case VOID:;
			case IF:;
			case ELSE:;
			case WHILE:;
		}
		print_token(token);
		puts(yytext);
	}
	return 0;
}

void init_scaner() {printf("%-20s%s\n", "TOKEN-TYPE", "TOKEN-VALUE");}
int yywrap(void) {return 1;}