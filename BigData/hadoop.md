# hadoop 环境安装.
 参考 https://www.jianshu.com/p/f209c4d013fb
  *  docker run -d -P --name hadoop_centos mycentos:v1 /usr/local/sbin/run.sh: 启动.

  * start-dfs.sh: 启动 namenode, datanode, secondarynode, ps aux 里有.
    如果hdfs-site.xml 没有指定dfs.namenode.name.dir, dfs.datanode.data.dir 的值, 默认namenode, datanode 的数据放在 /tmp/hadoop-root/dfs/ 下.
    namenode 页面: http://localhost:9870
     
    start-yarn.sh: 启动nodemanager, resourcemanager.
    yarn web 页面: http://localhost:8088 


