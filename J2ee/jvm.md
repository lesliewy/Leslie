
## 分析 ##
### 文档及文章 ###
   * [JDK 10 Documentation](https://docs.oracle.com/javase/10/)  JDK文档大合集.
   * [JVM参数设置、分析](https://www.cnblogs.com/redcreen/archive/2011/05/04/2037057.html#CMSInitiatingOccupancyFraction_value)  
   * [JVM实用参数](http://ifeve.com/useful-jvm-flags-part-3-printing-all-xx-flags-and-their-values/)  

### javacore ###
  * 不管用sun的jdk还是ibm的jdk,kill -3 都是发送sigquit消息,jvm不会终止;kill -11 发送sigsegv消息,jvm都会终止掉.
  ibm jdk:  可以设置环境变量IBM_JAVACOREDIR=.  ，同时要让执行jdk的shell知道这个变量,因为是jdk内部输出的javacore. 就会将javacore 输出到指定的目录.  

  * IBM jca 工具 v4.2.3  
  runnable : 表示可以运行，现在不一定正在运行.  
  waitting : sleep, 等待io, ...  
  具体看S:\Work\Java\About_java\Memory\How to Diagnose Java Resource Starvation\How to Diagnose Java Resource Starvation(2).html  
  如果是synchronized这种java内置的监控器可以在jca中查到，但是如果是自定义的就没有办法了.  
  javacore 是jdk产生的.  

  * 切记：javacore文件是关于cpu的，heapdump文件是关于内存的  
        产生两个javacore文件.来比较是否有重合.

### heapdump ###
  * 产生  
    + IBM 1.6  
      发生OOM的时候会自动生成3个文件: Snap.20120331.235355.2722.0003.trc  javacore.20120331.235355.2722.0002.txt heapdump.20120331.235355.2722.0001.phd  
      java -Xrunhprof:heap=dump,format=a -Xmx50m -cp . -verbosegc HeapExhaustionSimulator 2>verbosegc.txt  这样除了生成上面的3个文件,还有一个java.hprof.txt  

    + Sun 1.6  
      当发生OOM的时候,默认不会产生任何文件,只是显示在屏幕上.
      java -Xmx50m -cp . -verbosegc -XX:+HeapDumpOnOutOfMemoryError HeapExhaustionSimulator 2> verbosegc.log 会产生java_pid3652.hprof,一般都很大,用HeapAnalyzer也可以看.

  * jvm 划分  
    programe counter register: pc counter.  
    jvm stack:                每个线程都有一个stack,可以动态增长.  
    heap:                     所有new的对象,arrays.  
    method area:              class  
    native method stack:      non java stack  
    runtime constant area:  

  * IBM HeapAnalyser 工具 v4.2.6  

### GC ###
  * 文档  
  [【GC分析】Java GC日志查看](https://www.cnblogs.com/qlqwjy/p/7929414.html)  
  JDK文档大合集中: Garbage Collection Tuning 是gc相关.  
  [CMS GC日志详细分析](https://blog.csdn.net/a417930422/article/details/16948933)  
  [GC之详解CMS收集过程和日志分析](http://www.cnblogs.com/zhangxiaoguang/p/5792468.html)  
  [认识JVM性能监控与故障处理工具&深入理解Java内存模型](https://blog.csdn.net/kringpin_lin/article/details/26211119)  
  [Java: 对象不再使用时赋值为null的作用和原理](https://www.polarxiong.com/archives/Java-%E5%AF%B9%E8%B1%A1%E4%B8%8D%E5%86%8D%E4%BD%BF%E7%94%A8%E6%97%B6%E8%B5%8B%E5%80%BC%E4%B8%BAnull%E7%9A%84%E4%BD%9C%E7%94%A8%E5%92%8C%E5%8E%9F%E7%90%86.html)  
  [面向GC的Java编程](http://www.importnew.com/11372.html)  

  * `jstat -gc {pid}`: 查看gc各分区总大小、已使用大小(kB)
    `jstat -gcutil {pid}`: 查看已使用情况.(kB)

  * 发生OOM的时候，如果看gc没有用，就要看heapdump.  

  * 在idea 等IDE中观察gc情况，可以使用System.gc()

  * 工具  
    + IBM gc工具 v4.1.4(Pattern Modeling and Analysis Tool for Java Garbage Collector)  
   
    + Graph view all 界面: if ( Used Tenured after + request > Total Tenured after)  OutOfMemory 就会发生, 所有可能出现Used小于Total的情况下也会有OOM.  


## 性能 ## 

## 命令 ##
  * jstack  
    [jstack(查看线程)、jmap(查看内存)和jstat(性能分析)命令](https://blog.csdn.net/imxiangzi/article/details/47123849)  

    `jstack -l {pid}`:  生成thread stack. 查看当前的线程信息.  

  * jmap  
    [jmap的几个操作要慎用](https://blog.csdn.net/lovetea99/article/details/52588265)  

    `jmap -dump:format=b,file=a.bin {pid}`: heapdump.  
    `jmap -histo 69456|head`: 查看示例个数、大小.

  * jstat  
    `jstat -gcutil {pid} {interval} {count}`: gc 相关信息.  每隔 interval s, 输出count次.  

  * jinfo  
    `jinfo –flag UseSerialGC {pid}`: 查看配置信息，这里是查看是否使用了 UseSerialGC.  
  >  
      -XX:-UseSerialGC: 没有使用这种类型的gc.  
      -XX:+UseParallelGC: 使用了该种类型的gc.  

## 杂项 ##
  * jdk jvm jre 3者关系:  c:\Leslie\Work\j2ee\book\java 深度历险\CH_01.深入Java 2 SDK.pdf 中有.  
  
  * 执行 java 命令: java.exe 所在的位置不一定在 java_home 指定的地方;  依然是按照先本目录，再 path 变量处.  
   javac 等jdk本身的命令使用的是 jdk 附带的JRE + tools.jar,  一般在myeclipse里有一个 JRE System Library, 这是开发程序时使用的JRE.  
  * JDK 安装目录下 src.zip 为JDK的源代码。  

  * 有些情况下,图形界面的IDE不成功,但是在命令行下运行javac、java成功  

  * c:\Leslie\Work\Other\SourceInsight\JDK1.6.0_20\  jdk 源码,  @@@ 标识修改部分。  

  * classpath 中的路径需要具体到 jar 名称; 如果不是jar, 只搜索该目录下的class, 不递归搜索;  

  * Java -source   -target
    -source Specifies the version of source code accepted.
    -target Generate class files that target a specified version of the VM. Class files will run on the specified target and on later versions, but not on earlier versions of the VM.

  * `javac test1.java`: test1.java 中可以没有public class,如果要有的话则要与文件名相同.  
    `java test1`: 要想运行test1,则 class test1 中必须要有main, 可以不是public的.  
    jvm将会按照classpath的路径查找class.  假如test1.class放在 l:my\MyJava\src\ 目录下面，classpath=l:my\MyJava\src\  这样仍然不可以.应该用 classpath=l:\my\MyJava\src\ 最后的分号不加也是可以的.  
    test1.java 中  (package + test1).class 必须要在classpath中,否则找不到; 会首先找default package( 不属于任何package)中是否有该class.  
    javac 和 java 命令后面的 必须能在classpath 中找到. 例: `java api.lang.String.AboutString` 也可以是 `java AboutString`:  会到classpath中找 api/lang/String/AboutString.class 和 AboutString.class  










