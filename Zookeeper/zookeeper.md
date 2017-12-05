*  cp conf/zoo_sample.cfg zoo.cfg
   zkServer.sh start : 启动.
   zkCli.sh -server 127.0.0.1:2181: 连接.

*  ls /dubbo/cn.fraudmetrix.creditcloud.bodyguard.api.intf.CollectionInputParam/providers: 查看生产者. 即通过<dubbo:service> 注册的.

*  ls /dubbo/cn.fraudmetrix.creditcloud.tigris.share.api.intf.IntentScoreInd/consumers: 查看消费者, 即通过<dubbo:reference>注册的, 不需要调用就可以查看. 类似如下:
consumer%3A%2F%2F10.57.241.161%2Fcn.fraudmetrix.creditcloud.tigris.share.api.intf.IntentScoreInd%3Fapplication%3Dbodyguard%26category%3Dconsumers%26check%3Dfalse%2
6dubbo%3D2.8.4%26interface%3Dcn.fraudmetrix.creditcloud.tigris.share.api.intf.IntentScoreInd%26methods%3DgetIntentPartnerList%2CqueryScore%2CsaveIntentPartner%2CqueryIntentPartne
r%2CqueryMultiInd%26organization%3Ddubbox%26owner%3Dfraudmetrix%26pid%3D2195%26reference.filter%3Dexceptionhandle%2Cdefault%26revision%3D1.1.1%26side%3Dconsumer%26timestamp%3D151
2474027332%26version%3D1.0.wy_222
   可以判断下哪些ip要消费哪些version的服务.

