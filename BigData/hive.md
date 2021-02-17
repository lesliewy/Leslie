## 命令
  * hdfs dfs -du -h /user/hive/warehouse: 各个hive表在hdfs上文件的大小.
  * SELECT from_unixtime(a.CREATE_TIME) create_t, from_unixtime(a.LAST_ACCESS_TIME) last_access_t, a.*, b.* FROM TBLS a, TABLE_PARAMS b 
    where a.TBL_ID = b.TBL_ID 
          and PARAM_KEY = 'totalSize' 
    order by CAST(PARAM_VALUE as SIGNED) desc limit 10;
     通过mysql 中 hive metadata 查看表大小.
     
     
  
