# 将kafka 安装到centos
# docker build -f /Users/leslie/MyProjects/GitHub/Leslie/Docker/dockerfiles/kafka/Dockerfile -t lesliewy/kafka:v0 /Users/leslie/Software/PS_ProgrammingSoft/Docker/kafka
# docker run --privileged --name kafka -it -d lesliewy/kafka:v0 /usr/sbin/init
# docker exec -it `docker ps -qf name=kafka` bash

FROM centos:7
LABEL maintainer=wy

# 本地软件: kafka 安装包, jdk
COPY * /root/soft/


