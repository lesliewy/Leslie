# include <stdio.h>

main (){
   int aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb=3;
   printf("%d\n",aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb);
   printf("abcdefg\nhijklmn\nopq\n");
   printf("=======================\n");
   printf("abcdefg"\
"hijklmn"\
"opq\n");
   printf("=======================\n");
   printf("abcdefg"
"hijklmn"
"opq\n");
   
   char* a[]={"abcdefg",
              "hijklmn"
              "opq"};
   printf("in array:%s\n",a[1]);    // 编译器的特性可能导致错误.

}


