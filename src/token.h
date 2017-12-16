#ifndef TOKEN_H
#define TOKEN_H

#define TOKEN_LENGTH 16-1
/* +  -  *  /  =  ;  ,  (  )  [  ]  {  } */
/* if  else  return  while */
/* id num function */
/* <  <=  >  >=  ==  !=   */
/* int void */


typedef struct Token_Table{
    int TT_Type;
    char padding[8];
    struct Token_Table *Next;
    char TT_Value[16];
} Token_Table;

static void print_token(int token) {
    static char *token_strs[] = {
	    "IF","ELSE","RETURN","WHILE",
	    "ID","NUM","FUNC",
        "LT","LE","GT","GE","NE","EQ",
        "INT","VOID"
    };
    if (token < 255)
        printf("%-20c", token);
    else
        printf("%-20s",token_strs[token-256]);
}

static void list_token(Token_Table *tthead) {
    while((tthead->TT_Type!=0)&&(tthead->Next!=0)) {
		print_token(tthead->TT_Type);
		puts(tthead->TT_Value);
		tthead++;
	}
}

// static void correct_token(Token_Table *ttable,Token_Table **last_table,int yyleng,int token) {

// }

#endif