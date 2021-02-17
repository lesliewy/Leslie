## 网络
** dig, host, nslookup 这几个命令在 bind-utils 包中.
** DNS 解析的3种修改方法:
    https://www.cnblogs.com/zjhblogs/p/5938739.html
   正常情况下先走 /etc/hosts查找, 再走resolv.conf(centOS) 中的dns进行域名解析.
   配置了http_proxy, https_proxy 变量的话, 会直接走代理，不走/etc/hosts 和 resolv.conf
    


## 驱动 ##
USB设备:
lsusb: 查看usb设备情况.
usb-devices: 查看usb 设备情况，里面有当前设备使用的driver.
more /sys/kernel/debug/usb/devices:  显示的信息比usb-devices 稍多， usb-devices 就是从此处获取的。


PCI设备:
lspci
cat /proc/bus/pci/devices




lsmod: 查看内核加载的模块
modinfo: 查看具体模块信息
modprobe/insmod: 安装module
rmmod: 删除module.


* USB双模
我买的无线网卡+蓝牙的usb。 这个u盘实际上不能当做usb_storage来使用。 但是在linux上有时候上去之后当做普通存储了，就无法使用蓝牙和wifi了.
https://blog.csdn.net/bingo1991/article/details/80633000  参考这篇文章来解决， 使用了linux中的 usb_switch 来自动切换。
涉及到:
        /lib/udev/rules.d/40-usb_modeswitch.rules    udev的规则文件，如果设备ID（制造商/产品）被识别就启动usb_modeswitch
        /usr/share/usb_modeswitch/configPack.tar.gz -  切换设置信息文件
      /etc/usb_modeswitch.d - 该文件夹包含了针对每一个设备的独立的设置信息文件，用设备的ID来命名，如果您的设备ID出现在文件名字中，那么即使型号不同也有机会正常工作


# 开机启动 #
   * ubuntu 18.04 中输入: gnome-session-properties, 打开开机启动软件, 在其中设置.


## 配置
   sysctl -a  列出所有. centos
   sudo sysctl -w net.ipv4.ip_forward=1  修改配置.  这个ip_forward好像不用重启. centos
