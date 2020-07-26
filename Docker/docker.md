## 安装 
  参考[官方文档](https://docs.docker.com/)   
  我的Dockfile位置: GitHub/Leslie/Docker/dockerfiles   
  
  /etc/apt/sources.list.d/docker.list中添加:
  deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable
  sudo apt-get install docker-ce
  
  默认情况下, 需要使用sudo docker, 因为docker使用的socket 是root的:  sudo usermod -aG docker $USER  可解决.
  主要看 /var/run/docker.sock 的用户和组, 确保当前用户有docker.sock的权限.
  
  * centos  
    uname -a
    cat /etc/os-release
    安装docker:  https://docs.docker.com/install/linux/docker-ce/centos/  
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2  
    sudo yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo  
    sudo yum install docker-ce docker-ce-cli containerd.io  
    

## 常用命令
  * repo - image - container (个人理解)   
    repo 是docker hub 中的, 仓库中名称;
    image 是repo:tag 拉取到本地后的镜像, 静态的;
    container 是启动后的image, docker ps 中的, 动态的;
    
  * docker ps -a --no-trunc: 输出完整的command.
    
  * docker build -t my_centos:v1 .   执行当前目录下的Dockerfile,  名字必须是Dockerfile,  大小写敏感; 执行后会生成一个新的image: my_centos, tag 为 v1
  * docker run -d -it my_centos:v1 /bin/bash:  对于centos镜像，需要加上-it, 否则刚启动就停止了.
    docker attach e4f32b517f12: 
    docker exec -it e4f32b517f12 /bin/bash: 这两种方式都可以进入centos的bash.  attach 方式进入再exit后容器停止了.
  * docker -f /path/Dockerfile .: 指定Dockerfile, 注意最后的参数是当前目录.
  
  * docker build  
    docker build -f /path/Dockerfile -t mycentos:v1 /path/buildcontext:  生成镜像.  
    最后的参数指定build context，因为Dockerfile中有ADD 指令需要用到. 该context 会被发送到docker deamon, 所以通常是空目录或者少量文件的目录.  
  
  * docker inspect mysql|grep -i IP:  查找指定容器的ip信息. inspect 可以看到容器的底层信息.
  
  * docker commit `docker ps -q` mycentos:v1  : 将指定docker保存为新的image. 容器内部的修改仍然保持在images中，如果docker start 仍然保持, 不过 docker rm 就没有了, 除非commit 
     
  
  * docker stop `docker ps -q`: 停止所有正在运行的容器;
    docker stop `docker ps -aqf name=hive`: 
    docker rm `docker ps -aqf name=hive`:  
    docker exec -it `docker ps -q -f name=hive` bash:  filter string 方式查找.
    docker stop `docker ps -aqf name=hive` && docker rm `docker ps -aqf name=hive`  : 使用 && 同时执行  
  * docker rm `docker ps -aq`: 删除所有容器;  ***如果没有commit, 之前的修改会丢失.***
  * docker rmi mycentos:v1  : 删除image
  
  * unable to delete 05c96df2d5c2 (must be forced) - image is referenced in multiple repositories  
    同一个image 可能被多个repo引用, 此时无法使用docker rmi {imageid}来删除. docker tag 来修改repo name时会出现这种情况;
    docker rmi lesliewy/hadoop_centos:v1  : 先rmi repo 来untag，然后再rmi {imageid} 即可.
  
  * save  
    docker save -o /data/testimage.tar testimage:latest   将 testimage:latest 导出到本机 /data/ 目录下.
    docker rmi testimage:  删除docker 中镜像。  有些image太大，不用的时候可以备份到u盘中.
    docker load < /data/testimage.tar   导入image。  
    docker load -i bond-web.tar:  导入image
    
  * diff  
    docker diff container: 文件系统上有哪些改变。  
  
  * docker network:  网络相关.
  
  * tag  
    docker tag mycentos:v1 hadoop_centos:v1   : 修改image名称. 将mycentos:v1 修改成 hadoop_centos:v1
    
  * search
    docker search federatedai   查看docker hub中有相关的images.
    https://registry.hub.docker.com/v2/repositories/federatedai/fateboard/tags  
    https://registry.hub.docker.com/v1/repositories/redis/tags   通过url查看仓库中镜像的tags,  有可能没有latest;   有的image用v2的url能查，有的用v1的url. 注意
    最后tags后面没有"/".
  
  * push/pull  
    docker push lesliewy/mycentos:v0  : image命名要符合规范 dockerid/imagename;  执行push前需要docker login
     
  * compose
    docker-compose -f docker-compose.yaml up -d myweb: 启动 myweb服务. -d 后台启动.
  
## 常用容器
  ### mysql  
    lsimgtag.sh mysql: 列出所有tags
    docker pull mysql:8.0.4:  拉取镜像.
    sudo docker run -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:8.0.4 : 启动容器.MYSQL_ROOT_PASSWORD指定root的登录密码.   -d 指定镜像名.
    sudo docker run -p 3306:3306 --name mysql \
  	-v /usr/local/docker/mysql/conf:/etc/mysql \
  	-v /usr/local/docker/mysql/logs:/var/log/mysql \
	-v /usr/local/docker/mysql/data:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=123456 \
	-d mysql:5.7
	-v：主机和容器的目录映射关系，":"前为主机目录，之后为容器目录
	两种方式登录: 
    sudo docker exec -it mysql bash  
    mysql -uroot -p123456: 进入docker, 先进入容器, 连接mysql  等价于: docker exec -it mysql mysql -uroot -p123456
    mysql -u root -p -h 127.0.0.1 -P 3306:  直接在主机中登录.

  ### centos
    yum list docker-ce --showduplicates: 查看所有历史版本  
    yum deplist docker-ce-3:18.09.0-3.el7:  查看某个版本的package的依赖. docker-ce 是包名. 3:18.09.0-3.el7是版本号.  
    
    docker run -tdi --privileged centos:7 init: 不加 privileged   init  进入后, centos 没有启动systemctl.  
    sudo docker run --privileged --cap-add SYS_ADMIN -e container=docker -it --name my_centos  -d --restart=always centos:7 /usr/sbin/init
    
  ### hadoop  
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
    
  ### hive 安装
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
    
  ### redis
      docker pull redis:latest
      docker run -p 6379:6379 --name redis -d redis:latest
      两种方式连接redis:  
          宿主机: redis-cli -h localhost -p 6379
          容器: docker exec -it redis /bin/bash;  redis-cli;    
  
  ### kafka
      GitHub/Leslie/Docker/dockerfiles/kafka  
      
      tar -zxv -f jdk-8u221-linux-x64.tar.gz:  需要jdk.   .bashrc 中配置PATH: PATH=$PATH:/root/soft/jdk1.8.0_221/bin
      tar -xzf kafka_2.12-2.5.0.tgz:  kafka安装包.
      nohup bin/zookeeper-server-start.sh config/zookeeper.properties & > ~/zookeeper.log:  需要zookeeper, kafka安装包中自带.
      nohup bin/kafka-server-start.sh config/server.properties & > ~/kafka.log: 启动kafka
      
      
## 杂项  
  * 占用空间过大  
    docker system df -v: 详细查看空间使用情况.
    docker rmi $(docker images -q -f dangling=true):  删除悬挂镜像.  比如: 重复build同名的image, 前一个就会变成dangling状态.
    docker system prune:   
    docker system prune -a:  会删除所有container, image, 慎用;  
    docker volume ls:  查看本地卷，这个也是占用空间大户.
    docker 
    docker rm / docker rmi:  手动删除某些container, image, 看空间是否减少.  
    rm -rf /Users/leslie/Library/Containers/com.docker.docker/Data/*:  mac 上, 需要先退出docker, 清空一切;  
    
  * commit 、build 制作image区别  
    docker history image: 可以查看容器操作历史, docker 层级概念, 比较区别, 观察是否可以减小image大小.  
    docker history lesliewy/mycentos:v0 --no-trunc   
    docker commit 需要手动进入容器操作，以后就不知道怎么做出来的， Dockfile 方式清楚明白.   
    
  * 将centos中的docker容器配置成开机启动  
    1, 将docker配置成开机启动  
      systemctl enable docker  
      system is-enabled docker 检查;  
      systemctl disable docker 取消开机启动;  
      
    2, 将容器设置自动启动  
      docker run -d -p 9100:9100 --name node-exporter --restart=always prom/node-exporter:  启动参数中加 --restart=always  
      
  * docker -v 文件修改  
    -v 挂载的文件, 如果在本机用 vi 修改，会导致文件 inode 发生变化, docker 里的文件会出现读写异常;  
    cat nginx2.conf > nginx.conf  : 这样就不会导致inode变化了.
    
  * docker 容器内访问宿主机端口
    http://host.docker.internal:8082/ok.htm
      
  * .bashrc or .bash_profile
    docker exec -it 登录环境时，生效的是.bashrc, 而不是.bash_profile. 需要将环境变量配置在.bashrc中.  PATH=$PATH:/root/soft/jdk1.8.0_221/bin  前面要有$PATH.

  * 使用greys
    需要将greys安装包cp 到docker中, 然后使用. jps -l 找到jvm pid.
