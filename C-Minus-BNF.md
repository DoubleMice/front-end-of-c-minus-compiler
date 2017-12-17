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

E -> A
A -> A B|B
B -> C|E
C -> D ID;|D ID [NUM];
D -> int|void
E -> D ID (F)|G
F -> H|void
H -> H,I|I
I -> D ID | D ID []
G -> {J K}
J ->J C|''
K -> K L|''
L -> M|G|N|O|P
M -> Q
N -> if(Q) L|if(Q) L else L
O -> while(Q) L
P -> return ;|return Q
Q -> var = Q|R
var -> ID|ID [Q]
R -> S relop S|S
relop -> <=|<|>=|==|!=
S -> S addop term|term
addop -> +|-
term -> term mulop V|V
mulop -> *|/
V -> (Q) | var|call|NUM
call -> ID(T)
T -> U | ''
U -> U,Q|Q