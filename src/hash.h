#ifndef HASH_H
#define HASH_H

static unsigned int time33(char *str){
    unsigned int hash = 5381;
    while(*str){
        hash += (hash << 5 ) + (*str++);
    }
    return (hash & 0x7FFFFFFF);
}

#endif