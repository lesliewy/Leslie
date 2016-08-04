# include <stdio.h>
//# define th 3

main(){
   int a=3;
   if(a<0)
      printf("a<0\n");
   else if(a<1)
      printf("a<1\n");
   else if(a<2)
      printf("a<2\n");
   else if(a<4)
      printf("a<4\n");
   else
      printf("a>=4\n");
   const int three=3;
   enum {th=3};
   int i=2;
   a=4;
   switch(a){
       case 1: 
           printf("a is 1\n");
           break;
       case 2: 
       abc:
           printf("a is 2 or 3 or 4\n");
           break;
       case th: printf("goto abc\n"); goto abc; 
       case 4:
           switch(i){
               case 1: 
                   printf("i is 1.\n");
                   break;
               case 2:
                   printf("i is 2.\n");
                   break;
           }
       default: 
           printf("error\n");
           break;
   }
   for(a=0;a<3;a++){
      printf("outer:%d\n",a);
      int b=0;
      for (b=0;b<5;b++){
         printf("inner:%d\n",b);
         if(b==3)
            break;
      }
      printf("now is outer.\n");
   }
    
}
