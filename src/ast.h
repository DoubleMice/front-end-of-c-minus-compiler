#ifndef AST_H
#define AST_H
#include<string>
#include<memory.h>
#include"symbol.h"
#include<stdlib.h>


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
    node *p = new node;
    memset(p,0,sizeof(node));
    p->left = left;
    p->right = right;
    p->op = op;
    return p;
}

static node *mknode(node *condition,node *_if,node *_else)
{
    node *p = new node;
    memset(p,0,sizeof(node));
    p->condition = condition;
    p->left = _if;
    p->right = _else;
    return p;
}

static leaf *mkleaf(int id,char *content)
{
    leaf *p =new leaf;
    memset(p,0,sizeof(leaf));
    p->type = id;
    strncp(p->content,content,16);
    return p;
}

static leaf *mkleaf(int num,int val)
{
    leaf *p = new leaf;
    memset(p,0,sizeof(leaf));
    p->type = num;
    p->val = val;
    return p;
}



#endif