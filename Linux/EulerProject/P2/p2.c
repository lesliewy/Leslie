#include <stdio.h>
int main()
{
   long int fnum,fvalue,sum=0;
   int i;
   printf("please input the value:");
   //scanf("%ld",&fnum); 
   fnum=4000000;
   for (i=1;i<=fnum;i++)
   {
   //   printf("the fibonacci number is:%d\n,",fibonacci(i));
      fvalue=fibonacci(i);
      if(fvalue > 4000000)
      {
         break;
      }
      if(fvalue %2 ==0)
      {
         sum+=fvalue; 
      }
   }
  // fvalue=fibonacci(fnum);
   printf("the fibonacci number is:%ld\n",fvalue);
   printf("the sum is:%ld\n",sum);
   
}
int fibonacci(long fvalue)
{
   if(fvalue==1)
   {
      return 1;
   }
   else if(fvalue==2)
   {
      return 2;
   }else
   {
      return fibonacci(fvalue-1)+fibonacci(fvalue-2);
   }

}
