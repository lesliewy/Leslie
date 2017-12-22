* 编译spring源码,  需要git, gradle,   jdk8(gradle中有 MetadataSpaceSize 这个jvm 参数)
gradle tasks : 查看 task  
gradle build:  按照 build.gradle中来编译;
gradle cleanIdea eclipse :  先清除所有 idea 的工程文件, 然后生成 eclipse 的; 以便导入 eclipse;
需要把生成的 .project 文件中的以下部分去掉: 
     <linkedResources/>
     <filteredResources>
          <filter>
               <id>1359048889071</id>
               <name></name>
               <type>30</type>
               <matcher>
                    <id>org.eclipse.ui.ide.multiFilter</id>
                    <arguments>1.0-projectRelativePath-matches-false-false-build</arguments>
               </matcher>
          </filter>
     </filteredResources>
否则无法导入, 不明白为什么;  有可能是 eclipse 版本的问题;
import-into-eclipse.bat:  交互式执行导入eclipse

使用 working set 功能: 可以建立层级关系，将相关的工程放在父目录下;   top level element -> working sets


* mvc step by step:  spring-mvc-step-by-step.pdf
* form 提交后： 执行 commandClass （没有的话，执行formBackingObject），然后执行onSubmit().
* http://blog.csdn.net/robertleepeak/archive/2010/09/20/5896833.aspx
  http://blog.csdn.net/bluesmile979/archive/2009/01/14/3776797.aspx
  http://www.iteedu.com/webtech/j2ee/springdiary/71.php
Spring MVC的表单控制器(前篇 后篇): http://hi.baidu.com/mars_venus/blog/item/77e708e958da0334b90e2dba.html
  关于spring的错误提示:   http://blog.sina.com.cn/s/blog_4b86f2ee01000765.html

* 报invalid column name 错误:    首先检查sql语句;   再检查如果数据库中的字段是nullable的，返回的sql中存在为null的字段，再根据resultMap去映射时，会报此错，可以添加 nullValue=" ".
* 在sql-map-config.xml的 <settings> </settings>中如果有useStatementNamespaces="false"，则调用 <select id="queryAInvByObject" resultMap="result"> 这样的语句时可以直接写queryAInvByObject,  否则需要<sqlMap namespace="Psmtainv">  "Psmtainv.queryAInvByObject"才可以,默认为true.
* Don't know how to iterate over supplied "items" in &lt;forEach&gt;    :  此错一般是传给items的值类型不是collection的.

* form:
  * deploy 时,会先进性invoice-servlet.xml该spring控制文件中的初始化等工作.如果在invoice-servlet.xml中设置了<property name="validator">，则此时会检查是否符合(validator class中的supports(class),class参数是invoice-servlet.xml 中的commandClass,然后调用 <bean class=""> 中的controller中的formBackingObject()来渲染<property name="formView">指定的jsp,设置各个输入框的初始值.
  * 转向一个form时,先执行该form的controller中的formBackingObject(),准备开始渲染指定的formView对应的jsp.此时return的要符合validator的要求.
    如果在jsp的form中指定commandName,则值需要与invoice-servlet.xml中对应的form bean中的commandName的值相同.
  * 提交时,先执行指定的validator中的supports()和validator();
    再执行onSubmit(),跳到ModelAndView指定的页面,如果指定successView也是一个包含from的页面,则执行该suuccessView对应的controller中的formBackingObject，而不是原当前form中的formBackingObject,来渲染successView指定的jsp。

* Spring可扩展Schema提供自定义配置支持
  可以定义自己的xml:  <redis:client> 
  编写XSD文件;
  编写NamespaceHandler和BeanDefinitionParser完成解析工作;
  编写spring.handlers和spring.schemas串联起所有部件
  参考: http://blog.51cto.com/tianya23/1009715

* 报错: invalid column name
  * 检查ibatis的sql配置文件: psmttinv.xml 的sql语句中的所有字段是否都有在resultMap中出现.
  * 在resultMap中是否没有添加nullValue属性.
  * 重新redeploy,重启tomcat再试.