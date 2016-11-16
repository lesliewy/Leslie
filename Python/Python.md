* `dir()`: 查看当前导入的模块
  `dir(string)`: 查看string模块内的函数
  `help(string):string module 帮助.
  `help(string.swapcase): string.swapcase 帮助.
  `help(str)`: str 和 string 不同, 这个是"aaa".swapcase()中的swapcase的用法.

* `sys.path`: 查找module的路径.
  `string.__file__`: string module 的路径，通常是pyc文件.

* `sudo apt install python-pip`: 安装pip, 在~/.pip/目录下新建pip.conf配置文件.
  `pip install scrapy`: 安装scrapy module, 默认放在/home/leslie/.local/lib/python2.7/site-packages
  `pip install scrapy==1.1.0`: 安装指定版本的module, 注意是 ==
  `pip list`: 列出安装的modules
  `pip list -help`: pip list 帮助.
  `pip show scrapy`: 查看scrapy信息.

* `sudo apt install ipython`: 使用ipython来调试.
  ipython 进入ipython环境:
    %run -d -b35 TestDataShicimingju.py: 调试模式, 第35行设置断点. 开始进入时需要先一次c.  ***注意:如果在同一个ipython环境里多次执行 %run，加载的始终是第一次的文件，此时需要exit,重新进入.***