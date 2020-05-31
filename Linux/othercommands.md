## 账户 ##
  * 启用root账户  
    在 Ubuntu 中， 传统 UNIX 'root' 被屏蔽了 (也就是 你不能使用 root 来登录).
    sudo passwd root,输入完密码后，su root,即可。  
    使用完后，最好再将其屏蔽: sudo passwd -l root (/etc/shadow 中该用户密码前加了一个'!',去掉则解锁).  
    有时报leslie的密码错误，也可能 是leslie帐户被屏蔽了。sudo passwd leslie 可以一试  
    发现 不管 是否屏蔽，使用sudo su root 都可以使用root帐户.  

  * 密码修改  
    `sudo passwd -l root`: /etc/shadow 中该用户密码前加了一个'!',去掉则解锁.  
    `sudo passwd -u root`: 为root用户解锁.  

  * 用户、组  
    /etc/group文件包含所有组  
    /etc/shadow和/etc/passwd系统存在的所有用户名 
    `groups`: 查看当前登录用户的组内成员  
    `groups gliethttp`: 查看gliethttp用户所在的组,以及组内成员  
    `whoami`: 查看当前登录用户名  
    
    `groupadd oinstall`: 添加组oinstall  
    `groupadd -g 4321 test1`: 添加组test1，并指定gid为4321.  

    `useradd -g test1 -m user4`: 添加用户user4,指明其initial group为 test1,同时为起新建home 目录。  
    `useradd -G test1,test2 -g test2 user3`: 添加用户 user3,指明所属组为test1、test2,同时指明用户的initial  group。
       如果只有-G,没有-g，则默认用户的initial group为用户同名的组.

     `usermod -a -G oinstall,leslie leslie`: -a 为追加,将oinstall、leslie两个组追加到用户leslie的所属组列表中。-a只能与-G连用。  
     `usermod -g oinstall leslie`: 将已存在用户leslie 加入已存在组oinstall中。注意，此时leslie只属于oinstall一个组了。 另外-g命令指明了用户leslie的primary group 是oinstall,当建立文件／目录时显示的那个组。  
     `usermod -G test1,test2 -g test1 user3`: 修改用户的primary group 为test1,同时保留原来所属的组test1、test2。  

     `groupdel test1`: 删除组test1,前提是没有任何一个用户的primary group 是test1.  
     `userdel -r test1`: 删除用户user1,同时删除和其相关的目录.  

  * su 变更使用者身份  
    `su -`  or `su -l` : 加了这个参数之后，就好像是重新登陆为该使用者一样，大部分环境变量（例如HOME、SHELL和USER等）都是以该使用者（USER）为主，并且工作目录也会改变。如果没有指定USER，缺省情况是root。如果用 su user: 则工作目录(pwd)仍没有变，且有权限限制.  

## 硬件挂载 ##
  * U 盘  
    插入U盘后，先用 `fdisk -l` 查看 U 盘挂在哪个位置(可能是/dev/sdb1)。然后我的U盘是fat32格式(vfat),  使用 `mount -t vfat /dev/sdb1 /mnt/usb` ，当然要先在 `mkdir usb` 目录。
    /mnt/ 目录一般是挂载的目录。但是在Ubuntu9.10中，好像可以直接进入：cd /media/LESLIE_WY, 不用mount,卸载时用： `umount /media/LESLIE_WY`，桌面上消失图标即已卸载。  

  * 硬盘  
    在我的ubuntu中，挂载vista中的某个分区。 `mount -t ntfs /dev/sda1 /mnt/usb`
    卸载都是 umount /mnt/usb  

## 文件管理 ##
  * 修改文件权限  
    `chmod -R a+r admin`: -R 表示admin目录下的所有目录和文件; a+r :表示给所有人增加读权限，也可以是g+rwx、u+rw (owner)、o+rw (other)等等。可以用755等代替.  
  >
     文件：
          r--: 只读权限，可以看不可以写
          -wx: 不可以读，更不用说写了.
     目录：
          rw-: 无法进入目录，更不用说查看、创建了; 但是由于具有w权限，可以删除该目录,但不可以cp文件
          --x: 可以进入目录，但什么都不能做，包括ls
          r-x: 可以进入目录，可以看(ls); 对于目录中已存在的文件，看文件的权限；不可一创建新文件.
          -wx: 可以进入目录, 对于已存在的文件不可以查看(ls),但是如果知道文件名且该文件权限允许，则可以,也可以删除； 可以新增文件,但是也不可以ls;
    r: 文件: 可以打开，但是只可读，不可写；        目录： 无法进入。
    x: 文件：无法打开                          目录： 可以进入，但是无法作任何操作，比r好些。
    w: 文件：无法打开                          目录： 无法进入
    rx: 文件：可以打开，但是只可读,不可写；         目录： 可以进入，也可以显示文件
    rw: 文件：可以打开，也可以修改.               目录： 无法进入
    wx: 文件：无法打开。                            目录： 可以进入，但是无法作任何操作。
    综上，对于文件： r :只负责打开                w:只负责写操作                  x: 对于非可执行文件没有意义
         对于目录：  r :只负责显示目录中文件      w:该目录下可以创建、删除文件、目录. x: 只负责进入目录
    删除某个文件的权限,不是看操作员对文件有什么权限，而是该操作员对该目录有什么权限,即使该文件权限为 ----------,仍可能被删除.
  >
    另外，如果umask 000:   
             新建文件: 权限为 -rw-rw-rw-   没有x权限.
             新建目录: 权限为 drwxrwxrwx   
     一般设置umask 为 022: 其他人没有写的权限.
    chmod 不会去修改symbol link文件的属性,因为symbolic link文件的属性从来都不会用到.
 
  * 修改文件所有者  
    `sudo chown -R leslie:oinstall admin`: -R 表示admin目录下的所有目录和文件；“:oinstall"也可以不加，表示只修改所有者，不修改组，加上则两者都修改。  
        一般只有root具有该权限，普通用户没有.  
    `chgrp dba 1.txt`: 将1.txt的所属组修改为dba,前提是组dba需要存在/etc/group中. 可以先用: `groups leslie`  查看leslie用户所属的组.  
    `chmod o+w-r 1.txt`: 将1.txt的权限中其他人可以访问权限中添加w权限，去掉r权限.  
    `chattr +a 1.txt`: 设置隐藏属性，只能append,不能删除，不能修改属性,但是可以touch修改时间.  
    `chattr +i 1.txt`: 设置i属性,该属性将使文件不能删除，也不能增加,也不能修改.  
    `chattr -i  1.txt`
    `lsattr 1.txt`  

  * 查看文件大小  
    `du -m` or `du -k`: 如果是目录的话，则显示目录下所有的文件，包括子目录中的文件 。  
    `du -sm`: 如果是目录的话，则只显示该目录内所有文件和子目录的总大小。  
    `du -sk ./*|sort -rn`: 对当前目录中的文件按文件大小排序，大的在前，其中文件的大小统一用kb为单位  
    `du -sk ./*|sort -rn|head`: 同上，但是只显示前10个文件. 其中 head 可修改为 head -n 23  即可查看前23个文件.  
    `du -sk ./*|sort -rn|tail`: 同上，但是只显示后10个文件。其中 tail 可修改为 tail -n 17 即可查看后17个文件.  

  * 文件的时间  
    `touch -m wy.txt`: 修改wy.txt的修改时间(ls -l时所显示的)为当前系统时间  
    `touch -m -d "2008-05-12 14:28" et.txt`: 修改eq.txt的修改时间为 2008-05-12 14:28 
    vi 保存 、touch: access time  modify time  Change time(status) 都被修改为当前时间.  
    `cat a.txt`: 只有access time 被修改为当前时间  
    `chmod`: 只有change time 被修改为当前时间。 

  * 查看文件信息  
    `stat file`: 查看文件各种信息  
    `cat -n file`: 显示行号  
    `cat -A file`: 显示文件行尾($)、TAB(^I）,用于查看一些非打印字符.  
    `less` 与 `more`: more 只能向下翻(ctrl + d ,Enter,Space), 而less既能向下翻也能向上翻(ctrl+d,ctrl+u,Enter,Space,方向键)  
    `ls -h`: 文件大小是human-readable的.  
    `ls -F`: 文件或目录末尾添加 /* 等标识符.  
    `ls -X`: sort alphabetically by entry extension  以entry的扩展名排序.  
    `ls -S`: sorted by file size  

  * 压缩与解压缩  
    `tar -cv -f a.tar *.txt`: 将所有的txt文件，打包到a.tar中，原文件不会删除.  
    `tar -xv -f a.tar`: 将a.tar中的所有文件解压到当前目录.切记，同名文件会覆盖，且没有提示.  
    `tar -kxv -f a.tar`: 将解压a.tar,keep old files,不覆盖已经存在的.  
    `tar -xv -f 100504.tar -C 100504`: 将100504.tar中内容解压到100504目录下,前提是100504目录必须存在.  
    `tar -rv -f a.tar *.txt`: 将当前目录下的txt文件追加到a.tar中，如果重名,也不会覆盖.与-u相同.  
    `tar -uv -f a.tar 1.txt`: 如果a.tar中不存在或者1.txt比a.tar中的1.txt更新，则更新，此时tar -tvf 会看到两个1.txt,但是tar -xvf a.tar 只会保留最新的1.txt.  
    `tar --delete -f a.tar 1.txt`: 从a.tar中删除1.txt. -f 后面接archive file.  
    `tar -cvP -f a.tar /home/leslie/2/`: 将/home/leslie/2/目录(包括下面的文件)按绝对路径打包, 后面要打包的文件或目录必须是绝对路径，且-P命令必须，否则默认是去掉前面的"/"的;同样，解压绝对路径的tar包时也要加-P,默认也是去掉前面的"/"进行解压到当前目录的。  
    `tar -xvP -f a.tar`: 将a.tar中的文件按绝对路径解压，同名文件会被覆盖。前提是a.tar必须是按绝对路径打包的,可以tar -tvf a.tar 查看.  
    `tar -hcv -f a.tar a`: 不加h，对于link文件将直接备份；加h,对于link文件将备份源文件.  
    `tar -jcv -f a.tar.bz2 *`: 将当前目录下所有文件(包括目录)打包并用bzip2压缩到文件.a.tar.bz2中,此时如果 bzip2 a.tar.bz2 出来的是a.tar.  
    `tar -jtv -f a.tar.bz2`: 查看a.tar.bz2 中的文件.  
    `tar -jxv -f a.tar.bz2 -C a`: 将a.tar.bz2 中的所有文件解压至a目录.  最好不要把-C 放在最后，使用tar -z -xv -C /home/mktdev/ -f sit_ver.tar.gz ejbs/newweb 这样最好.  
     以上的j换成z                            : 使用gzip压缩，最好将-f单独写，否则会报错.  

    `bzip2 -c a.txt > a.txt.bz2`: 将a.txt压缩为a.txt.bz2,同时保留原文件.gzip 与此相同，这两个命令一般只用在一个文件中.  
    `bzip2 -d essential-20061022.tar.bz2`: 解压essential-20061022.tar.bz2为tar文件.  

    `cpio -i <initrd.img-2.6.31-16-generic`: 其中file initrd.img-2.6.31-16-generic显示他是ASCII cpio archive,所以可以用cpio还原.  

  * 查找文件find  
    `find . -iname "startweblogic.sh"`: 忽略文件名的大小写. 得出的文件路径是相对路径。如果使用 `find /home/leslie -iname "a*"` 则得出的是绝对路径.  
    `find . -iname *.html|xargs grep -lir "幻读"`: 所有html文件中包含幻读的.
    `find . -iname *.html -exec grep -lir "幻读" {} \;`: 同上，但是可以处理文件名中包含空格的情况.

  * 创建目录 删除目录  
    `mkdir -p a/b/c`: 创建目录，a,a中创建b,b中创建c,并且即使存在也不报错.  
    `mkdir -m 700 a`: 创建目录a,并且赋权限700.  
    
    `rm -rf`: 强制删除文件夹，不互动提示 。 和 `rm -R` 的效果等同。同样，要复制目录需要用`cp -r` or `cp -rf`  
    `rm 2_lnk`: unlink 2_lnk这个symbolic link目录.此时rm命令等同于unlink  

  * 复制 移动 文件比对  
    `cp a.out a`: 如果a.out的owner:group分别是 owner1:group1; 而此时操作cp的用户是owner2:group2,那么复制后的文件是owner2:group2，能够复制的前提条件是具有r的权限就可以了;复制的时间也被改变了.  
    `cp -p a.out a: 保持复制后的a.out的timestamp不变,文件的所有者和组都会保持不变.  
    `cp -ai a.out a`: 保持复制后的a.out的timestamp不变，如果a目录中存在a.out,在覆盖前会提示. -a 即 --preserve=all,包括mode ownership timestamp.  
    `cp --preserve=ownership a.out a`: 保持原来的ownership(owner和group).  

    `diff 1.txt 2.txt`: 比对1.txt 和 2.txt内容.  
      >
        2c2                                  : 第2行改变了.
        < 143                                : 左边(1.txt)第2行的内容.
        ---
        > 123                                : 右边(2.txt)第2行的内容.
        4a5                                  : 左边比右边少了1行
        > 456                                : 右边(2.txt)第5行的内容，左边没有
        7d5                                  : 右边比左边少了一行.
        < bbb                                : 左边(1.txt)第7行的内容,右边没有.
    另： 由于diff是行比较的，所以相似度不高的文本文件最好不要比较.

  * 链接  
    `ln 2 3`: 此为hard link,3连接到2(target); hard link 只支持文件的连接，不支持目录连接.
    `ln -s 2 3`: 此为symbos link.  

  * 文件编码  
    `iconv -f CP936 -t utf-8 1.txt -o 2.txt`: 将原来的windows下的cp936编码转为utf-8编码，否则在linux下如果软件不知道cp936，会造成乱码. 如果要查看编码,可以在vim中用set fileencoding, 如果安装了enca，也可以用.  
    `iconv -l`: 列出iconv支持的所有编码.  

## 系统管理 ##
  * env:查看环境变量  
  *  在~/.bashrc 文件中可以定义别名，`alias cdl='cd /home/leslie/leslie/'` 注意cdl和等于号之间不能有空格.  
  * `jobs -l`: 列出目前在后台的job,包括pid  
    `fg %2`: 将后台job number 为2的jobs调至前台,'％' 不是必须的，但是最好加上,为了与 kill jobs 保持一致.  
    `fg +` or `fg -`: + - 分别代表最近一次／倒数第二次被放入后台的job，将其调至前台.  
    `bg %2`: 将2号job状态变为running.  
    `kill -15 %2`: 正常结束掉2号job, 注意,'%'是必须要的.  

    `ps -l`: 仅列出与当前 bash 相关的. 
       >  
         其中S那列代表状态:
         R - Running  S - Sleep  T - Stop   Z - Zombie
         TTY 表示登录终端.tty1 - tt6 是本机上登录的,pts/0 等表示由网络连接进终端的.

    `ps aux` or `ps -ef`: 这两个应该是等价的，都会列出所有的process.但是ps aux会多显示一些:%CPU %MEM VSZ(虚拟内存KB) RSS(占用固定内存KB)  
    `pstree -Aup`: 列出所有process的树状结构，同时显示user 和 pid.  
 
    `top -d 2`: 每隔2妙刷新一次.  P:按%CPU降序 M:按%M降序 N:按PID降序   也可以用 '>' 和 '<' 键,注意 F 和 f 的使用.  
    `top -b -n 3 > top.txt`: 将2次top的内容定向到top.txt. 必须要使用-b选项，否则无法获取完整的内容.  

    `nice -n -13 command`: 开始执行command时用nice命令指定优先级.   PRI(NEW) = PRI(OLD) + nice    都是越小优先级越高.  
    `renice -13 PID`: 调整某个已经执行的process的优先级为7（20－13），下次如果renice -1 PID,则该pid的priority为19.  

    `dmsg | more`: 查看系统产生的信息，包括开机时一闪而过的那些.  

    `vmstat -s`: 列出内存相关信息.  
    `vmstat -d`: 列出硬盘相关信息.  
    `vmstat 2 3`: 每2秒刷新一次，共3次，不加3为无限次.  

    `mpstat -a 1 1`: 列出cpu的很多信息，包括中断次数,context switch次数等. 但是大部分不知道什么意思.  

    `iostat`: 查看io的很多详细信息，看不懂.  

    `sar`: 搜集系统信息.  

    `pmap -x 1743`: 查看某个进程的内存映射.  

    `strace -c ls`: 系统跟踪调用情况.  

    `fuser -uv 3.txt`: 查看使用3.txt文件的程序, 列出拥有进程的用户(-u),进程的详细信息(-v).  
    `fuser -ki 3.txt`: kill掉使用3.txt文件的程序,kill 掉之前会有提示.  
    `fuser -muv /proc`: 查看/proc目录下所有文件被process使用的情况。-m 同 -c, 应该是列出与/proc在同一挂载点上的所有进程信息.  
      由于 vi 操作的不是原文件,而是 .[filename].swp(可以用ls -a)查看，所以直接 `fuser -uv filename` 查不到vi的进程.
      此时可以: fuser -uv .[filename].swp    或者 `fuser filename的父目录`.
      AIX下没有lsof, 有fuser

    `lsof -u leslie`: list open files. 查询leslie用户下面程序打开的程序.  
    `lsof -u leslie -a +d ~/leslie/`: 查询leslie用户下面打开~/leslie/目录下的程序情况. -a : and  
    `lsof |grep deleted`: 用 rm 删除文件后，但是df -m 空间没有增加，原因是存在某个进程正在使用该文件。此命令可以查看哪些这种情况.  
                          是否删除文件是看该文件的inode结构中的引用计数。 只有引用计数为0才会删除文件。
                          比如，删除某些log文件后，空间没有释放, 应用进程仍然在使用.
    `lsof -p {pid}`: 查看某个进程打开的所有文件。
  
  * hcache
     安装: wget https://silenceshell-1255345740.cos.ap-shanghai.myqcloud.com/hcache   mv hcache /usr/local/bin  chmod a+x hcache;
     free -m;  or  vmstat -t 3;  中buffer/cache过高;
     1, 回收buffer/cache: sudo su;  echo 3 > /proc/sys/vm/drop_caches:表示清除pagecache和slab分配器中的缓存对象。
     2, 使用hcache.   hcache --top 3: 最大的3个文件；
        hcache -pid 12345
     
  * 设置hostname
    /etc/sysconfig/network 中添加一行: HOSTNAME=app2
    在/etc/hosts 中添加: 192.16.150.185 app2 这样就能找到主机.  
  
  * 设置时间  
    `date -s` 命令.
    root 权限作同步: ntpdate 210.72.145.44 (210.72.145.44(中国国家授时中心服务器IP地址))  

  * locale  
    `locale -a`: 查看目前机器上已经安装的locales. 如果 ssh ftp telnet 等连接到服务器上的locale 中LANG与本地的不一致，可能会显示乱码，需要在本地安装相应的字符集. `sudo locale-gen zh_CN.GB18030`. 产生字符集. 再在/etc/default/locale中设置即可,或者设置环境变量.  
      AIX系统的字符集名称和linux下面的可能不一样,使用该命令查看，export LANG=...;  
    `locale -m`: 查看系统支持的所有locales.  
     如果字符集设置不对，会出现乱码, 在linux上,export LANG=zh_CN.gb18030, 在AIX上:  export LANG=Zh_CN.GB18030 .  
     如果应用是部署在web 容器中,需要重启weblogic(可能重新部署也可以).  

  * stty  
    `stty -a`: 查看终端的所有设置情况.  
    `stty quit ^G`: 修改 quit 为 ctrl + g  
    `stty intr ^I`: 修改中断为ctrl + i  

  * 查找最耗时的thread  
    `ps -m -p 1743 -o tid,time`  或者 `ps -Lf -p 1743` 或者 `top -H -p 1743` 查找 pid=1743 下的所有thread, tid 列 = LWP 列, 可以查找到最耗时的thread.  
    `jstatck 1743 &> 1743.dat`: 得到1743进程的栈信息. 找到之前的thread. 可能需要16进制转换: `printf "%x\n", 23451`

  * 服务管理  
    [如何查看 Linux 中所有正在运行的服务](https://mp.weixin.qq.com/s?__biz=MjM5NjQ4MjYwMQ==&mid=2664611829&idx=1&sn=4084b7b06c8b87766941418756602e32&chksm=bdce84b38ab90da56215e270af0818fbe68ca2790d8620220c45f5945f3bf1fc2fcfbe8121d3&scene=0&key=98ef00339cfc89306acd4862740ce1c2dcb58b43d3f837b62b3706d4d9bce8400265d6058f0d3fb5c07f6445bcf2f9215cfad684cc67fa46964950b02672919ca88b326821ce9c76d360b411190fd427&ascene=0&uin=MjQ0NDE5OTIxOQ%3D%3D&devicetype=iMac+MacBookAir7%2C2+OSX+OSX+10.12.5+build(16F73)&version=12020810&nettype=WIFI&lang=zh_CN&fontScale=100&pass_ticket=Q9xqv1Q2QFNWCPJc3WGmhoc%2BduaPx6ltaih1erXhBtN0%2FIz02WC6rQNKsy5qPc6I)  
    不同的系统有不同的命令, 例如centos 可以用systemctl, MAC os 可以用 launchctl  
    `systemctl --type service`: 按照service 来查看.  
    
    chkconfig
       维护/etc/rc[0~6] d 文件夹的命令行工具
    
    service
       旧的服务管理。
    
    systemctl
       慢慢取代service, chkconfig.  负责控制systemd系统和服务管理器, Systemd目的是要取代Unix时代以来一直在使用的init系统.
       systemctl list-unit-files:  列出所有可用单元。
       systemctl list-units: 列出运行中的单元. 
       systemctl --failed: 列出所有失败的单元.
       systemctl list-unit-files --type=mount: 查看挂载点.
       systemctl list-unit-files --type=socket: 查看套接口.
       systemctl show mysqld:  查看服务的详细信息.
       
       systemctl status|start|stop|restart|reload| mysqld: 管理mysqld服务。
       systemctl enable|disable httpd:  激活、禁止服务.
       systemctl kill httpd: 杀死服务.
       
       /lib/systemd/system/keepalived.service: 由systemctl管理的服务必须提供该文件.
       /etc/keepalived/keepalived.conf:  默认情况下， systemctl 到/etc/{service-name}/ 找配置文件.
       /var/log/messages:  systemctl 的日志信息.    也可以用 journalctl -f  来观察.

## 网络 ##
  `netstat -anp|grep 7001`: 找出7001端口的pid，可以再根据 ps aux|grep pid :  得出该进程信息.  
  `ping -c 3 -s 2000 -M do www.baidu.com` : 可以修改传送的icmp封包的大小，来测定MTU最大值，其中-M do 不能少，表示传送DF（don't fragment)标志，不允许拆分.  
  `traceroute -w 1 -n -T www.baidu.com`: 利用TCP的方式来traceroute 到www.baidu.com 的每个node，响应时间限制为1s, 每个node测试3次。 默认 UDP方式.  
  `netstat -tulnp -c 3`: 列出当前正在监听(l)的协议是TCP(t)、UDP(u)的网络连接,包括pid, 并且3s自动更新一次.服务端口对应文件:/etc/services  
  `host www.baidu.com 58.20.127.170`: 利用dns server 58.20.127.170 来查出www.baidu.com对应的ip,如果不加dns server，则使用/etc/resolv.conf  
  `telnet 127.0.0.1 25`: 利用telnet连接到端口是25的服务.  如果不加port，表示登录主机.  
  `ifconfig ppp1 down`: 关闭ppp1连接。

  * tcpdump  
  `tcpdump -i eth0 port 25`: 监听eth0 上的25号端口.  
  `tcpdump -i eth0 port 25 -w a.cap`: 同上但是将结果导入到a.dat文件。  分析tcpdump导出的文件可以: tcpdump -r a.cap
      也可以用wireshark 打开a.cap来分析, 既简单又直观方便.    
  `tcpdump -i eth0 -nn -X 'port 25 and src host 127.0.0.1'`: 可以指定监听的expression,并且十六进制输出(X).    
  sudo tcpdump ip host 10.57.30.43 and ! \(10.57.211.23 or 10.57.31.26 \) : 监控10.57.30.43 与其他所有主机的通信, 除了10.57.211.23 和 10.57.31.26.  没有指定src和dst, 表示都监控.
  sudo tcpdump ip src host 10.57.30.43 and dst host ! \(10.57.211.23 or 10.57.31.26 or 10.57.31.163\):  监控所有src为10.57.30.43, dst 不为...的通信情况.


  * ssh & sftp  
    `ssh payopr@211.138.236.209 -p 3222`: ssh 连接同时指定端口为3222.  
    `sftp -oPort=3222 payopr@211.138.236.209`: sftp 连接,同时指定端口为3222.  
    + ssh隧道  
    [SSH隧道与端口转发及内网穿透](https://blog.csdn.net/zhaoyangkl2000/article/details/77961356)  
    `ssh -N -f -L 8069:10.57.9.23:8080 10.19.19.23 -l admin`:  本地转发.  本地执行. 本地访问: localhost:8069  相当于访问10.57.9.23:8080, 前提是本地可以登录跳转机器: 10.19.19.23, -l 指定用 admin 账号登录; 

  * aix 系统下查看占用某个端口的程序  
    `lsof -i |grep 33333`: 找到pid.   ps -ef |grep <pid>  
    `netstat -Aan|grep 33333`: 找到第一列的 addr 和第二列的addrType.  
    `rmsock <addr> <addrType>`: 如果第二列是tcp, addrType是tcpcb, udp 是inpcb.  
    `ps -ef |grep <pid>`
      
  * curl  
    curl http://www.google.com:   下载的是源码.
    curl www.likegeeks.com --output likegeeks.html:  保存为文件。
    curl -L www.likegeeks.com --output likegeeks.html: 支持重定向.
    curl -C - example.com/some-file.zip --output MyFile.zip: 断点续传.
    curl --connect-timeout 60 example.com:  指定连接超时时间(s) 
    curl -m 60 example.com: 指定命令执行总时间(s)
    curl -u username:password ftp://example.com:  指定用户名密码
    curl -x 192.168.1.1:8080 http://example.com:  代理.
    curl -s http://example.com --output index.html: 静默下载.
    curl -I example.com: 不获取body, 只获取header等信息。
    curl -H 'Connection: keep-alive' -H 'Accept-Charset: utf-8 ' http://example.com： 带上header
    curl -d 'name=geek&location=usa' http://example.com:  POST方式.
    curl -w "http: %{http}\ndns: %{dns}\nredirect: %{redirect}\ntime_connect: %{time_connect}\ntime_appconnect: %{time_appconnect}\ntime_pretransfer: %{time_pretransfer}\ntime_starttransfer: %{time_starttransfer}\nsize_download: %{size_download}\nspeed_download: %{speed_download}\n--------\ntime_total: %{time_total}\n" http://localhost:7181/home:
         使用curl来测试各种时间.
    curl -w @a.txt http://localhost:7181/home:  从文件读取， 其中a.txt中内容即上面的引号部分.
    
    
## 软件安装  ##
  * rpm 类型  
    `alien -iv rpm-file`: 在ubuntu 使用alien 来安装rpm软件.  
    `alien -i -c rpm-file`: -c 执行rpm中的脚本,如果没有-c，有些rpm会报错.  
    `rpm -ivh rpm-file`: red hat中可以用rpm命令来安装软件.  
    `rpm -qp --scripts rpm-file -q:query`: 一定要有-p表示读取rpm文件,而不是数据库.  
    `rpm -e --nodeps xorg-x11-drv-nvidia-390xx-cuda-libs-390.132-1.el7.x86_64: 卸载软件包.
    `rpm -ql man-pages-zh-CN-1.5.2-4.el7.noarch`: 查看package安装了哪些文件.  
    `rpm -qa | grep man`: 查看安装的packages中包含man的.  
    `rpm -qi man-pages-zh-CN-1.5.2-4.el7.noarch`: 查看包的安装时间等信息.

  * dpkg 类型  
    `dpkg -l |grep jdk`: 在ubuntu 中即使是rpm软件，也要用dpkg查询，因为alien 在安装时会将其转为debian类型的.  
    `ptitude show package-name` or `dpkg -s package-name`: 查看已安装的软件信息  

  * bin 类型  
    `chmod a+x filename.bin; ./filename.bin`: 直接运行即可, 一般解压完就可以用了, 执行bin文件，一般会解压成rpm或其他类型的文件. 例如: `./jdk-6u31-linux-i586.bin`

  * `tar -xv -f file.tar`: 例如 eclipse, 直接解压完就可以用了, ./eclipse; 类似于portable 软件;  

  * deb 文件  
    `sudo dpkg -i file.deb` 即可;

  * apt 来安装.

  * snap 来安装， 在ubuntu 18.04中刚发现的， 有些package在这里的版本更高些.

  * 源码  
    一般流程
      ./configure --prefix="install path"; make; make install; 最好是先看下 readme 之类的文件;  
      通过源码安装的，如果./configure时没有指定安装路径，一般在 /usr/local 目录下. find . -iname *keepalive*

## 其他命令 ##
  * bc: 可以进行 + - * / ^ % 计算.  
    在bc模式中：
    scale=3: 小数点后保留3位.  
  * . 1: 文件1具有r权限，即可执行文件1,之间有空格.  
    ./1: 文件1具有x权限，即可执行文件1  

  * `seq 1 255`: 输出 1－255之间的所有整数.  

  * `md5sum file_name`: 计算file_name的md5指纹(摘要)。  

  * `ps -ef|pbcopy`:  将内容复制到剪贴板。 可以直接使用系统的粘贴来使用.  也可以直接 pbpaste,  echo `pbpaste` 来使用.  

## 记录 ##
  * pwd: print name of current/working directory   显示当前的绝对路径，也可以加一个文件，用来显示该文件的绝对路径。  

  * 关于环境变量  
    1. 修改/etc/profile文件,所有用户都可以使用。  
      在profile文件末尾加入：JAVA_HOME=/usr/share/jdk1.5.0_05  
      export JAVA_HOME
      重新登录 or 执行profile文件.  

    2. 修改.bashrc文件  
    这种方法更为安全，它可以把使用这些环境变量的权限控制到用户级别，如果你需要给某个用户权限使用这些环境变量，你只需要修改其个人用户主目录下的.bashrc文件就可以了。  

    3. 直接在shell下设置变量
    不赞成使用这种方法，因为换个shell，你的设置就无效了，因此这种方法仅仅是临时使用，以后要使用的时候又要重新设置，比较麻烦.  
    如： export JAVA_HOME=/usr/share/jdk1.5.0_05, export 完可以直接使用该环境变量了.  

    环境变量说明:  linux下用冒号“:”来分隔路径;  
                export是把变量导出为全局变量;  
                大小写必须严格区分;  

## 常用软件 ##
  * imagemagick  
   Linux 下修图命令行  

  * sox  
   Linux 下音频神器.  

## USEFUL URLS ##
  * [Core utils](http://www.gnu.org/software/coreutils/coreutils.html)    
  * [Linux Kernel](https://www.kernel.org/)  
  * [shell变量命名规范](https://www.cnblogs.com/gentlemanhai/p/11835793.html)
  
