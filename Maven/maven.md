  Mvn dependency:tree , mvn deploy mvn clean 等在maven plugins 下: http://maven.apache.org/plugins/index.html
  Pom settings.xml 配置在 user center下: http://maven.apache.org/users/index.html

* maven package , maven clean 这些命令必须要在当前工程目录下执行才可以,  还必须是根目录, 有 pom文件的目录;
*  mvn -Dmaven.test.skip=true clean install:  跳过测试.d
* mvn groupId:artifactId:version:goals      maven 命令完整的格式
*  mvn archetype:generate   生成maven工程骨架.   会让选择archetype, 输入 要创建项目的groupId,artifactId，version以及包名package(java 的package),  默认的packaging 是jar (其他war,pom)
      maven 3: mvn archetype:generate 
      maven 2: mvn org.apche.maven.plugins:maven- archetype-plugin:2.0 -alpha- 5:generate
      因为maven3会直接找archetype的最新稳定版，而maven2找的是最新版,可能得到不稳定的SNAPSHOT版本, 所以maven2要显式指定；
   
    mvn clean compile  , mvn clean test , mvn clean package ,mvn clean install    是有顺序的.  package 会先compile,test.  install 会先package.   
    mvn clean deploy : 构建到远程仓库,供别人使用; 具体的仓库地址在pom中<distributionManagement>配置;
    mvn clean compile -U   强制更新,忽略updatePolicy设置.
    mvn dependency:list  列出依赖关系，包括传递性依赖;  和 Eclipse 中的 Maven Dependencies 那里的jar一样, 但是命令会给出scope;
    mvn dependency:tree 列出依赖关系, 与list不同的是 可以看出传递性依赖是由谁传递的;
    mvn dependency:analyze:  在list,tree的基础上分析当前的依赖,  包括: used undeclared dependencies;  unused delcared dependencies;
    mvn eclipse:eclipse:  将包含 src目录, pom文件 的目录转为 eclipse 工程,  可以导入到 eclipse中;

mvn tomcat7:deploy :  部署应用到tomcat上，需要配置tomcat插件, 参考Work/Dropbox/Leslie/j2ee/maven/pom.xml

** dependencyManagement
   里面的dependency 并不会依赖, 只有当子modules 中使用时才会依赖进来;
   子module 不需要再写 <version>,  包括依赖的依赖, 都将使用dependencyManagement 中的版本号

** 稳定版和SNAPSHOT版本
   稳定版: 如果本地不存在，则从远程仓库下载，存在不会再去下载。   例如: <version>1.0.4</version>
   SNAPSHOT:  不管本地存不存在，都会从远程仓库取最新版本。         例如: <version>1.0.5-SNAPSHOT</version>
** maven 生产上的都是稳定的版本号
   当前线上稳定版是1.0.4， 开发新版本时使用1.0.5-SNAPSHOT,  该新版本上线时改成1.0.5

mvn -e -Ddb.file=jpetstore exec:java   使用hsqldb,  当前位置需要有pom.xml, 其中配置hsqldb的相关设置,参考 my/Spring/Spring Framework Samples/jpetstore/trunk/org.springframework.samples.jpetstore/db/hsqldb/pom.xml
 
* 查找jar包的坐标:   GOOGLE搜索：maven 你需的jar包名称 repository
  可以使用仓库搜索服务: 
      https://repository.sonatype.org
      http://www.jarvana.com
      http://mvnrepository.com/

** profiles
   pom 里的id 别和 settings.xml 中的重复了; settings.xml 中的是全局的;
    <resources>
        <resource>
            <directory>src/main/resources</directory>
            <excludes>
                <exclude>prod/**/*</exclude>
                <exclude>dev/**/*</exclude>
            </excludes>
            <filtering>true</filtering>
        </resource>
        <resource>
            <directory>src/main/resources/${package.env}</directory>
        </resource>
    </resources>
    这样来过滤, package.env 配置在profiles.profile.properties 下;  profile 既可以在当前pom, 也可以在parent pom;
    添加了profile 后,  在 idea 的 maven profile 视图中就会出现 profile， 可以下拉选择启动;


mvn dependency:tree|grep cn.fraudmetrix:   列出依赖.
 
