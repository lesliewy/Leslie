## 文档及文章 ##
  * 官方  
  [Spring Boot Reference Guide](https://docs.spring.io/spring-boot/docs/1.5.13.BUILD-SNAPSHOT/reference/htmlsingle/#getting-started)  

  * 其他  
  [关于Spring Boot的博客集合](https://www.jianshu.com/p/7e2e5e7b32ab)  
  [Spring Boot 开发: 从0到1](https://www.jianshu.com/nb/12066555)  
  [Spring Boot干货系列](https://www.cnblogs.com/zheting/p/6707035.html)  
  [第七章：过滤器、监听器、拦截器](https://mp.weixin.qq.com/s?__biz=MjM5NzMyMjAwMA==&mid=2651481544&idx=3&sn=44046a4afbe1056799a312228d570aaf&chksm=bd2509b78a5280a10eb6f54e0861ae1c5becf3b5ab8044020690082985787ff387b7cfebe738&scene=0&key=d022b90eaae9e22394fbd89284982a9693ac3ade05b254698ddab7f91eda14a78d36fdad7dc665c0e5864846be4f54302e0eed59fef6f0b7fb95f6505a79c0517d3d7de88db802adb00c9ca57e680abe&ascene=0&uin=MjQ0NDE5OTIxOQ%3D%3D&devicetype=iMac+MacBookAir7%2C2+OSX+OSX+10.12.5+build(16F73)&version=12020810&nettype=WIFI&lang=zh_CN&fontScale=100&pass_ticket=Q9xqv1Q2QFNWCPJc3WGmhoc%2BduaPx6ltaih1erXhBtN0%2FIz02WC6rQNKsy5qPc6I)  

## 配置 ##


## 特性 ##
  * Retry 框架.  
    [在Spring Boot中使用Spring Retry](https://my.oschina.net/wangxincj/blog/827221)  
    [Spring-retry github](https://github.com/spring-projects/spring-retry)  
    

## 杂项 ##
  * 几种启动方式  
    1. IDE;  
    2. java -jar xxx.jar;  需要先打成可执行jar. 使用spring-boot-maven-plugin,   mvn clean package;  
       java -jar xxx.jar --debug  
    3. mvn spring-boot:run: 必须在springboot的module 内, 否则找不到mainClass.  

  * springboot-devtools  
   [Spring Boot 热部署之spring-boot-devtools](https://blog.csdn.net/lxd19931008/article/details/69949778)  
   [Intellij IDEA 使用Spring-boot-devTools无效解决办法](https://blog.csdn.net/wjc475869/article/details/52442484)  
   如果无法打开 registry,  需要先到 keymap 中映射;  

  * HttpMessageConverter 序列化与反序列化  
  [springboot学习（三）——使用HttpMessageConverter进行http序列化和反序列化](https://www.cnblogs.com/page12/p/8166935.html)  

  * filter
   [springboot中的filter详细用法](https://blog.csdn.net/rt940910a/article/details/79351510)

   @Configuration: 将该filter加入filter chain, 这样就生效了.

## 源码 ##
  