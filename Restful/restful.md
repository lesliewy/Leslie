** Resteasy
@Produces({ "application/json; charset=UTF-8" }):  输出的格式. public PoniaResult query()  如果不设置，就不知道PoniaResult 怎么输出;

@BeanParam: public PoniaResult query(@BeanParam PoniaQueryInfo poniaQueryInfo) :如果没有@BeanParam, 会报错: 415-Unsupported Media Type. 参数没有办法转换成PoniaQueryInfo里面的字段;
@BeanParam 和 @FormParam("author_name") 配合使用; 在PoniaQueryInfo中使用, 将post传过来的参数author_name映射为PoniaQueryInfo中的指定字段.
@BeanParam 和 @QueryParam("author_name") 配合使用: PoniaQueryInfo 中使用QueryParam标识的解析url中的参数;

@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
@JsonProperty("interest_flag")   用在返回的 PoniaResult 中, 将指定的字段转为相应的json字段输出;

** 单独使用
   web.xml做如下配置:
    <context-param>
        <param-name>resteasy.resources</param-name>
        <param-value>cn.wy.PoniaImpl</param-value>
    </context-param>
    <listener>
        <listener-class>org.jboss.resteasy.plugins.server.servlet.ResteasyBootstrap</listener-class>
    </listener>
    <listener>
        <listener-class>org.jboss.resteasy.plugins.spring.SpringContextLoaderListener</listener-class>
    </listener>
    <servlet>
        <servlet-name>Resteasy</servlet-name>
        <servlet-class>org.jboss.resteasy.plugins.server.servlet.HttpServletDispatcher</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>Resteasy</servlet-name>
        <url-pattern>/*</url-pattern>
    </servlet-mapping>

** 和spring整合
   web.xml做如下配置, 即所有的都使用spring的:
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:spring/applicationContext.xml</param-value>
    </context-param>
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>
    <servlet>
        <servlet-name>spring</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>spring</servlet-name>
        <url-pattern>/*</url-pattern>
    </servlet-mapping>
   同时需要在applicationContext.xml中引入: <import resource="classpath:springmvc-resteasy.xml"/>   该引用用到了容器中的HttpServletRequest, 所以非容器启动时可以注释掉;
   这样就可以了.
   需要引入resteasy-servlet-initializer.jar 这样就可以通过注解找到rest配置, 不需要显示的说明了.



