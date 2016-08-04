#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(){
   int num;
   while(scanf("%d",&num)!=0){
      char* arr=malloc(sizeof(char)*num+1);
      memset(arr,'0',sizeof(arr));
      for (i=2;i < 99999999;i++){
         *(arr+1)='1';
         if(*(arr+ 
      } 
   }
   return 0;
}
