# hadoop 环境安装.
 参考 https://www.jianshu.com/p/f209c4d013fb
  * docker build -f /Users/leslie/MyProjects/GitHub/Leslie/Docker/dockerfiles/centos/Dockerfile -t mycentos:v1 /Users/leslie/MyProjects/GitHub/Leslie/Docker/dockerfiles/centos:  生成镜像. 最后的参数指定Dockerfile所在目录，因为Dockerfile中有ADD 指令需要用到. 该context 会被发送到docker deamon。
    docker run -d -P --name hadoop_centos mycentos:v1 /usr/local/sbin/run.sh: 启动.


    


