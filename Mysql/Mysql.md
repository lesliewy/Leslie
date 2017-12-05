* Linux安装.
  http://dev.mysql.com/downloads/mysql/:  下载.  mysql-server_5.7.17-1ubuntu16.04_amd64.deb-bundle.tar  解压后得到组件包.


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
   sudo dpkg -i mysql-common_5.7.17-1ubuntu16.04_amd64.deb
   sudo dpkg -i mysql-community-client_5.7.17-1ubuntu16.04_amd64.deb
   sudo dpkg -i mysql-client_5.7.17-1ubuntu16.04_amd64.deb
   sudo apt-get install libmecab2：  会提示创建root用户密码.
   sudo dpkg -i mysql-community-server_5.7.17-1ubuntu16.04_amd64.deb
   mysql -u root -p:  使用root登录.  

* Mac 安装.
  Tar.gz 方式安装:  解压至 /usr/local/mysql;  添加PATH;   mysqld: 启动
  root@localhost: fwgZapkk9R-P   -> root/root

* 修改root密码
   mysqld_safe --skip-grant-tables --skip-networking &
   mysql -u root
   update mysql.user set authentication_string=password('123qwe') where user='root':   修改密码, 5.7以前authentication_string 叫password
   flush privileges;
   quit;

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

* alter table LOT_KELLY_RULE change WIN_PROP WIN_PROB double;  修改列名, 由WIN_PROP 修改成 WIN_PROB.
alter table LOT_KELLY_CORP_RESULT change ODDS_CORP_NAME ODDS_CORP_NAME VARCHAR(50) NOT NULL;  修改 列的长度, 由20修改为50;

* show indexes from LOT_KELLY_CORP_RESULT;  查看表 LOT_KELLY_CORP_RESULT 的索引.
ALTER TABLE LOT_KELLY_CORP_RESULT DROP INDEX OK_URL_DATE;  删除索引;
show keys from tblname;

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








