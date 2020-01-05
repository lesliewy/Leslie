# hadoop 环境安装.
 参考 https://www.jianshu.com/p/f209c4d013fb
  * docker build -f /Users/leslie/MyProjects/GitHub/Leslie/Docker/dockerfiles/centos/Dockerfile -t mycentos:v1 /Users/leslie/MyProjects/GitHub/Leslie/Docker/dockerfiles/centos:  生成镜像. 最后的参数指定Dockerfile所在目录，因为Dockerfile中有ADD 指令需要用到. 该context 会被发送到docker deamon。
    docker run -d -P --name hadoop_centos mycentos:v1 /usr/local/sbin/run.sh: 启动.

  * 下载hadoop 安装包.
    拷贝安装包
	docker cp hadoop-2.7.0.tar.gz hadoop_centos:/usr/local
	 进入容器
	docker exec -it hadoop_centos /bin/bash
	cd /usr/local/
	 解压安装包
	tar xvf hadoop-2.7.0.tar.gz
   * 伪分布式安装:
      vim /usr/local/hadoop-2.7.0/etc/hadoop/core-site.xml:
      https://www.jianshu.com/p/f209c4d013fb  按照这里操作. 
      start-dfs.sh ， 添加了:    
          HDFS_DATANODE_USER=root
		  HDFS_NAMENODE_USER=root
		  HDFS_SECONDARYNAMENODE_USER=root
	  start-yarn.sh, 添加了:
	      YARN_RESOURCEMANAGER_USER=root
		  YARN_NODEMANAGER_USER=root 
	  mapred-site.xml: 配置了
	      mapreduce.framework.name=yarn, yarn.app.mapreduce.am.env=HADOOP_MAPRED_HOME=${HADOOP_HOME}, mapreduce.map.env=HADOOP_MAPRED_HOME=${HADOOP_HOME}, mapreduce.reduce.env=HADOOP_MAPRED_HOME=${HADOOP_HOME};
	  yarn-site.xml: 配置了:
	      yarn.nodemanager.aux-services = mapreduce_shuffle, yarn.nodemanager.aux-services.mapreduce.shuffle.class=org.apache.hadoop.mapred.ShuffleHandler, yarn.nodemanager.vmem-check-enabled=false
	  以上是在参考之外添加的，否则hive执行时抛异常。
      hadoop namenode -format
      start-dfs.sh
      start-yarn.sh

# hive 环境安装
  > 必须先安装hadoop环境.
  * 下载hive 安装包, 同样cp 解压 配置:
      https://www.jianshu.com/p/f209c4d013fb
      修改了 hive-site.xml 中: hive.metastore.schema.verification   值改成了false.
  schematool -initSchema -dbType derby: 初始化数据库， 使用derby 作为元数据库.
  hive: 启动hive.
  
  * 使用mysql作为元数据库
    https://www.jianshu.com/p/f209c4d013fb
    启动mysql, 建database;
    修改hive-site.xml;
    schematool -initSchema -dbType mysql
    


