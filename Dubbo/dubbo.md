*   https://github.com/apache/incubator-dubbo
    http://dubbo.apache.org/books/dubbo-user-book/

* 
    <dubbo:application name="xixi_provider"  />
    <dubbo:registry address="zookeeper://127.0.0.1:2181" />  
    <dubbo:protocol name="dubbo" port="20880" />
    向指定的zk注册；
    在本机暴露20880端口，给消费者调用, 所以可以 telnet 127.0.0.1 20880:
     ls: 查看所有服务.
     ls cn.test.dubbo.intf.DemoService: 查看指定服务的方法.
     invoke cn.test.dubbo.intf.DemoService.sayHello("a"): 调用指定的服务. 在有多个providers情况下可用于调试.

* 启动dubbo方式.
  main 中使用: 有spring支持就可以，不需要启动容器. 
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(
                new String[]{"applicationContext-producter.xml"});
        context.start();

  容器中使用:

* telnet 扩展
  help;
  invoke cn.wy.crest.share.api.intf.AuditService.applyList("a",3,4):  调用本机上的指定service method