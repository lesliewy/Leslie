## 配置 ##
  * 一般过程  
  cp conf/zoo_sample.cfg zoo.cfg  
  zkServer.sh start : 启动.  
  zkCli.sh -server 127.0.0.1:2181: 连接.  

## 命令 ##
  `ls /dubbo/cn.wy.mygit.api.intf.CollectionInputParam/providers`: 查看生产者. 即通过<dubbo:service> 注册的.  
  `ls /dubbo/cn.wy.mygit.wy.share.api.intf.score/consumers`: 查看消费者, 即通过<dubbo:reference>注册的, 不需要调用就可以查看. 类似如下:
  > consumer%3A%2F%2F10.11.241.161%2Fcn.wy.mygit.wy.share.api.intf.score%3Fapplication%3Dmyjava%26category%3Dconsumers%26check%3Dfalse%26dubbo%3D2.8.4%26interface%3Dcn.wy.mygit.wy.share.api.intf.score%26methods%3DgetscoreList%2CqueryScore%2Csavescore%2Cqueryscore%2CqueryMultiInd%26organization%3Ddubbox%26owner%3Dwy%26pid%3D2195%26reference.filter%3Dexceptionhandle%2Cdefault%26revision%3D1.1.1%26side%3Dconsumer%26timestamp%3D1512474027332%26version%3D1.0.wy_222  
   可以判断下哪些ip要消费哪些version的服务.  10.11.241.161 机器连的dubbo version 是 1.0.wy_222

## 杂项 ##
  * 客户端Curator  
  [Zookeeper客户端Curator使用详解](http://www.jianshu.com/p/70151fc0ef5d)  
