** ./configure --prefix=/opt/nginx; make; make install;

** nginx;  启动.  1024以下的port需要root用户,没有权限的话会报错: nginx: [emerg] bind() to 0.0.0.0:80 failed (13: Permission denied)
   nginx -c /path/to/nginx.conf: 启动nginx
   nginx -s quit: 有序停止.
   nginx -s stop: 立即停止.
   nginx -s reload: 重新载入配置文件.
   nginx -s reopen: 重启.
   nginx -t -c /path/to/nginx.conf: 检查配置是否正确.
   ps -ef | grep nginx: 找出pid.
   kill -QUIT 主进程号     ：从容停止Nginx
   kill -TERM 主进程号     ：快速停止Nginx
   pkill -9 nginx          ：强制停止Nginx
   kill -HUP 主进程号       ： 平滑重启nginx：