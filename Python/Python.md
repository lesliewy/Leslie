## 命令 ##
  * help  
  `help()`: 进入help shell.  modules, keywords, topics  
  `dir()`: 查看当前导入的模块  
  `dir(string)`: 查看string模块内的函数  
  `help(string):string module 帮助.  
  `help(string.swapcase): string.swapcase 帮助.  
  `help(str)`: str 和 string 不同, 这个是"aaa".swapcase()中的swapcase的用法.  

  * `import sys; sys.path`: module的搜索路径  
  `print(string.__file__)`: 查找module的路径, string module 的路径，通常是pyc文件.

  * 在python shell 环境下执行py文件  
  `import os`  
  `os.getcwd()`:查看当前所在目录.  
  `os.chdir("")`: 切换目录.  
  `execfile("a.py")`: 执行文件.  

  * pip  
  `sudo apt install python-pip`: 安装pip, 在~/.pip/目录下新建pip.conf配置文件.  
   https://pip.readthedocs.io/en/stable/installing/: 安装pip  
  `pip --help`: 查看帮助  
  `pip install /Users/leslie/MyProjects/machinelearning/Data/handwrite/Imaging-1.1.7`: 本地方安装, Imaging-1.1.7是解压后目录.  
  `pip install --help`: 查看install帮助.  
  `pip install scrapy`: 安装scrapy module, 默认放在/home/leslie/.local/lib/python2.7/site-packages  
  `pip install scrapy==1.1.0`: 安装指定版本的module, 注意是 ==  
  `pip list`: 列出安装的modules  
  `pip list -help`: pip list 帮助.  
  `pip show scrapy`: 查看scrapy信息.  
  sudo python3 -m pip install rpi.gpio:  同时安装python2 python3 情况下，将module下载到python3环境.
  pip3 install rpi.gpio  
  `pip install -U pip`: 更新pip.  
  `pip list --outdate`: 查看需要更新的包.  
  `pip show --files numpy`: 查看包安装路径.  
  
  pip好像不能查看远程package情况, 两种方法:
   1, https://pypi.org/  搜索
   2, conda search torch:  可以，pip search 不行, 只能搜索package。

  * ipython  
  `sudo apt install ipython`: 使用ipython来调试.  
  ipython 进入ipython环境:  
  > %run -d -b35 TestDataShicimingju.py: 调试模式, 第35行设置断点. 开始进入时需要先一次c.  
    *** 注意 ***:如果在同一个ipython环境里多次执行 %run，加载的始终是第一次的文件，此时需要exit,重新进入.   
  `b 229, j==56`: 当j==56为True时，停在229行.

## 配置 ##
  * 和设置PATH一样，可以设置PYTHONPATH， ":"分隔. sys.path 可以查看python查找包的路径; 搜索顺序是:  
     当前路径;  
     PYTHONPATH 设置的路径;  
     默认路径;  

  * pycharm 添加PYTHONPATH方法: project: a -> project interpreter -> 选中某个python -> show all -> show paths for the selected interpreter -> "+"  

## 杂项 ##
  * 如果修改了kNN.py,  在python shell中需要exit(), 重新进入，import kNN 才会生效。   reload(kNN): 也可以重新加载， 不需要退出。  

  * 关于编码  
  [Python 设置系统默认编码](http://blog.csdn.net/jlhx123456/article/details/47031461)  
  [Python2.7字符编码详解](https://www.cnblogs.com/clover-toeic/p/5291787.html)  
  python2 defaultencoding 是 ascii, 所以字符串处理时要注意.  
