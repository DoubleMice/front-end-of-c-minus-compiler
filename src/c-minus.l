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
	int token = -1;
	Token_Table *tthead = NULL,*ttable = NULL,*last_ttable = NULL;
	CM_Sym *symbolhead = NULL,*symbol = NULL;
	int poolsz = 32*512;
	uint canary;
	if (!(ttable = (Token_Table*)malloc(poolsz))) { printf("could not malloc(%d) token area\n",poolsz); return -1; }
	if (!(symbol = (CM_Sym*)malloc(poolsz))) { printf("could not malloc(%d) symbol area\n",poolsz); return -1; }
	memset(ttable,0,poolsz);
	memset(symbol,0,poolsz);
	tthead = ttable;
	symbolhead = symbol;
	init_scaner();
	while(token = yylex()&&(canary < poolsz) ) {
		if(yyleng <= TOKEN_LENGTH) {
			strncpy(ttable->TT_value,yytext);
			ttable->TT_Type = token;
			ttable->Next = ttable + 1;
		}
		else {
			printf("token(%s) is too long\n",yytext);
			return -1;
		}
		switch(token) {
			case LB:
				if(last_ttable&&(last_ttable->TT_Type == ID))
					last_ttable->TT_Type = FUNC;
				break;
			case ID:
				symbol = ST_Add(symbol,yytext,bind,token);
				break;
			default:
				break;
		}
		print_token(token);
		puts(yytext);
		last_ttable = ttable;
		ttable += 1;
		canary = (uint)(&ttable - &tthead);
	}
	return 0;
}

void init_scaner() {printf("%-20s%s\n", "TOKEN-TYPE", "TOKEN-VALUE");}
int yywrap(void) {return 1;}