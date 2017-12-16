program -> declaration-list
declaration-list -> declaration-list declaration|declaration
declaration -> var-declaration|fun-declaration
var-declaration -> type-specifier ID;|type-specifier ID [NUM];
type-specifier -> int|void
fun-declaration -> type-specifier ID (params)|compound-stmt
params -> param-list|void
param-list -> param-list,param|param
param -> type-specifier ID | type-specifier ID []
compound-stmt -> {local-declarations statement-list}
local-declarations ->local-declarations var-declaration|empty
statement-list -> statement-list statement|empty
statement -> expression-stmt|compound-stmt|selection-stmt|iteration-stmt|return-stmt
expression-stmt -> expression
selection-stmt -> if(expression) statement|if(expression) statement else statement
iteration-stmt -> while(expression) statement
return-stmt -> return ;|return expression
expression -> var = expression|simple-expression
var -> ID|ID [expression]
simple-expression -> additive-expression relop additive-expression|additive-expression
relop -> <=|<|>=|==|!=
additive-expression -> additive-expression addop term|term
addop -> +|-
term -> term mulop factor|factor
mulop -> *|/
factor -> (expression) | var|call|NUM
call -> ID(args)
args -> arg-list | empty
arg-list -> arg-list,expression|expression

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