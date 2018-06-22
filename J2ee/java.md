## JDK ##
### java.lang ###
 * byte b=66;: System.out.println(b) 输出 66 占用1个字节.  
   char c=66;: System.out.println(c) 输出 B 占用2个字节.  
   float f=3.5;: 是错误的,float 占用4个字节，而3.5是double型，占用8个字节. 修改为 f=3.5f.  
   char ch=66; ch=ch-1;: 经过计算后，ch将后转变成int型,如果输出的话是65，而不是A.  
        如果有一个double，结果则是double;  
        如果有一个float， 结果则是float;  
        如果有一个long , 结果则是long;  
        如果有一个int     结果则是int;  
        byte、char、short将会转为int;  
   str1 == str2: 比较内存地址，而不是内容; 如果前面有str1=str2, 则为true.  
   str1.equals(str2): 比较的是内容, 而不是地址; 如果前面有str1="abc";str2="abc"; 则为true.  

### java.text ###
  * DateFormat 中 setLenient(false); 将会严格按照每个月的日期去parse. 2010-01-35 2001-02-29 都是错误的，如果为true(默认),则2001-02-29会解析为2001-03-01  

### java.util ###
  * 遍历HashMap时，使用 Set<Entry<String,String>> entryset = map.entrySet();  不用 keySet(), 这样可以避免多余的map.get()操作.  

### java.util.concurrent
  * [详解 ThreadLocal](https://www.cnblogs.com/zhangjk1993/archive/2017/03/29/6641745.html)  

### 注解 ###
  * [Java自定义注解和运行时靠反射获取注解](http://blog.csdn.net/bao19901210/article/details/17201173/)  

### 异常 ###
  * 绝对不要直接catch exception, 因为 NPE、OutOfMemoryErrors 等异常也能被捕获.  

### 其他 ###
  * new 一个对象时，在执行对象的构造函数之前，会初始化所有的数据成员，不论位置.  
  在一个类中的构造方法可以调用同类中的另一个构造方法: this(args）.  

  * 参数传递: 基本数据类型传递的是个复制的值，原来的值并没有变化.  
    对像(包括数组）传递的是个引用(别名),修改该参数等于修改原来的值.  
  
  * java中允许多层继承，但不允许多重继承(extends a,b).  

  * static int count; 所有对象的count值都是同一个, static 对象只有一个  
   private static int count; 实例对象无法访问.  
   static void sing(){ };  static 方法中不能访问类中的非静态成员和方法,因为非静态的成员和方法必须先 new 一个对象,才能使用.
   void change() { }  非static方法中可以访问static的方法和成员变量.  
   static void sing(){ }  无法使用this 和 super,理由同上，因为此时还没有对象.  
   static { }  与成员变量类似，在执行对象的构造方法前会执行.  



## 设计模式 ##
  * 单态设计模式：                   设计模式：  大量实践中总结和理论化之后的优选代码结构.   单态：  在程序中一个类只能生成一个instance.  



## 第三方 ##
### fastjson ###
  * 使用JSON.toJSONString(batchResult.clss) 方法时会调用 batchResult 中的属性的getter()方法，除非添加了JSONField(serializable==false)  
    使用JSON.parseObject(batchResultString) 会调用setter().  
    所以要关注到相应方法中是否有性能问题.
  
  * 持久化到缓存中所有字段是否必要，特别是占用空间较大的.  

### IBM jar ###
  * IBM的很多工具都是一个可执行jar,  可以用:   java -jar jca423.jar 来打开.   java –Xmx500m –jar
  如果打开某个文件时出现outofmemory,可以增大此参数.  



## 错误及解决 ##
  * java.lang.SecurityException: Prohibited package name: java.perftuning.objectcreation.pool1  
   解决1:  package名字不能以java.开头，修改掉即可.  

  *  源文件中如果包含中文,那么源文件的编码格式会影响程序运行时中文的接收.  发现只要源文件中中文能够正常显示就可以了.  
   如果源文件中中文是乱码, 编译成了class. 使用诸如 new String(this._buffer, 0, this._length, "GBK"); 都不能正常显示中文.  

  *  如果字节发送时用 UTF-8编码,如bytebuffer.append(responseMsg.getBytes("UTF-8"))  接收时用GBK编码还原会显示乱码:"receive00[" + bytebuffer.toString("GBK") + "]"  
  
  * JDK中的LOG可以参看 <<深入体验Java_Web开发内幕-核心基础>> 的 page 209.  


=================================useful urls==========================================================
Java Memory Model 的相关资料:
http://www.cs.umd.edu/~pugh/java/memoryModel/
http://www.cs.umd.edu/~pugh/java/memoryModel/jsr-133-faq.html
http://www.jcp.org/en/jsr/detail?id=133

Java SE HotSpot:
http://www.oracle.com/technetwork/java/javase/tech/index-jsp-136373.html

Java 2 Platform Security Architecture
http://docs.oracle.com/javase/6/docs/technotes/guides/security/spec/security-spec.doc.html

http://onjava.com/

http://java.sun.com/docs/codeconv/html/CodeConventions.doc5.html#2991


1,
          //会计日期
          String str_acdate = (String) WebTellerApp.getWebTellerApp().getContextProperty(UICommVar.CURRENT_TELLER_ACDATE);
        int ac_year= Integer.parseInt(str_acdate.substring(0, 4));
        int ac_mon= Integer.parseInt(str_acdate.substring(4, 6))-1;
        int ac_date= Integer.parseInt(str_acdate.substring(6, 8));

          // 复审日期区间label
          row = new Row();
          label = new Label();
          label.setText("复审日期区间*");
          label.setLayoutData(cld);
          row.add(label);

          Calendar cal_createbeg=Calendar.getInstance(Locale.CHINA);
          Calendar cal_createend=Calendar.getInstance(Locale.CHINA);
          cal_createend.set(ac_year, ac_mon, ac_date);
          cal_createbeg.set(ac_year, ac_mon, ac_date);
          cal_createbeg.add(Calendar.DAY_OF_MONTH, -10);
            // 获取年、月、日
          String str_yearbeg,str_yearend;
          String str_monthbeg,str_monthend;
          String str_daybeg,str_dayend;
          str_yearbeg=Integer.toString(cal_createbeg.get(Calendar.YEAR));
          str_yearend=Integer.toString(cal_createend.get(Calendar.YEAR));
          str_monthbeg=Integer.toString(cal_createbeg.get(Calendar.MONTH)+1);
          str_monthend=Integer.toString(cal_createend.get(Calendar.MONTH)+1);
          str_daybeg=Integer.toString(cal_createbeg.get(Calendar.DAY_OF_MONTH));
          str_dayend=Integer.toString(cal_createend.get(Calendar.DAY_OF_MONTH));
          // 一位的前补 0
          if(str_monthbeg.length()<=1)
               str_monthbeg="0"+str_monthbeg;
          if(str_daybeg.length()<=1)
               str_daybeg="0"+str_daybeg;
          if(str_monthend.length()<=1)
               str_monthend="0"+str_monthend;
          if(str_dayend.length()<=1)
               str_dayend="0"+str_dayend;
          // 当前日期和往前10天的日期
          String str_createbeg=str_yearbeg+str_monthbeg+str_daybeg;
          String str_createend=str_yearend+str_monthend+str_dayend;

          // 起始复审日期区间text
          utterdat = new DateTextField();
          utterdat.setRenderId("utterdat"); // 用于JS
          utterdat.setWidth(new Extent(76)); // 宽度
          utterdat.setMaximumLength(10); // 最大长度
          utterdat.setEnabled(true); // 可用
          utterdat.setText(str_createbeg);
          row.add(utterdat);

          RowLayoutData clddate1,clddate2;
          clddate1 = new RowLayoutData();
          clddate2 = new RowLayoutData();
          clddate1.setWidth(new Extent(17));
          clddate2.setWidth(new Extent(27));
          label = new Label();
          label.setLayoutData(clddate1);
          row.add(label);
          label=new Label();
          label.setText("到");
          label.setLayoutData(clddate2);
          row.add(label);
        // 终止复审日期text
          exceeddat = new DateTextField();
          exceeddat.setRenderId("exceeddat"); // 用于JS
          exceeddat.setWidth(new Extent(76)); // 宽度
          exceeddat.setMaximumLength(10); // 最大长度
          exceeddat.setEnabled(true); // 可用
          exceeddat.setText(str_createend);
          row.add(exceeddat);    
          content.add(row);
==================================规范&效率=========================================================









