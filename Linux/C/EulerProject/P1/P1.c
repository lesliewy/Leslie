#include <stdio.h>
int main(){
   long a,sum=0;
   printf("please input a number:");
   scanf("%ld",&a);
   sum=calsum(a);
   printf("the sum of multiples is:%ld\n",sum);
}
 
int calsum(long a){
   long i=0;
   long sum=0;
   for(i=1;i<a;i++){
      if(i%3==0){
        sum+=i;
      }else if(i%5==0){
        sum+=i;
      }
     
   } 
  return sum; 
}
