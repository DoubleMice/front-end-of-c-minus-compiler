#ifndef TOKEN_H
#define TOKEN_H

#define TOKEN_LENGTH 16-1
/* +  -  *  /  <  <=  >  >=  ==  !=  =  ;  ,  (  )  [  ]  {  } */
/* \/\*  \*\/ */
/* if  else  return  void  while */
/* relop(to deal with signal) */
/* int(to deal with number) */
typedef enum {
	PLUS = 256,MINUS,MULTI,DEVIDE,LT,LE,GT,GE,SAME,NE,EQ,SEMI,COMMA,LB,RB,LSB,RSB,LCB,RCB,
	LN,RN,
	IF,ELSE,RETURN,VOID,WHILE,
	ID,NUM,FUNC,
	RELOP,
    INT
} TType;

typedef struct Token_Table{
    int TT_Type;
    char padding[8];
    struct Token_Table *Next;
    char TT_Value[16];
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

// static char *TT_LastFUNC(Token_Table ttable,int token) {
//     while(Token)
// }

#endif