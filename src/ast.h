#ifndef AST_H
#define AST_H
#include<string.h>
#include<memory.h>
#include"symbol.h"


typedef struct N {
    struct N *left;
    struct N *right;
    union {
        int op;               //for normal node
        struct N *condition;    //for condition node
    };
} node;

typedef struct L {
    int type;
    union {
        char *content[16];
        int val;
    };
} leaf;

static node *mknode(int op,node *left,node *right)
{
    node *p = new(sizeof(node));
    memset(p,0,sizeof(node));
    p->left = left;
    p->right = right;
    p->op = op;
    return p;
}

static node *mknode(node *_if,node *condition,node *_else)
{
    node *p = new(sizeof(node));
    memset(p,0,sizeof(node));
    p->condition = condition;
    p->left = _if;
    p->right = _else;
    return p;
}

static node *mkleaf(int id,char *content)
{
    leaf *p =new(sizeof(leaf));
    memset(p,0,sizeof(leaf));
    p->type = id;
    strncp(p->content,content,16)
    return p;
}

static node *mkleaf(int num,int val)
{
    leaf *p = new(sizeof(leaf));
    memset(p,0,sizeof(leaf));
    p->type = num;
    p->val = val;
    return p;
}



#endif