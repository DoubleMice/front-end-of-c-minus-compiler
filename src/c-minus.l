/** simple lexical analyzar for c-minus front end */

/* manifest constants */
%{
	// #include "symbol.h"
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

addop	"+"|"-"
mulop	"*"|"/"
vartype	"int"|"void"
comment	"/*"[^"*/"]*"*/"

/* match regular */
/* lex avoids conflict by definition order and matched length */
/* reserver word&&sign : return(val) */
/* num && id(with regular) : set symbol table with its val */

%%
{ws}   		{/* space filter */}
{comment}	{/* comment filter */}

{addop}			{return ADDOP;}
{mulop}			{return MULOP;}
{vartype}		{return VARTYPE;}
">="			{return RELOP;}
"<="			{return RELOP;}
"=="			{return RELOP;}
">"				{return RELOP;}
"<"				{return RELOP;}
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
%%



int main(int argc,char *argv[]) {
	int token = -1;
	Token_Table *tthead = NULL,*ttable = NULL,*last_ttable = NULL;
	// CM_Sym *symbolhead = NULL,*symbol = NULL;
	int poolsz = 32*512;
	uint canary;
	if (!(ttable = (Token_Table*)malloc(poolsz))) { printf("could not malloc(%d) token area\n",poolsz); return -1; }
	// if (!(symbol = (CM_Sym*)malloc(poolsz))) { printf("could not malloc(%d) symbol area\n",poolsz); return -1; }
	memset(ttable,0,poolsz);
	// memset(symbol,0,poolsz);
	tthead = ttable;
	// symbolhead = symbol;
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
	return 0;
}

void init_scaner() {printf("%-20s%s\n", "TOKEN-TYPE", "TOKEN-VALUE");}
int yywrap(void) {return 1;}