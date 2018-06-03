## 配置 ##
  * 安装  
  ./configure --prefix=/opt/nginx; make; make install;

  * nginx.conf  
 -server_tokens off;  关闭服务器版本信息.  默认时 curl -I http://localhost 返回： Server: nginx/1.10.2  

## 命令 ##
  `nginx`  启动.  1024以下的port需要root用户,没有权限的话会报错: nginx: [emerg] bind() to 0.0.0.0:80 failed (13: Permission denied)  
  sudo nginx 会报错，command not found 通常使用sudo时最好使用绝对路径. 如果不使用绝对路径的话，只有某些路径里的命令才可以使用
  /etc/sudoers中  Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"  
  
  `nginx -c /path/to/nginx.conf`: 启动nginx  
  `nginx -s quit`: 有序停止.  
  `nginx -s stop`: 立即停止.  
  `nginx -s reload`: 重新载入配置文件.  
  `nginx -s reopen`: 重启.  
  `nginx -t -c /path/to/nginx.conf`: 检查配置是否正确.  
  `ps -ef | grep nginx`: 找出pid.  
  `kill -QUIT 主进程号`：从容停止Nginx  
  `kill -TERM 主进程号`：快速停止Nginx  
  `pkill -9 nginx`：强制停止Nginx  
  `kill -HUP 主进程号`: 平滑重启nginx   

## 杂项 ##
  * [apache/nginx访问日志中出现其他网站的GET记录](http://eyehere.net/2015/foreign-sites-in-log-with-200-code/)  
