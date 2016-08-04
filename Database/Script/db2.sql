-- 格式
select * from sndbusr.X_RUSH_PUR_ACT where  sndbusr.X_RUSH_PUR_ACT.RUSH_PUR_ACT_ID=21001; 
select * from X_RUSH_PUR_ACT where rush_pur_act_id=21001;  -- 用当前登录用户(yunwei)    等价于 select * from yunwei.x_rush_pur_act where yunwei.rush_pur_act.rush_pur_act_id=21001;
select * from SNDBUSR.X_RUSH_PUR_ACT where X_RUSH_PUR_ACT.RUSH_PUR_ACT_ID=21001;  -- where 条件后面的等价于yunwei.x_rush_pur_act.rush_pur_act_id
select * from SNDBUSR.X_RUSH_PUR_ACT where RUSH_PUR_ACT_ID=21001;  --  直接加column名字，默认就在 from 后面的表里的;   但是如果 column 前面加上表名，就成了上面的情况.
select * from sndbusr.X_RUSH_PUR_ACT where  sndbusr.X_RUSH_PUR_ACT.RUSH_PUR_ACT_ID=21001;

-- DATE & TIME 
SELECT CURRENT DATE FROM sysibm.dual;
select current time from sysibm.sysdummy1;
select current timestamp from sysibm.sysdummy1;
select current date  from sysibm.sysdummy1;
values current date;
values current TIMESTAMP;
values year(current TIMESTAMP)
SELECT 'HELLO DB2' FROM SYSIBM.DUAL;
SELECT TO_CHAR(TIMESTAMP('2012-5-25 21:18:12'),'YYYY-MM-DD HH24:MI:SS') FROM SYSIBM.DUAL;
select CURRENT TIMESTAMP from sysibm.dual;
values DAYNAME(current timestamp);
values TO_CHAR(TIMESTAMP('2012-5-25 21:18:12'),'YYYY-MM-DD HH24:MI:SS');
select 1+1 from sysibm.sysdummy1;
update SNDBUSR.X_RUSH_PUR_ACT set start_date=TO_CHAR(TIMESTAMP('2012-5-25 21:18:12'),'YYYY-MM-DD HH24:MI:SS') where X_RUSH_PUR_ACT.RUSH_PUR_ACT_ID='21001';
update SNDBUSR.X_RUSH_PUR_ACT set start_date=TIMESTAMP('2012-5-26 21:18:12') where X_RUSH_PUR_ACT.RUSH_PUR_ACT_ID='21001';

select current TIMESTAMP + 600 SECOND from sysibm.dual;
select current TIMESTAMP + 60 minute from sysibm.dual;

values time (current TIMESTAMP)
-- cdm -> db2cmd -> db2(db2命令行工具中):   ? sql206 查看sqlcode=206的错误详细信息.    db2 ? sql964

-- SQL - Function - Scalar FUNCTION
--      COALESCE 
--      和 NVL 相同;  field1 是null, 则取field2, 依此类推.
select  rush_pur_act_id,coalesce(field1,field2,'null value') field1 from sndbusr.X_RUSH_PUR_ACT;
    
    
 -- 特权
 -- table
 SELECT SUBSTR(grantor,1,8) as grantor, SUBSTR(grantee,1,8) AS grantee, granteetype as gtype, SUBSTR(tabschema,1,8) AS schema,SUBSTR(tabname,1,8) AS tabname,controlauth as ctl,
              alterauth AS alt,deleteauth AS del, indexauth AS idx, insertauth AS ins, selectauth AS sel, refauth AS ref,updateauth AS upd 
      FROM SYSCAT.TABAUTH 
    WHERE grantee='LESLIE';
    
 -- 表空间
 SELECT SUBSTR(tbsp_name,1,18) ,tbsp_type,tbsp_free_size_kb,tbsp_utilization_percent 
  FROM SYSIBMADM.TBSP_UTILIZATION;
 
 -- 缓冲池命中率
 SELECT SUBSTR(bp_name,1,12) total_hit_ratio_percent,data_hit_ratio_percent,index_hit_ratio_percent
   FROM SYSIBMADM.BP_HITRATIO;
 
 -- 执行成本最高的SQL
 SELECT agent_id,rows_selected,rows_read
   FROM SYSIBMADM.APPLICATION_PERFORMANCE;

--运行最长的SQL
SELECT elapsed_time_min,appl_status,agent_id 
  FROM SYSIBMADM.LONG_RUNNING_SQL
  ORDER BY ELAPSED_TIME_MIN DESC FETCH FIRST 5 ROWS ONLY;
  
  
  SELECT * 
  FROM SYSIBMADM.LONG_RUNNING_SQL
  ORDER BY ELAPSED_TIME_MIN DESC FETCH FIRST 5 ROWS ONLY;
  
-- SQL 准备和预编译时间最长的SQL
-- PERP_TIME_PERCENT: 准备查询时耗用的时间在查询执行时间中占用的比例. 一般是小值，但是要看执行次数. 高次数（但无需再次编译准备).
SELECT * FROM SYSIBMADM.QUERY_PREP_COST ORDER BY NUM_EXECUTIONS DESC;

-- 执行次数最多的SQL
-- TOP_DYNAMIC_SQL:  执行次数最多, 运行时间最长, 排序次数最多.
SELECT * FROM SYSIBMADM.TOP_DYNAMIC_SQL ORDER BY NUM_EXECUTIONS DESC FETCH FIRST 5 ROWS ONLY;


-- 引起锁等待的SQL
SELECT agent_id,substr(STMT_TEXT,1,100) AS statement,stmt_elapsed_time_ms
  FROM TABLE(SNAPSHOT_STATEMENT('MYDB1',-1)) AS B 
WHERE agent_id in (SELECT agent_id_holding_lk 
                                     FROM TABLE(SNAPSHOT_LOCKWAIT('MYDB1',-1)) AS A ORDER BY LOCK_WAIT_START_TIME ASC FETCH FIRST 20 ROWS ONLY) ORDER BY STMT_ELAPSED_TIME_MS DESC;

-- 查找创建的新对象
-- SYSCAT.TABLES  SYSCAT.INDEXES  SYSCAT.PROCEDURES 中   CREATE_TIME OWNER
SELECT * FROM SYSCAT.TABLES;

--查找无效对象
SELECT tabname FROM SYSCAT.TABLES WHERE status='X';
SELECT trigname FROM SYSCAT.TRIGGERS WHERE valid='N';
SELECT viewname FROM SYSCAT.VIEWS WHERE valid='N';


-- 没有统计信息的表
SELECT * FROM SYSCAT.TABLES WHERE stats_time is null or stats_time in ( '-1' );  -- 表 索引 都有  或者判断stats_time较长.


select * from sndbusr.x_RUSH_PUR_PROCESS 
where time(CAN_CART_TIME) > time('12:00:00')
and time(CAN_CART_TIME) < time('12:59:59')


-- drop column  需要 reorg? add column不需要?
-- -- data capture changes 的列无法删除,如果要drop column ,sql code是 270;  先设置为 data capture none.   必须要有schema(这个不一定).
alter table sndbusr.x_rush_pur_act data capture none;
alter table sndbusr.x_rush_pur_act data capture changes;
alter table sndbusr.x_rush_pur_act drop column promotion_code;

