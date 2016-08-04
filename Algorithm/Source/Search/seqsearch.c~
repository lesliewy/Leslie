#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <unistd.h>

#define MAXSIZE 1000

typedef struct {
    int key;
    char *value;
} node;
 typedef node seqlist[MAXSIZE + 1];

int main(){
    node seqlist[MAXSIZE+1];
    for(int i=0; i<100; i++){
       node seq;
       seq.key = i;
       itoa(i,seq.value,10);
//       sprintf(seq.value, "%d",i);
       seqlist[i]=seq;
    }
    printf("hello key:%d; value: %s\n",seqlist[5].key,seqlist[5].value);
}

int seqsearch(seqlist list, int n, int key){
   int i;
   for(i=0; i < n && list[i].key != key; i++);
   if( i >= n){
       return -1;
   }
   return i;
}

