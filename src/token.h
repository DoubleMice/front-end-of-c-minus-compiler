#ifndef TOKEN_H
#define TOKEN_H
/* +  -  *  /  <  <=  >  >=  ==  !=  =  ;  ,  (  )  [  ]  {  } */
/* \/\*  \*\/ */
/* if  else  return  void  while */
/* relop(to deal with signal) */
/* int(to deal with number) */
typedef enum {
	PLUS = 256,MINUS,MULTI,DEVIDE,LT,LE,GT,GE,SAME,NE,EQ,SEMI,COMMA,LB,RB,LSB,RSB,LCB,RCB,
	LN,RN,
	IF,ELSE,RETURN,VOID,WHILE,
	ID,NUM,FUNC
	RELOP,
    INT
} TType;

typedef struct {
    int TT_type;
    Token_Table *Next;
    char TT_value[16];
} Token_Table;

static void print_token(int token) {
    static char *token_strs[] = {
        "PLUS","MINUS","MULTI","DEVIDE","LT","LE","GT","GE","SAME","NE","EQ","SEMI","COMMA","LB","RB","LSB","RSB",
        "LCB","RCB","LN","RN","IF","ELSE","RETURN","VOID","WHILE","ID","NUM","FUNC","RELOP","INT"
    };
    if (token < 255)
        printf("%-20c", token);
    else
        printf("%-20s",token_strs[token-256]);
}
#endif