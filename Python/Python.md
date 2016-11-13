* `dir()`: 查看当前导入的模块
  `dir(string)`: 查看string模块内的函数
  `help(string):string module 帮助.
  `help(string.swapcase): string.swapcase 帮助.

* `sys.path`: 查找module的路径.
  `string.__file__`: string module 的路径，通常是pyc文件.

* `sudo apt install python-pip`: 安装pip, 在~/.pip/目录下新建pip.conf配置文件.
  `pip install scrapy`: 安装scrapy module
  `pip install scrapy==1.1.0`: 安装指定版本的module, 注意是 ==
  `pip list`: 列出安装的modules
  `pip list -help`: pip list 帮助.
  `pip show scrapy`: 查看scrapy信息.
