* [R官网](http://www.r-project.org)
  [Data Mining with R 官网](http://www.dcc.fc.up.pt/~ltorgo/DataMiningWithR/)

* 关于R添加包的函数
 `install.packages('RMySQL')`: 安装名称为 RMySQL的包.
 `install.packages('/home/leslie/3/gplots_2.11.0.tar.gz', repos=NULL)`: 安装本地下好的包, zip包不可以.
 `installed.packages()`: 已经安装的包
 `library()`: 同样是已经安装的包，信息是用户友好的.
 `old.packages()`: 检查CRAN上是否有已安装的R添加包的更新版本.
 `update.packages()`: 更新所有已安装的R软件包
 `RSiteSearch('neural networks')`: 打开浏览器并搜索R手册、帮助文档中关于neural networks的内容.
 `.libPaths()`: 查看library的路径

* https://cran.r-project.org/web/packages/index.html: CRAN repository 里所有的包.
  https://cran.r-project.org/web/packages/caTools/index.html   包的信息，可以查看需要依赖哪些包，其中的 Depends 就是.
   如果是下载下来的包,例如: gplots_2.11.0.tar.gz  其中的DESCRIPTION 文件中也可以查看依赖.

* ? read.table 查看read.table的帮助信息.

* `library`: 直接输入函数名可以查看该函数的源代码.
  `methods(summary)`             
  `summary.aov`: 如果函数是类函数，需要查看类中的具体函数名称，然后输入类.函数名

* **连接 mysql**
   `sudo apt-get install r-cran-rmysql`
   `library(RMySQL)`
   `con <-dbConnect(MySQL(), user='root', password='mysql', dbname='mysql', host='localhost')`
   `dbListTables(con)`
   另外R查询中文乱码解决: 在MySQL的配置文件/etc/mysql/my.cnf中[client]标签下加`default-character-set=utf8`

* demo (graphics) 或者demo(persp)来体验R绘图功能的强大；
  http://www.cnblogs.com/holbrook/archive/2013/05/13/3075777.html；

* 输入R命令, 然后 `source("a1.R")` 来执行a1.R文件.

* ubuntu 安装rJava, `sudo apt-get install r-cran-rjava`
* rjava 配置
  `export R_HOME=/usr/lib/R`
  rjava 中会使用 java.library.path. 这里设置的LD_LIBRARY_PATH在jvm启动时会读取, 追加到 java.library.path后面. 也可以在 jvm的启动参数中设置.
  指定的是 libjvm.so的路径, rJava.so 中需要用到. `ldd rJava/libs/rJava.so` 来查看.
  `export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server/`

* library(rJava) 时报错: error: unable to load shared object '/usr/lib/R/site-library/rJava/libs/rJava.so':
   可以使用linux命令: `ldd /usr/lib/R/site-library/rJava/libs/rJava.so` 查看rJava.so的依赖情况, 果然其中一项 libjvm.so : not found  `locate libjvm.so`, 找到位置，其实在每个jdk包中都有.
   添加到R中:  .bashrc文件中: `export LD_LIBRARY_PATH=/usr/lib/R/site-library/rJava/jri/:/usr/local/lib/:$JAVA_HOME/jre/lib/amd64/server/`

* `R CMD javareconf`: 重新配置R中的java环境, 会读取 JAVA_HOME 等环境变量来配置R的java环境.
  `R CMD REMOVE rJava`:  命令方式删除rJava package, 也可以直接去libPath下删除.
  `R CMD javareconf --help`:  各个COMMAND的帮助信息.

* 函数说明
  ? mean    查看函数mean的帮助文档.
  mean
  a <- c(1, 2, 520, 660, 526, 623, 862, 753, 720, 890, 12568)
  x <- mean(a)
  y <- mean(a, 0.1)
  z <- mean(a, 0.2)
  yy <- mean(c(2, 520, 660, 526, 623, 862, 753, 720, 890))
  zz <- mean(c(520, 660, 526, 623, 862, 753, 720))
  y == yy,  z==zz,   trim会在首尾分别去除N个异常值，其中N=样本数量*要去除的百分比(即是trim的值)

* aggregate
  data1 <- data.frame(group=c("男", "女", "女", "女", "男"), age=c(10,15,20,25,30));
  aggregate(data1$age, by=list(data1$group), FUN=sum);
  输出结果:
  Group.1 x
  1 女 60
  2 男 40

* table
  table(c(1,2,3,1));
  输出:
  1 2 3
  2 1 1
  table 函数对应的就是统计学中的列联表，是一种记录频数的方法

### shiny
* 在shell的R环境中使用 `runApp("app.R")` 通过浏览器执行shiny要比Rstudio的快很多.
