## 文档
  [官方 github](https://github.com/apache/incubator-dubbo)  
  [官方文档](http://dubbo.apache.org/books/dubbo-user-book/)
  [官方解释服务调用过程](http://dubbo.apache.org/zh-cn/docs/source_code_guide/service-invoking-process.html)

## 配置
    <dubbo:application name="xixi_provider"  />
    <dubbo:registry address="zookeeper://127.0.0.1:2181" />  
    <dubbo:protocol name="dubbo" port="20880" />
    向指定的zk注册；

## 杂项
  * telnet 扩展  
  [telnet 命令参考手册](http://dubbo.apache.org/en-us/docs/user/references/telnet.html)  
  在本机暴露20880端口，给消费者调用, 所以可以 telnet 127.0.0.1 20880:  
     help  
     ls: 查看所有服务.  
     ls cn.test.dubbo.intf.DemoService: 查看指定服务的方法.  
     invoke cn.test.dubbo.intf.DemoService.sayHello("a"): 调用指定的服务. 在有多个providers情况下可用于调试.  
     invoke cn.wy.crest.share.api.intf.AuditService.applyList("a",3,4):  调用本机上的指定service method  

  * 启动dubbo方式.
  main 中使用: 有spring支持就可以，不需要启动容器. 
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(
                new String[]{"applicationContext-producter.xml"});
        context.start();

  容器中使用:
  
  * dubbo admin 已没人维护，存在一些bug. 推荐使用 [dubbokeeper](https://github.com/dubboclub/dubbokeeper)   

  ## 源码阅读
    * [手把手带你阅读dubbo源码(一) 服务暴露](https://blog.csdn.net/u012117723/article/details/80734653)
    * [手把手带你阅读dubbo源码(二) 服务发现](https://blog.csdn.net/u012117723/article/details/80742790)
    * [Dubbo源码阅读体会(一)](https://blog.csdn.net/u010681276/article/details/46416645)
    * [Dubbo调度机制解析(LoadBalance扩展)](https://blog.csdn.net/qq838642798/article/details/78437330)
    * [源码分析Dubbo负载算法](https://blog.csdn.net/prestigeding/article/details/80939248)
    * [Dubbo 源码解析](https://blog.csdn.net/u013076044/column/info/23907)

