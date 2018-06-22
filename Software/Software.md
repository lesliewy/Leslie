1,不知道怎么回事，输入用户名和密码后提示 : You account has expired ,please contact at your system administrator 
   可能是执行sudo passwd root ,passwd -l root等操作导致的。上网查看原因，有一种方法：
  a,编辑recovery mode,按e编辑
  b,选择第二层(含有kernel),按e进入编辑
  c,修改启动参数，将后面的 ro single 改为 rw single init=/bin/bash 退出
  d,按b启动。
  
   进入后网上说passwd leslie 另设密码即可了。问题是我的还是不可以。
  passwd -S 查看帐户状态很正常，但就是报: You account has expired ,please contact at your system administrator.
  
  deluser leslie 后，再adduser leslie还是不可以
  
  后来，我在/etc/sudoers文件中添加： leslie  ALL=(ALL) ALL ，再后来好像就可以了。

  我知道了报那个信息说明该帐号被lock了(passwd -l root,此为root的默认状态),可以通过passwd -a -S查看。解锁就可以了(passwd -u root).
 first: passwd root    to set a password for root ,then you can login as a root: su root. 

2, 9.10安装完成后，装了scim但是不显示中文？
  a, System -> Administration -> Language Support 的 install/remove Languages中安装简体中文，Key board input system: 选scim,再把scim-pinyin的软件包装好即可。

3,avi等文件的观看
  a)安装mplayer :sudo apt-get install mplayer-fonts mplayer mplayer-skins mozilla-mplaye.
  b)设置mplayer:在右键主菜单中 -> Preferences/属性 -> Video/视频，在”Available drivers/可用驱动”中选择”x11″或”xv”或"gl"，在同一窗口下半部份钩上”允许掉帧/Enable fra    me dropping”。
  c) 在 http://www.mplayerhq.hu/MPlayer/releases/codecs/上下载最新的w32codecs的tar.gz包解压缩后重命名为win32
     复制到/usr/lib上，假如之前存在win32文件夹请先备份sudo cp /usr/lib/win32 /usr/lib/win32-backup
     装完后假如mplayer不认帐，那么请sudo ln -s /usr/lib/codecs /usr/lib/win32
  d) mplayer的Codecs&demuxer中选择Win32/Vfw video codecs。
  用mplayer播放wmv文件
  http://www.mplayerhq.hu/design7/news.html
  http://www.mplayerhq.hu/design7/dload.html
  那个Binary Codec Packages就是w32codes了
  下载下来是essential-20061022.tar.bz2 的包解压之后 吧里面的 .dll .ax之类的所有文件放到
  安装
  /usr/lib/win32里面就可以了
 mplayer的preferences->video中选择第二个,同时不要勾选下面的 flip image upsite down.  但是播放avi文件时则需要选上.

  e) mplayer media player
     avi:    codecs&demuxer 中video codec family 选择Win32/VfW video codecs
                              Audio codec family 选择None.
             Video 中Available driver 选择 gl X11（OPENGL)，同时选中Enable framing dropping


4,完全无法进入系统，也无法输入ro single init=/bin/bash,此时系统里又有很多重要文件无法备份。针对wubi安装的系统
  a,用liveCD启动系统并进入
  b,cd /media 此时会显示ubuntu, cd 进入,找到root.disk,这是wubi安装的虚拟硬盘
  c,挂载 root.disk: mount -o loop root.disk /mnt/usb
  d,插入u盘，拷贝资料，直接cd /media/LESLIE_WY进入U盘即可。
  在以上安装过程中可能要修改/etc/sudoers.
 另： 如果没有了sudo的权限，导致无法修改sudoers文件，此时可以重启系统,使用rw single init=/bin/bash方法进入修改，它默认就是root登录.

6,Ubuntu 8.10系统启动时，需要设置显卡类型： F1进入BIOS设置，CONFIG->DISPLAY->DISCRETE CARD，但是到了9.10后不必再这样设置了。

7,关于环境变量
  设置环境变量：
  1)修改/etc/profile文件,所有用户都可以使用。
  2)修改.bashrc文件：  这种方法更为安全，它可以把使用这些环境变量的权限控制到用户级别，如果你需要给某个用户权限使用这些环境变量，你只需要修改其个人用户主目录下的.bashrc文件就可以了。
  3)直接在shell下设置变量:不赞成使用这种方法，因为换个shell，你的设置就无效了，因此这种方法仅仅是临时使用，以后要使用的时候又要重新设置，比较麻烦.

8,安装telnet
  当另一个用户要telnet到我的ubuntu上时，在我的机器上必须要先装上telnet.
  1)  sudo apt-get install xinetd telnetd
  2) 配置文件
    A /etc/inetd.conf
    liceven@liceven-laptop:~$ cat /etc/inetd.conf （如果存在就不需要了）
    telnet stream tcp nowait telnetd /usr/sbin/tcpd /usr/sbin/in.telnetd
    B. 修改/etc/xinetd.conf

    root@liceven-laptop:/etc# cat xinetd.conf
    # Simple configuration file for xinetd
    #
    # Some defaults, and include /etc/xinetd.d/

    defaults
    {

    # Please note that you need a log_type line to be able to use log_on_success
    # and log_on_failure. The default is the following :
    # log_type = SYSLOG daemon info(插入红色部分）
    instances = 60
    log_type = SYSLOG authpriv
    log_on_success = HOST PID
    log_on_failure = HOST
    cps = 25 30
    }

    includedir /etc/xinetd.d
    C。/etc/xinetd.d/telnet并加入以下内容：
    # default: on
    # description: The telnet server serves telnet sessions; it uses \
    # unencrypted username/password pairs for authentication.
    service telnet
    {
    disable = no
    flags = REUSE
    socket_type = stream
    wait = no
    user = root
    server = /usr/sbin/in.telnetd
    log_on_failure += USERID
    }  

   3). 重启机器或重启网络服务sudo /etc/init.d/xinetd restart
   4). 使用TELNET客户端远程登录；ifconfig -a显示本机地址； 

9,MyEclipse 8.0 安装
   1）执行/home/leslie/software/myeclipse-8.0.0-linux-gtk-x86/myeclipse-8-stable-installer: 双击打开或者./执行都可以.如果安装界面中鼠标单击不起作用，先选中再      按回车键。
   2) 安装时可能要修改文件属主： chown leslie:leslie: MyEclipse8.x    chown leslie:leslie Common
   3) 打开任何文件里面的中文显示都是乱码：project -> properties -> resource -> 将text file encoding 修改为GBK,可以直接输入.
   4) debug :
        F5  : step into  可以进入具体的方法.
        F6  : step over
        F7  : step return 可以直接返回目前正在执行的循环、方法.
        F8  : 执行完该次debug直至结束，不管后面的断点.
        F11 : 重新执行debug.

10,buntu系统中使用中国电信宽带(ADSL)连接设置方法：
1.系统->系统管理->网络
2.设置wired connection(有线连接),在connection settings中选择Automatic configuration(DHCP)
3.DNS中设置好可用的DNS
4.将配置保存一份
5.在终端中输入sudo pppoeconf，根据提示进行设置,基本就是输入ISP名称以及帐户和密码,所有设置项选择YES就可以了
附：相关命令
sudo pppoeconf 配置pppoeconf
sudo pon dsl-provider :  打开一个连接，有时拔掉网线后需要再重新连接,此时原来的连接还在.
sudo poff 关闭连接
ifconfig ppp0
plog


*  使用有线网络且dhcp方式时：wired network 中报device not managed:
   vi /etc/NetworkManager/nm-system-settings.conf  将其中的managed=false 修改为 true.   sudo service network-manager restart

11,vim 插件
  11.1  vim+ctags+taglist
   需要先安装ctags,package: exuberant-ctags
   如果装完ctags后，helptags不起作用,则可能需要重新安装vim，ubuntu自带的不能用. sudo apt-get install vim
   将下载的zip包放入~/.vim/下再解压，如果在别处解压再移动到该目录，则使用:TlistToggle时会报 not an editor command 错误.
*  Vim 的多字符编码方式支持的工作方式:
      1. Vim 启动，根据 .vimrc 中设置的 encoding 的值来设置 buffer、菜单文本、消息文的字符编码方式。
         * encoding只能设置一项,发现如果没有设置encoding，vim会逐个匹配,所以我觉得最好不要设置这个变量,如果定死的话，反而不好.
      2. 读取需要编辑的文件，根据 fileencodings 中列出的字符编码方式逐一探测该文件编码方式。并设置 fileencoding 为探测到的，看起来是正确的 (注1) 字符编码方式
      3. 对比 fileencoding 和 encoding 的值，若不同则调用 iconv 将文件内容转换为 encoding 所描述的字符编码方式，并且把转换后的内容放到为此文件开辟的 buffer 里，此时我们就可以开始编辑这个文件了。注意，完成这一步动作需要调用外部的 iconv.dll (注2)，你需要保证这个文件存在于 $VIMRUNTIME 或者其他列在 PATH 环境变量中的目录里。
      4. 编辑完成后保存文件时，再次对比 fileencoding 和 encoding 的值。若不同，再次调用 iconv 将即将保存的 buffer 中的文本转换为 fileencoding 所描述的字符编码方式，并保存到指定的文件中。同样，这需要调用 iconv.dll
      可以在.vimrc中添加,该文件相当于.bashrc,会被执行:
      let &termencoding=&encoding
      set fileencodings=utf-8,gbk,ucs-bom,cp936
      如果文件包含中文,encoding最好使用gbk(cp936),gb2312, 用utf-8,unicode有些中文显示不出来.
      如果文件是unix格式: 如果encoding是gbk(cp936),gb2312,这个时候不管fileencoding是什么,都可以正确显示中文.
      如果文件是u8格式: 发现再怎么转换中文都是乱码.
      如果在vim中set fileencoding 或者 set encoding ,需要 e! 来刷新,才能正确显示中文.

      Windows 里 cp936，也就是 GBK 的代码页, latin-1 表示在fileencodings中没有找到合适的编码，所以使用latin-1(ASCII)，再转为encoding(一般为utf-8)通常会出现乱码.

12,关于man手册
  12.1 
     Linux的man手册共有以下几个章节：
     1、Standard commands （标准命令）
     2、System calls （系统调用）
     3、Library functions （库函数）
     4、Special devices （设备说明）
     5、File formats （文件格式）
     6、Games and toys （游戏和娱乐）
     7、Miscellaneous （杂项）
     8、Administrative Commands （管理员命令）
  12.2 在man手册中添加库函数
       buntu默认是没有安装c语言的库函数man手册的，所以在man perror 和sendto之类的函数时会显示没有相关文档的问题.解决方法:
         sudo apt-get install manpages-dev
         man 3 sleep            : 查询第三章节的关于sleep的介绍. c的库函数一般在第三章节.如果不指定，则先查询标准命令. 

13 删除程序
   a,删除eclipse
	1. 关闭Eclipse
 	2. 将eclipse安装目录删掉   -- 一般先用whereis 命令查看 bin source man page目录，删除这些目录。
	3. 删除~/.eclipse目录
	4. 删除~/.mozilla/eclipse目录
     但是application -> eclipse 菜单仍然存在，不知道怎么删除。

14 krusader
   a,安装: sudo apt-get install krusader

*  ssh
   1, sudo apt-get install openssh-server          : 为了提供ssh功能，服务器端需要安装相应的软件.会自动启动ssh ,同时也启动了sftp.
      ssh leslie@127.0.0.1                         : client 将远端服务器的指纹码存于~/.ssh/known.host中.  服务器的ssh配置在:/etc/ssh/
      sudo /etc/init.d/ssh stop                    : 关闭服务器的ssh服务. 
      sudo /etc/init.d/ssh start                   : 启动服务器的ssh服务
*  hexedit
   sudo apt-get install hexedit                    : hexedit 是十六进制、二进制编辑工具。
   hexedit a.class                                 : 编辑class文件,修改class的第8个字节，可以修改class version,如果是jdk1.6编译的一般是48(30),50(32),由于有的jad反编译只支持45,47等，可以修改此处来执行jad. 注意：修改后编译的可能有误.    F1 查看ubuntu帮助，搜索hexedit即可查看hexedit帮助.

*** sudoers
  * sudo vi /etc/sudoers     :  可以配置哪个用户具有什么执行权限.如：  leslie  ALL=(mktdev) ALL  如果某个程序是mktdev的，则可以sudo 来执行,或者使用
                                sudo -u mktdev vi a.txt
    sudoers 有其自己的语法.
    只要使用sudo ，就可以在/var/log/auth.log中查看到日志记录,具体路径可以在/etc/syslog.conf中进行配置.
=========================================License===========================================================
1,myeclipse 8.5:
name:lk
Serial:yLR8ZC-855555-685979500969430

snavigator


## Intellij Idea ##
  * Help -> Find Action: 查找各种有用的功能，不必记住快捷键.
    F3: 代码视图中将该行加入bookmark.    # + F3: 查看.   大项目便于记录.
    # + Shift + .:  折叠代码行;   # + .: 取消折叠;
    # + Shift + F7: 查找当前选中的字符串并高亮.  # + G, # + Shift + G 来前后查找.

## jprofiler ##
  * 文档  
    [深入浅出JProfiler](https://yq.aliyun.com/articles/276)  
    [jprofiler的使用](http://wangneng-168.iteye.com/blog/1998034)  

    c:\Leslie\Work\j2ee\About_java\jvm\JProfiler学习笔记 .htm  
    在 Memory Views 页面 需要选择 " Recorded Objects" 才能在Heap 中的 Allocation tree 中找到调用路径;  
    如果是Object, 占用的可能大小是不包括引用(4bytes)的; 

  * junit 测试  
    + CPU 相关  
    Idea, Jprofiler 9.2.1, 执行profile 'test1()' 后, Probe settings -> Profiling settings -> Customize Profiling settings -> Miscellaneous: 中选中 keep VM alive, 否则有些数据来不及收集，就结束了;  
    如果需要查看cpu call tree 中的方法执行时间: 需要先把 jprofiler 页面选到 CPU Views -> Call Tree, 否则看不到数据，不知道哪里可以设置;  
    Filter settings -> Define filters 需要性能监控的package 选择 profiled, 这样CPU call tree 调用结果就只显示该packages;  
    Filter settings -> Ignore methods 最好全都去掉;  
    Initial recording profile: 选择 CPU Recording.  否则CPU Views 中没有数据.

    + 内存相关  
      目前还不知道怎么做.  

  * CPU Views  
    + Call tree
      可以查看调用树， 及每个方法执行时间, 占比;  

    + Hot Spots
      查看方法的执行总时间、平均时间、次数, 方便找出最耗时的;
