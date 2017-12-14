#ifndef SYMBOL_H
#define SYMBOL_H
#include "hash.h"
#define uint unsigned int
#define uint64 unsigned long int 

typedef enum {
    LOCAL,GLOBAL
} STBind;

typedef enum {
    DEFAULT,
} STVis;

typedef struct {
    uint st_Val;
    uint st_Num;
    char *st_Bind;
    CM_Sym *Next;
    char st_name[16];
}CM_Sym;

#define OFFSET sizeof(CM_Sym)

static void ST_add(CM_Sym *symbol,char *name) {
	CM_Sym *st = symbol;
	uint hash = time33(name);
	while(st->st_Val != hash)
		st = st->Next;
	if(st->Next == 0) {
		st->Next = st + 1;
		st = st->Next;
		st->Next->st_Val = hash;
		st->Next->st_Num = st->st_Val + 1;
		st->Next->st_Bind;
		st->Next->st_name;
	}
}

#endif