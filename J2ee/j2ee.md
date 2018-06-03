* classpath  
   在web应用中查看执行时的classpath: Thread.currentThread().getContextClassLoader().getResource("/").getPath();
   通常会是/opt/tomcat/apache-tomcat-8.5.14/webapps/ROOT/WEB-INF/classes/   这个目录;  不知道为什么没有/opt/tomcat/apache-tomcat-8.5.14/webapps/ROOT/WEB-INF/lib/ ， 这个也是classpath  
   奇怪的是和greys.sh 来查看的classpath 不同;  
   通常web容器不会自动加载classpath中的配置文件，可以使用类似 classpath:applicationContext.xml 来加载;  