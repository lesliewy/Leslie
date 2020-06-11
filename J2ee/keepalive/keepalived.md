### 文档
   * [https://www.keepalived.org/manpage.html](offical document)
   * 常用技术.doc

### 安装
   * 源码
    ./configure 检查是否缺少必需的包.
    make && make install: 安装. 默认安装在 /usr/local 下.   并且已添加好 /lib/systemd/system/keepalived.service, 可以使用systemctl管理.
    sudo cp /usr/local/etc/keepalived/keepalived.conf /etc/keepalived/     拷贝systemctl 需要的配置文件.
    sudo systemctl start keepalived:  启动.    日志在  /var/log/messages
           
### 配置.          
   * sudo tcpdump -n \(vrrp or arp\)   抓包分析.
