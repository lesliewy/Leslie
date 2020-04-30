# centos 基础镜像. 安装了部分软件. 
# docker build -f /Users/leslie/MyProjects/GitHub/Leslie/Docker/dockerfiles/centos/Dockerfile -t lesliewy/mycentos:v0 .
#      最后的. 标识的目录在"/Users/leslie/Software/PS_ProgrammingSoft/Docker/mycentos"
# docker run --privileged --name mycentos -it -d lesliewy/mycentos:v0 /usr/sbin/init
# docker exec -it `docker ps -qf name=mycentos` bash

#生成的新镜像以centos镜像为基础, FROM 会pull centos 镜像.  
# centos7时 uname -r 显示内核4.9, 但是rpm -qa|grep kernel 找到的确实3.10的 .
FROM centos:7
LABEL maintainer=wy

# 添加sysbench源, 只执行其中的核心，其他省略, 100M -> 0B
#RUN curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.rpm.sh | bash
RUN curl -sSf "https://packagecloud.io/install/repositories/akopytov/sysbench/config_file.repo?os=centos&dist=7&source=script" > /etc/yum.repos.d/akopytov_sysbench.repo
#安装openssh-server、client
# net-tools: 包含netstat等工具.
# pcre-devel, zlib-devel: nginx 需要.
# numactl: 观察NUMA情况.
RUN yum -y update && yum -y install \
openssh-server \
openssh-clients.x86_64 \
vim \
less \
wget \
java-1.8.0-openjdk.x86_64 \
gcc \
make \
sysstat \
sysbench \
perf \
dstat \
strace \
net-tools \
pcre-devel \
zlib-devel \
numactl

ENV JAVA_HOME=/etc/alternatives/jre_1.8.0
#将密钥文件复制到/etc/ssh/目录中。这里要用root的权限生成key
RUN mkdir -p /root/.ssh
#生成秘钥、公钥
RUN ssh-keygen -t rsa -b 2048 -P '' -f /root/.ssh/id_rsa
RUN cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
RUN cp /root/.ssh/id_rsa /etc/ssh/ssh_host_rsa_key
RUN cp /root/.ssh/id_rsa.pub /etc/ssh/ssh_host_rsa_key.pub

# 本地软件.
COPY * /root/soft/
WORKDIR /root/soft/
# 编译stress-ng
RUN mv stress-ng-0.10.15.tar.xz /opt
WORKDIR /opt/
RUN xz -d stress-ng-0.10.15.tar.xz && tar -xv -f stress-ng-0.10.15.tar
WORKDIR /opt/stress-ng-0.10.15
RUN make

#定义时区参数
ENV TZ=Asia/Shanghai
#设置时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo '$TZ' > /etc/timezone

#将ssh服务启动脚本复制到/usr/local/sbin目录中，并改变权限为755
ADD run.sh /usr/local/sbin/run.sh
RUN chmod 755 /usr/local/sbin/run.sh

#变更root密码为root
RUN echo "root:root"| chpasswd
#开放窗口的22端口
EXPOSE 22
#运行脚本，启动sshd服务
CMD ["/usr/local/sbin/run.sh"]

RUN echo "set -o vi" >> ~/.bashrc
RUN echo PATH=$PATH:/opt/stress-ng-0.10.15/ >> ~/.bashrc

