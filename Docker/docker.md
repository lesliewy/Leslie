* 安装 
  /etc/apt/sources.list.d/docker.list中添加:
  deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable
  sudo apt-get install docker-ce

* docker build -t my_centos:v1 .   执行当前目录下的Dockerfile,  名字必须是Dockerfile,  大小写敏感; 执行后会生成一个新的image: my_centos, tag 为 v1
* docker run -d -it my_centos:v1 /bin/bash:  对于centos镜像，需要加上-it, 否则刚启动就停止了.
  docker attach e4f32b517f12: 
  docker exec -it e4f32b517f12 /bin/bash: 这两种方式都可以进入centos的bash.  attach 方式进入再exit后容器停止了.
* docker -f /path/Dockerfile .: 指定Dockerfile, 注意最后的参数是当前目录.

* docker build -f /Users/leslie/MyProjects/GitHub/Leslie/Docker/dockerfiles/centos/Dockerfile -t mycentos:v1 /Users/leslie/MyProjects/GitHub/Leslie/Docker/dockerfiles/centos:  生成镜像. 最后的参数指定Dockerfile所在目录，因为Dockerfile中有ADD 指令需要用到. 该context 会被发送到docker deamon。

* docker inspect mysql|grep -i IP:  查找指定容器的ip信息. inspect 可以看到容器的底层信息.

* docker commit `docker ps -q` mycentos:v1  : 将指定docker保存为新的image.

* docker stop `docker ps -q`: 停止所有正在运行的容器;
* docker rm `docker ps -aq`: 删除所有容器;

* docker network:  网络相关.

* mysql
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
  sudo docker exec -it mysql bash
  mysql -uroot -p123456: 进入docker, 连接mysql

