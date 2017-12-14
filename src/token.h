#ifndef TOKEN_H
#define TOKEN_H

#define TOKEN_LENGTH 16-1
/* +  -  *  /  =  ;  ,  (  )  [  ]  {  } */
/* if  else  return  while */
/* id num function */
/* <  <=  >  >=  ==  !=   */
/* int void */
typedef enum {
	ADDOP = 256,MULOP,EQ,SEMI,COMMA,LB,RB,LSB,RSB,LCB,RCB,
	IF,ELSE,RETURN,WHILE,
	ID,NUM,FUNC,
    RELOP,
    VARTYPE
} TType;

typedef struct Token_Table{
    int TT_Type;
    char padding[8];
    struct Token_Table *Next;
    char TT_Value[16];
} Token_Table;

static void print_token(int token) {
    static char *token_strs[] = {
        "ADDOP","MULOP","EQ","SEMI","COMMA","LB","RB","LSB","RSB","LCB","RCB",
	    "IF","ELSE","RETURN","WHILE",
	    "ID","NUM","FUNC",
        "RELOP",
        "VARTYPE"
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