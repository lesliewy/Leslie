#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <unistd.h>

main(){
    int len=10000;    
    int v[len];
    for (int i=0;i<len;i++){
       v[i]=i;
    }
    for(int i=0;i<3;i++){
       srand(time(NULL));
       int x=rand()%len;
       printf("%d,",binsearch(x,&v,len));
       sleep(1);                                // 必须加，否则time(NULL) 取得的值可能相同.
    }
    printf("\n");
}

// 查找x是否在数组v中,n是v的长度
int binsearch(int x,int v[],int n){
    int low,high,mid;
    low=0;
    high=n-1;
    while(low <= high){
        mid=(low+high)/2;
        if(x > v[mid])
            low=mid+1;
        else if(x < v[mid])
//            high=mid+1;                     // 此处不能用 high=mid+1, 可能导致死循环.  考虑 v[3]={1,2,3}, low=1,high=3, x=1的情形.
            high=mid;
        else
            return mid;
    } 
    return -1;   // 没有匹配.
}
