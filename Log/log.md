## log4j

## logback
   * 使用
   引用org.slf4j.slf4j-api.jar  和 ch.qos.logback.logback-classic.jar;
   在classpath中添加logback.xml,  例如放在 resource 目录下;
   java中: private static final Logger LOGGER       = LoggerFactory.getLogger(BatchImport.class);

   * 
   <?xml version="1.0" encoding="UTF-8"?>
<!-- Logback Configuration. -->
<configuration debug="true">
	<property name="app.output" value="/Users/leslie/IdeaProjects/Logs/sinensis"/>
	<appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
	</appender>

	<appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
	</appender>
	
	<logger name="cn.wy.filter.MetricsFilter" level="ERROR" additivity="false">
		<appender-ref ref="codeAppender"/>
		<appender-ref ref="CODEGRAYLOG"/>
	</logger>

	<!-- ibatis log start -->
	<logger name="com.ibatis" level="${app.logging.level}" />
	<logger name="com.ibatis.common.jdbc.SimpleDataSource" level="${app.logging.level}" />

	<root>
		<level value="${app.logging.level}" />
        <appender-ref ref="STDOUT" />
        <appender-ref ref="STDERR" />
		<appender-ref ref="FILE" />
	</root>
</configuration>
   如上的配置, 如果代码中的LoggerFactory.getLogger(name):
      - name=a, 查找和该name 最相近的logger, 和任何的<logger> 都不匹配, 则按照 <root> 所指定的输出;
      - name=com.ibatis.common.jdbc.SimpleDataSource,  和其中的一个logger匹配，则level由该logger的level决定, appender 没有，且additivity没有指定，默认为true, 所以还要添加默认<root> 中的信息;
      - name=com.ibatis.common, 最相近的匹配是name="com.ibatis"的logger, level 和 appender 的决定方式同上;
      - name=cn.wy.filter.MetricsFilter, 和上面的一个logger匹配，则按照该logger的level appender 输出，由于additivity="false", 所以不添加<root> 中的;   如果additivity="true", 还需要添加<root> 中 appender

    *
        <RollingRandomAccessFile name="jobrollinglogappender"
                                 fileName="${LOG_HOME}/${JOB_FILE_NAME}.log"
                                 filePattern="${LOG_HOME}/${JOB_FILE_NAME}-%d{yyyy-MM-dd}-%i.log">
            <PatternLayout
                    pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{1} - %msg%n"/>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1"/>
                <SizeBasedTriggeringPolicy size="20 MB"/>
            </Policies>
            <DefaultRolloverStrategy max="20"/>
        </RollingRandomAccessFile>
    如上的rolling 配置,
    SizeBasedTriggeringPolicy 表示每到20m, 就重新生成一个log.
    TimeBasedTriggeringPolicy 该配置要求 filePattern 中必须存在 dataPattern,  例如: %d{yyyy-MM-dd}, interval=1, 就表示每天一个log文件,   %d{yyyy-MM-dd_HH}, interval=1 就表示每个小时一个文件.
    这两个policy是并列的，没有先后顺序，谁先满足就执行谁;
    DefaultRolloverStrategy: 表示最多生成20个文件.

## log4j2
  * 使用class的全路径名作为Logger更好: Logger logger = LogManager.getLogger(PoniaImpl.class);
    而不是某个具体的名字, 因为可以输出 %logger{36}， 显示具体的class.  如果用 %method 会影响性能;   
    <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %-5level %logger{1} - %msg%n"/>
    
