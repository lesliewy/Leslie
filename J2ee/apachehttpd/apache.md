## 安装
  * apache httpd 源码安装  
  依赖于apr, apr-util, 需要先下载安装.  
  `./configure --prefix=/usr/local/apr && make && make install;`  
  `./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr && make && make install`;  依赖于apr;  
  `./configure --prefix=/opt/apache-httpd --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util --enable-so && make && make install`: 依赖于 apr 和 apr-util  
  `apachectl start`: 启动, 打开 http://localhost 验证;  

  * mac 自带apache  
  修改 etc/apache2/httpd.conf: 将DocumentRoot修改为/Users/leslie/MyProjects/Hack  
  LoadModule php5_module libexec/apache2/libphp5.so: 支持php.  
  `sudo apachectl restart|start|stop`;  
  `ps -ef|grep httpd`: 来查看进程;  
  `lsof -nP -iTCP |grep pid`: 来查看端口.  

  [Mac下搭建lamp](https://blog.csdn.net/xiaoranzhizhu/article/details/70338489)  