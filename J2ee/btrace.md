## 配置
  * [Github greys](https://github.com/btraceio/btrace)
  * 安装包里有 userguide.html
  *  /Users/leslie/MyProjects/mybtrace: 我的btrace scripts.

## 使用.
  * btrace 11580 com/wy/btrace/gc/HelloWorld.java: 11580 是java应用pid.  ctrl + c 然后选择命令退出.

  * btrace -o /Users/leslie/MyProjects/mybtrace/src/main/java/11580.dat 11580 com/wy/btrace/gc/HelloWorld.java: 输出到指定的文件，使用绝对路径.  注意: ctrl+c 选择退出后，不在向11580.dat中输出信息.

  