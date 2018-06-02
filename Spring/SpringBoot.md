## 文档及文章 ##
  * 官方  
  [Spring Boot Reference Guide](https://docs.spring.io/spring-boot/docs/1.5.13.BUILD-SNAPSHOT/reference/htmlsingle/#getting-started)  

  * 其他  
  [关于Spring Boot的博客集合](https://www.jianshu.com/p/7e2e5e7b32ab)  
  [Spring Boot 开发: 从0到1](https://www.jianshu.com/nb/12066555)  
  [Spring Boot干货系列](https://www.cnblogs.com/zheting/p/6707035.html)  

## 配置 ##

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

