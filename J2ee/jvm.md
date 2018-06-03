
## 分析 ##
### javacore ###
* 不管用sun的jdk还是ibm的jdk,kill -3 都是发送sigquit消息,jvm不会终止;kill -11 发送sigsegv消息,jvm都会终止掉.
  ibm jdk:  可以设置环境变量IBM_JAVACOREDIR=.  ，同时要让执行jdk的shell知道这个变量,因为是jdk内部输出的javacore. 就会将javacore 输出到指定的目录.
  
*** IBM jca 工具 v4.2.3:
  runnable : 表示可以运行，现在不一定正在运行.
  waitting : sleep, 等待io, ...
  具体看S:\Work\Java\About_java\Memory\How to Diagnose Java Resource Starvation\How to Diagnose Java Resource Starvation(2).html
  如果是synchronized这种java内置的监控器可以在jca中查到，但是如果是自定义的就没有办法了.
  javacore 是jdk产生的.

* 切记：javacore文件是关于cpu的，heapdump文件是关于内存的
        产生两个javacore文件.来比较是否有重合.

### heapdump ###
  *产生:
     IBM 1.6:  发生OOM的时候会自动生成3个文件: Snap.20120331.235355.2722.0003.trc  javacore.20120331.235355.2722.0002.txt heapdump.20120331.235355.2722.0001.phd
               java -Xrunhprof:heap=dump,format=a -Xmx50m -cp . -verbosegc HeapExhaustionSimulator 2>verbosegc.txt  这样除了生成上面的3个文件,还有一个java.hprof.txt
     Sun 1.6:  当发生OOM的时候,默认不会产生任何文件,只是显示在屏幕上.
               java -Xmx50m -cp . -verbosegc -XX:+HeapDumpOnOutOfMemoryError HeapExhaustionSimulator 2> verbosegc.log 会产生java_pid3652.hprof,一般都很大,用HeapAnalyzer也可以看.
  *jvm 划分: 
    programe counter register: pc counter.
    jvm stack:                每个线程都有一个stack,可以动态增长.
    heap:                     所有new的对象,arrays.
    method area:              class
    native method stack:      non java stack
    runtime constant area:

*** IBM HeapAnalyser 工具 v4.2.6:

### GC ###
*** IBM gc工具 v4.1.4(Pattern Modeling and Analysis Tool for Java Garbage Collector):
   
     * Graph view all 界面: if ( Used Tenured after + request > Total Tenured after)  OutOfMemory 就会发生, 所有可能出现Used小于Total的情况下也会有OOM.

发生OOM的时候，如果看gc没有用，就要看heapdump.

============================jprofiler=====================================
* c:\Leslie\Work\j2ee\About_java\jvm\JProfiler学习笔记 .htm
* 在 Memory Views 页面 需要选择 " Recorded Objects" 才能在Heap 中的 Allocation tree 中找到调用路径;
* 如果是Object, 占用的可能大小是不包括引用(4bytes)的;












