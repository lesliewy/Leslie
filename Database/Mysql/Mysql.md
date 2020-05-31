* Linux安装.
  http://dev.mysql.com/downloads/mysql/:  下载.  mysql-server_5.7.17-1ubuntu16.04_amd64.deb-bundle.tar  解压后得到组件包.

 方式一(多个pakcage.):
    sudo dpkg -i mysql-community-server_5.7.17-1ubuntu16.04_amd64.deb:  直接安装报错:
    Unpacking mysql-community-server (5.7.17-1ubuntu16.04) ...
    dpkg: dependency problems prevent configuration of mysql-community-server:
     mysql-community-server depends on mysql-common (>= 5.7.17-1ubuntu16.04); however:
      Package mysql-common is not installed.
     mysql-community-server depends on mysql-client (= 5.7.17-1ubuntu16.04); however:
      Package mysql-client is not installed.
     mysql-community-server depends on libmecab2 (>= 0.996-1.2ubuntu1); however:
      Package libmecab2 is not installed.

    正确顺序: 
     dep包:
        sudo dpkg -i mysql-common_5.7.17-1ubuntu16.04_amd64.deb
        sudo dpkg -i mysql-community-client_5.7.17-1ubuntu16.04_amd64.deb
        sudo dpkg -i mysql-client_5.7.17-1ubuntu16.04_amd64.deb
        sudo apt-get install libmecab2：  会提示创建root用户密码.
        sudo dpkg -i mysql-community-server_5.7.17-1ubuntu16.04_amd64.deb
        mysql -u root -p:  使用root登录.  
     
     rpm包:
        sudo rpm -ivh mysql-comunity-commonxxx.rpm
         
         
  
   方式二(官方安装包, 全量):
      使用官方安装包: mysql-5.7.29-el7-x86_64.tar.gz
      直接解压使用.
      配置my.cnf;
      rpm -qa|grep libaio: 确认是否安装libaio;
      yum install  libaio-devel.x86_64;
      mkdir data;  mkdir log;  确保my.cnf 中的datadir, log 等目录存在.
      ./bin/mysqld --initialize-insecure --user=tdops --basedir=/data01/spartan/mysql/mysql-5.7.29-el7-x86_64 --datadir=/data01/spartan/mysql/mysql-5.7.29-el7-x86_64/data: 先初始化一些mysql运行必须的表等数据, 每个mysql数据库只执行一次. 
          如果 datadir 指定的目录中存在数据，执行会报错.
      ./bin/mysqld_safe --defaults-file=/data01/spartan/mysql/mysql-5.7.29-el7-x86_64/conf/my.cnf &   启动;
      /data01/spartan/mysql/mysql-5.7.29-el7-x86_64/bin/mysql --defaults-file=/data01/spartan/mysql/mysql-5.7.29-el7-x86_64/conf/my.cnf -u root -p  连接mysql
      kill mysql:  kill 掉 bin/mysqld,  而不是 bin/mysqld_safe
      
      确保安全，最好用mysql用户初始化:
          sudo groupadd mysql;
          sudo useradd -r -g mysql mysql;
          my.cnf 修改;
          sudo chmod -R 755 /usr/local/mysql    
          sudo chown -R mysql:mysql /usr/local/mysql   修改mysql 安装包、datadir log 目录权限.   这里将包解压到 /usr/local/mysql,  其下有datadir
          sudo  ./bin/mysqld --initialize-insecure  --user=mysql 
          
   
   方式三:
      rpm -ivh https://repo.mysql.com//mysql80-community-release-el7-3.noarch.rpm:  先安装源.  参数可以是url也可以是文件.
           安装了 /etc/yum.repos.d/ 目录下.    rpm -e 卸载时也是到这里找文件删除.
      

* Mac 安装.
  Tar.gz 方式安装:  解压至 /usr/local/mysql;  添加PATH;   mysqld: 启动
  root@localhost: fwgZapkk9R-P   -> root/root
  mysql --help|grep cnf:   查看配置文件路径及优先级.

* 安装后操作: 
   mysql -u root -p:  root 登录.
   CREATE DATABASE IF NOT EXISTS wy DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
   CREATE USER 'wy1'@'%' IDENTIFIED BY 'wy1_123456';
   GRANT ALL ON wy.* TO 'wy1'@'%';
   flush privileges;
   
* mysql 重新初始化
   停止mysql;
   删除my.cnf中datadir 指定目录下所有内容.
   sudo  ./bin/mysqld --initialize-insecure  --user=mysql 

* 权限
   show grants for 'replica'@'%';  查看 'replica'@'%' 拥有的权限.


* 修改root密码
   mysqld_safe --skip-grant-tables --skip-networking &
   mysql -u root
   update mysql.user set authentication_string=password('123qwe') where user='root':   修改密码, 5.7以前authentication_string 叫password
   flush privileges;
   quit;
   
   mysql8 中密码加密规则改变, 可能报错: ERROR 2059 (HY000): Authentication plugin 'caching_sha2_password' cannot be loaded:
   ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

* 安装好后，连接时出现mysql.sock找不到的问题，可能是不在my.cnf配置文件中指定的位置(默认为/tmp/mysql.cnf).  此时需要修改该配置文件，或者ln下.
  也可能是根本就没有了，此时可以ps -ef |grep mysql ,先kill 掉所有mysql的进程,然后重启: service mysqld restart. 就会生成sock文件。
  service 的配置文件: /lib/systemd/system/mysql.service
  sudo systemctl mysql start: 启动mysql的另一种方式.

* 不管是用改表法，还是授权法添加一个用户，都要flush privileges. 否则不生效.

* 有时mysql -ubookadm -p -h 127.0.0.1 :  后面的-h不能少，我也不知道为什么.否则登录不了. 添加-h 使用tcp/ip方式登录,
  否则使用socket方式登录. 参考: http://blog.sina.com.cn/s/blog_747f4c1d0102wbet.html
  -S: 指定使用的socket路径. 否则，使用配置文件(可能/etc/mysql/my.cnf)中的[client]的socket配置.
      否则，使用默认值: /var/run/mysqld/mysqld.sock

* Default options are read from the following files in the given order:
/etc/my.cnf /etc/mysql/my.cnf /usr/local/mysql/etc/my.cnf ~/.my.cnf

mysql:   mysql -h localhost -u root -p :       password:  mysql
service mysql start:  启动mysql;
use mysql:  使用哪个数据库.
show databases:
show tables:

status: 查看当前数据库
select database(): 查看当前数据库.
show table status \G:  查看表状态. show table status like 'user' \G


create user 'leslie' identified by 'leslie';  创建用户.
select * from mysql.user; 查看创建的用户.


alter database `mysql` default character set utf8 collate utf8_general_ci;   修改mysql 字符集
alter table LOT_MATCH convert to character set utf8;  修改表的字符集;
show create database mysql: 查看mysql 的字符集
show create table LOT_MATCH: 查看表的默认字符集, 也可以用 show table status like 't1' \G 
/etc/mysql/conf.d/  新增 wy.cnf 添加 :
[mysqld]
character_set_server=utf8
参考:  http://bbs.konotes.org/thread-5638-1-1.html

source create_table.sql;   执行外部文件;

* mysql 交互环境
  select * \c  :   \c 可以清除当前输入，相当于^c, 但是\c 更安全些;  \c 只有在最后才有效
  \s : 相当于status
  \q : 相当于exit
  help:  查看支持的命令，如: \c  \G  \s ...
  help show: 
  help set:
  help alter:

* char varchar
  记住一个重要区别是: 插入char类型的字段末尾所有的空格都会被去掉，varchar 的不会;   前部空格都会保留. 可以通过 select concat('(', a, ')') 方法来查看空格.

* mysql 备份.
mysqldump -u root -p mysql > 201009.sql;  备份整个数据库.
mysql -u root -p mysql < 201009.sql;   还原.   注意，不要用！！！  直接 source 201009.sql 来恢复

mysqldump -u root -p mysql TEST1 > TEST1.sql; 备份表 TEST1.
mysql -u root --password=mysql --database mysql < data/mysql/170118/ST_CONFIG.sql: 还原. 必须--password=mysql
mysql -uroot -pmysql -e "select NOTION_NAME, CODE from ST_NOTION_STOCK where source='DFCF'" mysql >./b.data: 使用sql导出数据.

* 导入csv中数据到指定列.
load data local infile '/Users/leslie/a.csv' into table `st_table`  character set utf8 fields terminated by ','  optionally enclosed by '"' escaped by '"' LINES TERMINATED BY "\r\n" (`a`, `b`, `c`, `d`);

* alter table LOT_KELLY_RULE change WIN_PROP WIN_PROB double;  修改列名, 由WIN_PROP 修改成 WIN_PROB.
alter table LOT_KELLY_CORP_RESULT change ODDS_CORP_NAME ODDS_CORP_NAME VARCHAR(50) NOT NULL;  修改 列的长度, 由20修改为50;

* show indexes from LOT_KELLY_CORP_RESULT;  查看表 LOT_KELLY_CORP_RESULT 的索引.
  ALTER TABLE LOT_KELLY_CORP_RESULT DROP INDEX OK_URL_DATE;  删除索引;
  drop index a on t1: 删除索引;
  show keys from tblname;

* 锁
   show processlist: 查看连接情况.  kill id, 可以kill掉连接.
   show OPEN TABLES where In_use > 0;  查看打开的表的情况.
   select concat("kill ",trx_mysql_thread_id,";") as kill_id from information_schema.INNODB_TRX where trx_lock_structs=0 and trx_weight=0 and trx_rows_locked=0 and trx_rows_modified=0 and trx_state='RUNNING';
   select concat("kill ",b.ID,";") as kill_id from information_schema.INNODB_TRX a,information_schema.PROCESSLIST b where a.trx_mysql_thread_id=b.ID and a.trx_state='RUNNING' and b.TIME >=30;

* 隔离级别
   show variables like '%isolation%'
   SELECT @@tx_isolation:   两个都可以查看隔离级别.

* 优化
  explain select * from t where a = 1;   or  desc select * from t where a = 1;   两个一样的，查看执行计划.

* 主从复制.
  参考: http://blog.csdn.net/goustzhu/article/details/9339621

  master: cnf的mysqld域[mysqld]:
  server-id = 1
  log_bin        = /var/log/mysql/mysql-bin.log
  log_bin_index  = master_bin.index
  binlog_format  = mixed
  innodb_file_per_table = 1
  sudo service mysql restart; 登录后, show master status 
  增加同步的账户:
  CREATE USER 'rep@127.0.0.1' IDENTIFIED BY "rep147258";
  GRANT REPLICATION SLAVE ON *.* TO 'rep@192.168.1.100' identified by 'rep147258'; -- 这个不行.
  GRANT REPLICATION SLAVE ON *.* TO 'rep' identified by 'rep147258';

  slave: cnf的mysqld域[mysqld]:
  注释掉binlog, 开始relay-log:
  relay-log = relay-log
  relay-log-index = relay-log.index
  server-id = 2
  sudo service mysql restart;  show slave status 还没用东西，因为还没启动slave服务。
  slave mysql 下执行:
  CHANGE MASTER TO MASTER_HOST = '183.206.172.118', MASTER_PORT=3306, MASTER_USER='rep', MASTER_PASSWORD='rep147258', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS = 407;
  show slave status \G; 查看状态， 此时的
             Slave_IO_Running: No
            Slave_SQL_Running: No
  然后, start slave(对应的stop slave), 都正常情况下，显示:
            Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
  如果连接不上MASTER, 显示:
            Slave_IO_Running: Connecting
            Slave_SQL_Running: Yes

### 命令 ###
* show global variables;  查看mysql 全局变量.   
   explicit_defaults_for_timestamp: 时间戳相关.
  show create table t1: 查看t1的建表语句.

### 性能 ###  
  * [MySQL执行计划解读](https://www.cnblogs.com/zping/p/5368860.html)  


### 杂项 ###
  * 安装好后，连接时出现mysql.sock找不到的问题，可能是不在my.cnf配置文件中指定的位置(默认为/tmp/mysql.cnf).  此时需要修改该配置文件，或者ln下.  
  也可能是根本就没有了，此时可以ps -ef |grep mysql ,先kill 掉所有mysql的进程,然后重启: service mysqld restart. 就会生成sock文件。  

  * 不管是用改表法，还是授权法添加一个用户，都要flush privileges. 否则不生效.  

  * 有时mysql -ubookadm -p -h 127.0.0.1 :  后面的-h不能少，我也不知道为什么.否则登录不了.  







