* 直接解压solr包即可. bin/solr 执行   127.0.0.1:8983

* solr -h;  solr start -h;   solr create -h;  
  solr create_core -help;  solr create_collection -help;   查看帮助.

* 中文分析需要 mmseg4j-core-1.10.0.jar  mmseg4j-solr-2.3.0.jar
  Mmseg4j Solr 最新版2.3.0不支持 solr 6.3, 改用solr 5.3版本.
  6.3版本只支持jdk 1.8 及以上.
  5.3版本可以支持jdk1.7

* 在$SOLR_HOME/server/solr/test1目录下必须存在solrconfig.xml、schema.xml
  5.3版本中这两文件必须放在 server/solr/test1/conf目录下.

* solr -s /home/leslie/MyProject/mysolr/servers:  将 /home/leslie/MyProject/mysolr/servers 作为solr.home并启动solr, 创建的core/collection 都位于solr.home下.

  solr start 此方式启动的solr, 默认的solr.home 是$SOLR_HOME/server/solr, 作为solr.home,必须要包含solr.xml
  不明白修改了solr自带的webapp里的web.xml中的solr/home(去掉注释), 不起作用， 每次都要solr -s 挺麻烦.

  solr stop: 停止solr


* solr create -c jcg -d basic_configs
  等价于 http://localhost:8983/solr/admin/cores?action=CREATE&name=jcg&instanceDir=jcg
  新建的core在 /opt/solr-5.3.0/server/solr

  solr delete -c test1
  等价于 http://localhost:8983/solr/admin/cores?action=UNLOAD&core=test1&deleteIndex=true&deleteDataDir=true&deleteInstanceDir=true

  solr status: 查看当前运行的情况


* 在 /opt/solr-5.3.0/example/exampledocs目录下有post.jar, 可以用来导入数据.
  java -jar post.jar -h: 查看帮助
  java -Dtype=text/csv -Durl=http://localhost:8983/solr/jcg/update  -jar post.jar   books.csv: 导入csv文件.
  也可以直接只用 $SOLR_HOME/bin/post: post -h

*  既可以在 solr 控制台查询，也可以http方式查询: http://localhost:8983/solr/jcg/select?q=name:%22Kings%22, 还可以写代码查询，java, ruby, php,python 等等.
    via REST clients, cURL, wget, Chrome POSTMAN, etc., as well as via the native clients available for many programming languages， Solr Admin UI

* 可以在solr 控制台, 对应的core下面的 Analysis 分析各个fieldtype.

* 删除数据: 
    http方式:
    http://localhost:8983/solr/poetry/update/?stream.body=<delete><query>*:*</query></delete>&stream.contentType=text/xml;charset=utf-8&commit=true
    命令方式:
    post -c test1 -d "<delete><id>SP2514N</id></delete>"
    post -c test1 -d "<delete><query>*:*</query></delete>"

* 修改完 schema.xml solrconfig.xml 需要重启. solr stop -all;  solr start;


* mongo-connector: 增量索引， 实时将mongodb中数据传输到solr做索引.
  pip install mongo-connector;
  sudo ln -s ~/.local/bin/mongo-connector mongo-connector

* solr 的日志
  solr 日志系统使用log4j + slf4j, 相关jar在 /opt/solr-5.3.0/server/lib/ext， 配置文件: /opt/solr-5.3.0/server/resources.
  如果是新增jar，要想日志被输出，需要配置resources目录下的log4j.properties, 代码中也需要使用slf4j来记录日志.

* poetry 索引记录.
  1, solr create -c poetry -d basic_configs: 使用基本配置创建core poetry
  2, dataimport 全量索引，增量索引先不做.
    * 文档
    https://cwiki.apache.org/confluence/display/solr/  Uploading+Structured+Data+Store+Data+with+the+Data+Import+Handler

    * 命令
    http://localhost:8983/solr/poetry/dataimport?command=reload-config: 重新加载dataimport   的配置文件，只对data-config.xml有效， schema.xml修改需要重启solr.
    http://localhost:8983/solr/poetry/dataimport?command=full-import:  全量导入
    http://localhost:8983/solr/poetry/dataimport?command=status:  查看状态.

    * SolrMongoImporter 基于github 上的项目修改: https://github.com/james75/SolrMongoImporterj
      本地: /home/leslie/MyProject/mysolr/SolrMongoImporter
      配置 poetry/conf 目录下的 solrconfig.xml data-config.xml schema.xml
      添加了gson-2.8.0.jar , 放在webapp/WEB-INF/lib 目录下

    * mongo查询语句, unwind将数组中的数据拉平, project 将嵌套的数据拉平.
    db.poem.aggregate([{'$match':{'author.name':'潘岳'}}, {'$unwind':'$poems'}, {'$project':{'category_url':'$category.url', 'category_name':'$category.name', 'category_numofauthors':'$category.numofauthors', 'author_url':'$author.url', 'author_name':'$author.name', 'author_numofpoems':'$author.numofpoems', 'author_brief':'$author.brief', 'poem_url':'$poems.url', 'poem_name':'$poems.name', 'poem_content':'$poems.content', 'poem_appreciation':'$poems.appreciation', 'poem_tags':'$poems.tags'}}]).pretty()

