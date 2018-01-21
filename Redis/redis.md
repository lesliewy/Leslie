## Mac安装
    解压后，cd src;   make install
    src/redis-server:  前台启动
    src/redis-cli:  连接
    redis-cli -h 127.0.0.1 -p 6378

## help
- redis-server --help: 显示帮助信息.
- redis-cli --help

## redis-benchmark
redis-benchmark: server 基准信息检测;
redis-benchmark -h localhost -p 6379 -c 100 -n 100000: 100个并发连接，100000个请求 
redis-benchmark --help

## info
- redis-cli -h localhost -p 6380 info 
- 或者 redis-cli 交互模式下执行  info
- key-field-value: 不管field有多少，Keyspace 的db0:keys 值始终是1;
- 重复的key db0:keys不算在内，即db0:keys的key都是不重复的;
- 重复的key 也不会增加内存, 即used_memory_human

## 命令
  慎重使用 keys *,  scan cursor [MATCH pattern] [COUNT count] 
  scan 0 match *3* count 5:   匹配key包含3的
  scan 444416 match *3*: 根据每次返回的cursor名字继续获取cursor;
  
  flushdb: 删除当前数据库中的所有Key
  flushall: 删除所有数据库中的key

## 监控
  java -jar redis-stat-0.4.14.jar --server --auth=leslie

## 源码
  * server.c 中的redisCommandTable中包含所有命令及实现，可以从此处入手.