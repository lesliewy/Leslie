#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main()
{
   int num,i=0,diff;
   int intarr[3001];
   int flgarr[3001];
   while(scanf("%d ",&num)!=EOF)
   {
      memset(flgarr,0,3001*sizeof(int));
      memset(intarr,0,3001*sizeof(int));
      for(i=1;i<=num;i++)
      {
         if(i==num)
         {
            scanf("%d",&intarr[i]);
         }else
         {
            scanf("%d ",&intarr[i]);         
         }
         if(i > 1)
         {
            diff=abs(intarr[i]-intarr[i-1]);
            if(diff < 3001)
            {
               flgarr[diff]=1;
            }
         }
      }
      for(i=1;i < num;i++)
      {
         if(flgarr[i]!=1)
         {
            printf("Not jolly\n");
            break;
         }
      }
      if(i==num)
      {
         printf("Jolly\n");
      }
   }
   return 0;
}
