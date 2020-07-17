## 文档
  [官方 github](https://github.com/apache/incubator-dubbo)  
  [官方文档](http://dubbo.apache.org/zh-cn/docs/user/quick-start.html)
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

  * Docker 中使用Dubbo
    问题: 注册到zk上的dubbo url 是docker的ip, 类似 dubbo://172.16.0.3:48085/... 如果消费者和docker不在同一个宿主机，调用dubbo就会出现问题，
         具体来说，在 com.alibaba.dubbo.remoting.transport.AbstractClient#getAttribute, 获取到的channel 为null.
    解决: dubbo 2.6.4 版本中, 可以通过环境变量指定注册到zk上的ip: DUBBO_PORT_TO_REGISTRY. 只需在docker run 中添加环境变量即可.
         docker run -d -it -p 8081:8081 -p 58081:58081 \
            -e JAVA_OPTS="-Xms1024m -Xmx1536m" \
            -e DEPLOY_ENV=dev \
            -e DUBBO_IP_TO_REGISTRY=10.57.239.242 \
            --name aaa aaa:v1.0
         其中的 DUBBO_IP_TO_REGISTRY 指定的ip会注册到zk, 58081 是提供者的端口，需要映射到宿主机供消费者调用。
         dubbo的源码: com.alibaba.dubbo.config.ServiceConfig#doExportUrlsFor1Protocol
         dubbo 2.8.4 中好像没有使用外部变量的代码了，这个版本还不知道怎么处理。

  ## 源码阅读
    * [手把手带你阅读dubbo源码(一) 服务暴露](https://blog.csdn.net/u012117723/article/details/80734653)
    * [手把手带你阅读dubbo源码(二) 服务发现](https://blog.csdn.net/u012117723/article/details/80742790)
    * [Dubbo源码阅读体会(一)](https://blog.csdn.net/u010681276/article/details/46416645)
    * [Dubbo调度机制解析(LoadBalance扩展)](https://blog.csdn.net/qq838642798/article/details/78437330)
    * [源码分析Dubbo负载算法](https://blog.csdn.net/prestigeding/article/details/80939248)
    * [Dubbo 源码解析](https://blog.csdn.net/u013076044/column/info/23907)

