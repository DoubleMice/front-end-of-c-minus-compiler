#ifndef SYMBOL_H
#define SYMBOL_H
#include "hash.h"
#include <string.h>
#define uint unsigned int
#define uint64 unsigned long int 

typedef enum {
    LOCAL,GLOBAL
} STBind;

typedef enum {
    DEFAULT,
} STVis;

typedef struct CM_Sym {
	uint ST_HVal;
	int ST_Type;
    char *ST_Bind;
    struct CM_Sym *Next;
    char ST_name[16];
}CM_Sym;

#define OFFSET sizeof(CM_Sym)

static CM_Sym *ST_Lookup(CM_Sym *symbol,char *name) {
	CM_Sym *head = symbol;
	if(symbol->ST_HVal == 0)
		return NULL;
	uint hash = time33(name);
	while((head->ST_HVal != 0) && (head->ST_HVal!=hash))
		head = head->Next;
	if(head->ST_HVal != 0)
		return head;
	else
		return NULL;
}

static CM_Sym *ST_Add(CM_Sym *symbol,char *name,char *bind,int type) {
	CM_Sym *search = ST_Lookup(symbol,name); 
	if((search != NULL))
		return 0;
	if(search->Next == 0) {
		search->Next = search + 1;
		search = search->Next;
		search->Next->ST_HVal = time33(name);
		search->Next->ST_Bind = bind;
		strncpy(search->Next->ST_name,name,16);
	}
	return search;
}

#endif