## 配置 ##
  * Mac安装  
    解压后，cd src;   make install  
    src/redis-server:  前台启动  
    src/redis-cli:  连接  
    redis-cli -h 127.0.0.1 -p 6378  

## 命令 ##
  * help  
  `redis-server --help`: 显示帮助信息.  
  `redis-cli --help`  
  `help`: 查看帮助.  help <Tab>: 命令集
  `help get`: 查看get帮助.

  * redis-benchmark  
  `redis-benchmark`: server 基准信息检测;  
  `redis-benchmark -h localhost -p 6379 -c 100 -n 100000`: 100个并发连接，100000个请求   
  `redis-benchmark --help`  

  * info  
  `redis-cli -h localhost -p 6380 info`  
  或者 redis-cli 交互模式下执行  info  
  key-field-value: 不管field有多少，Keyspace 的db0:keys 值始终是1;  
  重复的key db0:keys不算在内，即db0:keys的key都是不重复的;  
  重复的key 也不会增加内存, 即used_memory_human  

  * config
  config get *
  
  * client
  client list:  查看连接.

  * cursor  
  慎重使用 keys *,  scan cursor [MATCH pattern] [COUNT count]  
  scan 0 match *3* count 5:   匹配key包含3的  
  scan 444416 match *3*: 根据每次返回的cursor名字继续获取cursor;  
  
  * flush  
  `flushdb`: 删除当前数据库中的所有Key  
  `flushall`: 删除所有数据库中的key  
  
  * bigmap
  
  * eval, script
  eval "return {KEYS[1],KEYS[2],ARGV[1],ARGV[2]}" 2 a b 1 2   执行lua脚本.
  script flush: 清空Lua脚本缓存. 会导致首次执行 evalsha 失败.

## 监控 ##
  `java -jar redis-stat-0.4.14.jar --server --auth=leslie`

## sentinel ##
  * 文档  
  [redis 命令参考 - sentinel](http://doc.redisfans.com/topic/sentinel.html)  
  [Redis Sentinel 介绍与部署](https://blog.csdn.net/men_wen/article/details/72724406)

  * redis-cli -h 10.57.123.23 -p 23237:  连接到sentinel机器, 可以 info 查看信息.  
    sentinel masters: 查看master信息. 里面有 ip 和 port.  
    sentinel slaves mymaster:  查看slave信息. 查看 mymaster 这个master的slaves.  
    redis-cli -h {master-ip|salve-ip} -p {master-port|slave-port}: 连接某台redis. 可能需要auth {password}  
    scan 0 match \*3\* count 5: 正常使用redis命令.  

## 源码 ##
  * server.c 中的redisCommandTable中包含所有命令及实现，可以从此处入手.  
