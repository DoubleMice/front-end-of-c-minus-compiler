/** simple lexical analyzar for c-minus front end */

/* manifest constants */
/* +  -  *  /  <  <=  >  >=  ==  !=  =  ;  ,  (  )  [  ]  {  } */
/* \/\*  \*\/ */
/* if  else  return  void  while */
/* relop(to deal with signal) */
/* int(to deal with number) */
%{
	PLUS,MINUS,MULTI,DEVIDE,LT,LE,GT,GE,SAME,NE,EQ,SEMI,COMMA,LB,RB,LSB,RSB,LCB,RCB,
	LN,RN,
	IF,ELSE,RETURN,VOID,WHILE,
	ID,NUMBER,
	RELOP,
	INT
%}

/* regular */
delim   [ \t\n]
ws      {delim}+
letter  [A-Za-z]
digit   [0-9]
id      {letter}({letter}|{digit})*
/* number  {digit}+(\.{digit}+)?(E(+-)?{digit}+)? */
number  {digit}+

/* match regular
lex avoids conflict by definition order and matched length
reserver word&&sign : return(val)
num && id(with regular) : set symbol table with its val
*/
%%
{ws}    {/* filter */}

\/\*	{yylval = (int)notation(LN);return(LN)}
\*\/	{yylval = (int)notation(RN);return(RN)}

"+"		{yylval = PLUS;return(RELOP)}
"-"		{yylval = MINUS;return(RELOP)}
"*"		{yylval = MULTI;return(RELOP)}
"/"		{yylval = DEVIDE;return(RELOP)}
"<"		{yylval = LT;return(RELOP)}
"<="	{yylval = LE;return(RELOP)}
">"		{yylval = GT;return(RELOP)}
">="	{yylval = GE;return(RELOP)}
"=="	{yylval = SAME;return(RELOP)}
"!="	{yylval = NE;return(RELOP)}
"="		{yylval = EQ;return(RELOP)}
";"		{yylval = SEMI;return(RELOP)}
","		{yylval = COMMA;return(RELOP)}
"("		{yylval = LB;return(RELOP)}
")"		{yylval = RB;return(RELOP)}
"["		{yylval = LSB;return(RELOP)}
"]"		{yylval = RSB;return(RELOP)}
"{"		{yylval = LCB;return(RELOP)}
"}"		{yylval = RCB;return(RELOP)}

if      {return(IF)}
else	{return(ELSE)}
return	{return(RETURN)}
void	{return(VOID)}
while	{return(WHILE)}

{id}		{yylval = (int)installID();return(ID)}
{number}	{yylval = (int)installNUM();return(NUM)}
%%



/* assist func */
int installID();/* set id symbol table */
int installNUM();/* set num symbol table */
int notation(int);/* notation filter, param note L or R*/