* [官方文档](https://docs.mongodb.com/manual/)
  ubuntu 的安装方法在: https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

* `sudo service mongod start`: 启动mongodb, 可以查看/var/log/mongodb/mongod.log, 是否启动成功.
  `mongo`:  进入mongo shell. MongoDB数据库默认是没有用户名及密码，不用安全验证的，只要连接上服务就可以进行CRUD操作

* mac 下搭建mongodb
  [Mac下安装和配置mongoDB](://www.cnblogs.com/wx1993/p/5187530.html)
  启动: mongod -f /opt/mongodb-osx-x86_64-4.0.5/etc/mongod.conf

* 新增用户、密码
  mongo正常登入:  
  use poetry
db.createUser(
  {
    user: "poetry",
    pwd: "poetry123",
    roles: [
       { role: "readWrite", db: "poetry" }
    ]
  }
)
  然后修改/etc/mongod.conf: 添加
  security:
  authorization: enabled
  sudo service mongod restart: 重启服务.   注意: 如果去掉该配置，即去掉了用户密码验证，无用户登录可以操作任何表.d
  mongo 登入后: 如果之前时在poetry下面建的, 就需要use poetry, 然后 db.auth("poetry", "poetry123"); 返回1表示成功, 0表示失败.
  mongo poetry -u poetry -p poetry123: 也可以这样登录.

  show dbs等需要特殊的角色, 这里创建root用户,
  use admin
  db.createUser(
  {
    user: "root",
    pwd: "root123",
    roles: [
       { role: "root", db: "admin" }
    ]
  }
)
  mongo admin -u root -p root123: 也可以这样登录.
  use admin && db.system.users.find() : 查看所有用户.  注意外面的db 和roles里面的db不同. 外面的表示在那个db创建的用户.
  db.system.users.remove({user: "root"}): 删除用户.

  详细的角色信息: https://docs.mongodb.com/manual/core/security-built-in-roles/

* admin: root/root123
  poem: poem/poem123    
  stock: stock/stock123

* **相关配置文件**
  > /lib/systemd/system/mongod.service
  > /etc/mongod.conf

* mongostat 是mongodb自带的监控工具.
  mongostat -u root -p root123 --authenticationDatabase admin
  studio3T:  mongodb 客户端;

* 一些查询语句.
  `db.poem.find({}, {'author.name' : 1})`: 所有作者. `db.poem.find({}, {'author.name' : 1}).count()`
  `db.poem.find({'author.name' : '孔融'}, {'poems' : 1}).pretty()`: 某位作者的所有诗.
  `db.poem.find({'category.name' : '先秦', 'author.name' : '诗经'}, {'poems' : {'$elemMatch' : {'name' : '凯风'}}}).pretty()`: 查询条件category.name, author.name,  返回poems数组中指定name的那一个元素.  $elemMatch 只匹配第一个.
  `db.poem.aggregate([{'$project' : {'category.name' : 1, 'author.name' : 1, 'author.numofpoems': 1, numofpoems : {'$size' : '$poems'}, '_id' : 0}}])`: 按照category.name, author.name分组，统计诗词个数.
  `db.poem.aggregate([{
   "$group": {
      "_id": 0,
      "count": {
         "$sum": {
            "$size": "$poems"
         }
      }
   }
  }])`: 统计总诗词数.

  `db.poem.aggregate([{'$project':{'categoryname':'$category.name', 'authorname' : '$author.name', '_id':0}}, {'$group' :{'_id':{categoryname:'$categoryname'}, 'totalauthors': {'$sum' : 1}}}])`: 按朝代统计诗人数.  ** $project中, 每个document返回一条记录, 作用是将嵌套拉平.**
  
  `db.poem.aggregate([{'$project':{'categoryname':'$category.name', 'poems' : {'$size':'$poems'}, '_id':0}}, {'$group' : {'_id':{'categoryname':'$categoryname'}, 'totalpoems':{'$sum' : '$poems'} }}])`: 按朝代统计诗词数.

  `db.poem.aggregate([{'$match' : {'category.name' : {'$in' : ['先秦','汉朝']}}} , {'$project' : {'category.name' : 1, 'author.name' : 1, 'author.numofpoems': 1, 'numofpoems' : {'$size' : '$poems'}, '_id' : 0}},{$sort : {'numofpoems': -1}}])`:  按年代查询诗人的诗词数，并按照诗词数从高到低排序.

  `db.poem.aggregate([{'$match' : {'category.name' : {'$in' : ['先秦']}}} , {'$project' : {'category_name' : '$category.name', 'category_url':'$category.url', 'category_numofauthors':'$category.numofauthors', 'author.name' : 1, 'author_name':'$author.name', 'author_url':'$author.url', 'author_numofpoems': '$author.numofpoems', 'numofpoems' : {'$size' : '$poems'}, '_id' : 0}},{$sort : {'numofpoems': -1}}])`:使用project 可以将嵌套的数据拉平.

  `db.poem.aggregate([{'$match':{'author.name':'孔融'}}, {'$unwind':'$poems'}])`: unwind可以将数组里的数据拉平.

  
* 一些修改语句.
  `db.poem.update({'author.name' : '李白' }, {'$pull' : {'poems' : {'name' : '行路难 其二'}}})`: 删除李白的 行路难 其二, 只删除poems列表中一个元素.

* mongo shell 中一些变量.
  DBQuery.shellBatchSize=30:  查询时候显示的数目，用it继续显示.
  


