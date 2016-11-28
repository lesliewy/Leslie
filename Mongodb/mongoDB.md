* [官方文档](https://docs.mongodb.com/manual/)

* `sudo service mongod start`: 启动mongodb, 可以查看/var/log/mongodb/mongod.log, 是否启动成功.

* **相关配置文件**
  > /lib/systemd/system/mongod.service
  > /etc/mongod.conf

* mongostat 是mongodb自带的监控工具.

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

  `db.poem.aggregate([{'$match' : {'category.name' : {'$in' : ['先秦','汉朝']}}} , {'$project' : {'category.name' : 1, 'author.name' : 1, 'author.numofpoems': 1, numofpoems : {'$size' : '$poems'}, '_id' : 0}},{$sort : {'numofpoems': -1}}])`:  按年代查询诗人的诗词数，并按照诗词数从高到低排序.
  
* 一些修改语句.
  `db.poem.update({'author.name' : '李白' }, {'$pull' : {'poems' : {'name' : '行路难 其二'}}})`: 删除李白的 行路难 其二, 只删除poems列表中一个元素.

* mongo shell 中一些变量.
  DBQuery.shellBatchSize=30:  查询时候显示的数目，用it继续显示.
  

