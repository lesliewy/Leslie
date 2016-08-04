-------------------------------------------------------oracle sql---------------------------------------------------------------------
--查询被锁的表1
SELECT A.OWNER,A.OBJECT_NAME,B.XIDUSN,B.XIDSLOT,B.XIDSQN,B.SESSION_ID,B.ORACLE_USERNAME,B.OS_USER_NAME,B.PROCESS,
       B.LOCKED_MODE,C.MACHINE,C.STATUS,C.SERVER,
       C.SID,C.SERIAL#,    -- kill this
       C.PROGRAM
  FROM ALL_OBJECTS A, V$LOCKED_OBJECT B, SYS.GV_$SESSION C
 WHERE ( A.OBJECT_ID = B.OBJECT_ID )
       AND (B.PROCESS = C.PROCESS )
       ORDER BY 1, 2

-- 查询被锁的表2
  select a.oracle_username,c.object_name,a.session_id,a.os_user_name,a.process,b.type,b.id1,b.id2,b.lmode,b.request,b.block
  from v$locked_object a,v$lock b,all_objects c
  where a.session_id=b.sid
        and a.object_id=c.object_id
   -- 找阻塞其他session的sql,从上面查出block=1的session_id,作为下面的查询条件.
      select s.sid,s.serial#,a.sql_fulltext
        from v$sqlarea a, v$session s
      where s.prev_sql_addr = a.address and s.sid=?;
   -- 找被阻塞的sql,先找出block=0的session_id,作为下面的查询条件.
      select s.sid,s.serial#,a.sql_fulltext
        from v$sqlarea a, v$session s
      where s.sql_address = a.address and s.sid=?

-- 查询正在执行的sql
SELECT   /*+ ORDERED */ sql_fulltext,b.sid,b.process
    FROM v$sql a,(select DECODE (sql_hash_value,0, prev_hash_value,sql_hash_value) sql_hash_value,
                         DECODE (sql_hash_value, 0, prev_sql_addr, sql_address) sql_address,
                         sid,process from v$session) b
   where a.hash_value=b.sql_hash_value
         and a.address = b.sql_address;    -- 可以添加 b.sid='152' 查看sid是152正在执行的sql.
-- v$session & v$process
select s.sid,s.username,p.pid,p.spid,p.program from v$session s ,v$process p where s.paddr=p.addr;  --查看系统进程,在windows中spid和任务管理器中的不匹配.





-- 释放被锁的表, 
alter system kill session 'sid, serial#';   

alter system kill session '281, 38854'
alter system kill session '374, 6938'

-- 当前连接的session, username is null的是oracle本身的.
select * from v$session where username is not null;


-- 查看 表空间使用情况 1:
SELECT Total.name "Tablespace Name",  Free_space, (total_space-Free_space) Used_space, total_space  
  FROM  (select tablespace_name, sum(bytes/1024/1024) Free_Space
           from sys.dba_free_space
                group by tablespace_name) Free,
        (select b.name, sum(bytes/1024/1024) TOTAL_SPACE
           from sys.v_$datafile a, sys.v_$tablespace B
          where a.ts# = b.ts#
                group by b.name
        ) Total
 WHERE Free.Tablespace_name = Total.name
 -- 查看 表空间使用情况 2：
 select dbf.tablespace_name,  
        dbf.totalspace "总量(M)",  
        dbf.totalblocks as 总块数,  
        dfs.freespace "剩余总量(M)",  
        dfs.freeblocks "剩余块数",  
        (dfs.freespace / dbf.totalspace) * 100 "空闲比例"  
   from (select t.tablespace_name,  
                sum(t.bytes) / 1024 / 1024 totalspace,  
                sum(t.blocks) totalblocks  
           from dba_data_files t  
                group by t.tablespace_name) dbf,  
        (select tt.tablespace_name,  
                sum(tt.bytes) / 1024 / 1024 freespace,  
                sum(tt.blocks) freeblocks  
           from dba_free_space tt  
                group by tt.tablespace_name) dfs  
   where trim(dbf.tablespace_name) = trim(dfs.tablespace_name)

-- 查看 表空间文件 datafile
select * from sys.v_$datafile a , sys.v_$tablespace b where a.ts#=b.ts# and b.name='URMTOPLG_TABLESPACE_01';
-- 查看 表空间: file_name,是否支持自动扩展(autoextensible),increment_by
select * from dba_data_files where file_name='/oradata/motion/PAY/URMTOPLG_TABLESPACE_01.dbf';
-- 增加 表空间文件大小
alter tablespace URMTOPLG_TABLESPACE_01 add datafile 'd:/oracle/oradata/scut/date03.dbf' size 50m;
-- 修改表空间文件大小：在已有的文件上修改.
alter database datafile '/oradata/motion/PAY/URMTOPLG_TABLESPACE_01.dbf' resize 15m;
-- 移动表空间数据文件 1:
   -- 确定文件处于的表空间：
   select tablespace_name from dba_data_files where file_name ='D:/ORACLE/ORADATA/DATE03.DBF';
   -- 使表空间脱机：
   alter tablespace date01 offline;
   -- 使用OS命令移动文件：
   move d:/oracle/oradata/scut/date03.dbf d:/oracle/ora92/;
   -- 执行Alter dataspace命令，必须确保文件被移动了：
   alter tablespace date01 rename datafile 'd:/oracle/oradata/scut/date03.dbf' to 'd:/oracle/ora92/date03.dbf';
   -- 使表空间联机：
   alter tablespace date01 online;
-- 移动表空间数据文件 2：
   -- 在MOUNT状态下移动数据文件。在MOUNT状态下，可以移动任何数据文件，包括SYSTEM和UNDO表空间。它使用的命令是alter database
   -- 关闭数据库
   Shutdown immediate
   Startup mount
   -- 移动数据
   move d:/oracle/oradata/scut/date03.dbf d:/oracle/ora92/;
   -- 执行alter database
   Alter database date01 renam file 'd:/oracle/oradata/scut/date03.dbf' to 'd:/oracle/ora92/date03.dbf'
   -- 打开数据库
   Alter database open

-- 授权 与 收回.
   -- 查看当前用户权限.
   select * from user_sys_privs;     select * from dba_sys_privs; -- 所有用户权限.
   -- 授权  表权限.
   grant select on table mkmtact to leslie1;
   -- 收回权限.
   revoke create table from leslie1;     

    




--------------------------------------------------Optimization----------------------------------------------------------------
--110825 lj  sql 查询内部帐户明细  BUI0100330
select count(*) from ACMTINDT;  -- 93839
select count(*) from ACMTINIF;  -- 229
select count(*) from ACMTITEM;  -- 60 
select count(*) from ACMTITMR;  -- 42
select * from ACMTINDT;
--original
/* 
alter table PAYADM.ACMTINDT add constraint ACMTINDT_PK primary key (SYS_DT, JRN_NO, JRN_SEQ);
-- Create/Recreate indexes 
create index PAYADM.ACMTINDT_NI1 on PAYADM.ACMTINDT (OLD_TX_DT, AC_NO, CAP_TYP);
create index PAYADM.ACMTINDT_NI2 on PAYADM.ACMTINDT (AC_DT, IN_AC_TYP, CAP_TYP);
create index PAYADM.ACMTINDT_NI3 on PAYADM.ACMTINDT (AC_NO, CAP_TYP, SYS_DT);
create index PAYADM.ACMTINDT_NI4 on PAYADM.ACMTINDT (AC_NO, CAP_TYP, AC_DT);
create unique index PAYADM.ACMTINDT_UI1 on PAYADM.ACMTINDT (AC_DT, JRN_NO, JRN_SEQ);
*/
SELECT C.AC_DT,C.AC_NO,C.CAP_TYP,C.IN_CAP_STS,C.TX_TYP,C.IN_AC_TYP,
       SUM(C.DR_AMT) DR_AMT,SUM(C.CR_AMT) CR_AMT,C.ORD_TYP,D.AC_NM
  FROM ACMTINDT C,ACMTINIF D,ACMTITEM A,ACMTITMR B
 WHERE   (C.AC_NO LIKE '3031004%' OR '3031004' IS NULL)  ---3031004
       AND  (C.AC_DT >= '20110301' OR '20110301' IS NULL) AND (C.AC_DT <= '20110401' OR '20110401' IS NULL)
       AND  C.IN_AC_TYP IN  B.AC_TYP
       AND  A.ITM_NO = B.ITM_NO
       AND  (B.ITM_NO = '' OR '' IS NULL)
       AND  C.CAP_TYP = '1'
       AND  C.IN_CAP_STS != '1'
       AND  C.AC_NO = D.AC_NO(+)
       GROUP BY C.AC_DT, C.AC_NO, C.CAP_TYP, C.IN_CAP_STS, C.TX_TYP, C.ORD_TYP,C.IN_AC_TYP,D.AC_NM
       ORDER BY C.AC_DT DESC,C.AC_NO
 
--/*+ USE_NL(d c)*/   /*+ USE_MERGE(C D)*/
SELECT C.AC_DT,C.AC_NO,C.CAP_TYP,C.IN_CAP_STS,C.TX_TYP,
       SUM(C.DR_AMT) DR_AMT,SUM(C.CR_AMT) CR_AMT ,D.AC_NM
  FROM ACMTINDT C,ACMTINIF D ,ACMTITEM A,ACMTITMR B
 WHERE   (C.AC_NO LIKE '3031004' OR '3031004' IS NULL)  ---3031004
       AND  (C.AC_DT >= '20110301' OR '20110301' IS NULL) AND (C.AC_DT <= '20110401' OR '20110401' IS NULL)
       AND  C.IN_AC_TYP IN  B.AC_TYP
       AND  A.ITM_NO = B.ITM_NO
       AND  (B.ITM_NO = '' OR '' IS NULL)
       AND  C.CAP_TYP = '1'
       AND  C.IN_CAP_STS != '1'
       AND  C.AC_NO = D.AC_NO(+)
       GROUP BY C.AC_DT, C.AC_NO, C.CAP_TYP, C.IN_CAP_STS, C.TX_TYP ,D.AC_NM
       ORDER BY C.AC_DT DESC,C.AC_NO
       
       
       select * from acmtindt where sys_dt='20110301' and jrn_no='1' and jrn_seq='2';

------------------------------------------------------------PL/SQL--------------------------------------------------------------------------
-- *** 往t1表中插入数据.
--programe window 中创建存储过程:
create or replace procedure insert1(v_index in number) is
temp_id number;
begin
  for i in 1..v_index loop
     insert into t1(msg_cd,err_cnl,sms_cd,msg_dat,rmk,upd_dt,upd_tlr)
     values(i,'abc','abcde','payadm测试','test','20111206','oper001');
     if (i mod 1000 = 0) then
        begin
          commit;
        end;
     end if;
  end loop;
  commit;
end insert1;

--sql window 中执行创建的存储过程: insert1 
begin 
  insert1(500);
end;
-- *** 可以向下面那样创建一个匿名的过程. 但是如果是匿名的过程，不能在sql window 中执行,执行了也看不到输出结果,但是可以在sqlplus中执行.  
begin
   dbms_output.put_line('hello,world');  -- 这个 ; 是必须的，否则编译时报语法错误.
end;       -- 这个 ; 是必须的，否则报语法错误.
/          -- 表示脚本编写结束, 会自动编译，执行.  这个在sql*plus命令行中有用.
-- exec p1 ; exec p1(); call p1();   这3个都可以,但是不可用 call p1  , 这是错误的.
create or replace procedure p1 is
begin
   dbms_output.put_line('hello,everyone.');
   dbms_output.put_line('hello,leslie.');
end;


