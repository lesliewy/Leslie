* 安装.
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


* 安装好后，连接时出现mysql.sock找不到的问题，可能是不在my.cnf配置文件中指定的位置(默认为/tmp/mysql.cnf).  此时需要修改该配置文件，或者ln下.
  也可能是根本就没有了，此时可以ps -ef |grep mysql ,先kill 掉所有mysql的进程,然后重启: service mysqld restart. 就会生成sock文件。
  service 的配置文件: /lib/systemd/system/mysql.service
  sudo systemctl mysql start: 启动mysql的另一种方式.

* 不管是用改表法，还是授权法添加一个用户，都要flush privileges. 否则不生效.

* 有时mysql -ubookadm -p -h 127.0.0.1 :  后面的-h不能少，我也不知道为什么.否则登录不了. 添加-h 使用tcp/ip方式登录,
  否则使用socket方式登录. 参考: http://blog.sina.com.cn/s/blog_747f4c1d0102wbet.html
  -S: 指定使用的socket路径. 否则，使用配置文件(可能/etc/mysql/my.cnf)中的[client]的socket配置.
      否则，使用默认值: /var/run/mysqld/mysqld.sock


mysql:   mysql -h localhost -u root -p :       password:  mysql
service mysql start:  启动mysql;
use mysql:  使用哪个数据库.
show databases:
show tables:

alter database `mysql` default character set utf8 collate utf8_general_ci;   修改mysql 字符集
alter table LOT_MATCH convert to character set utf8;  修改表的字符集;
show create database mysql: 查看mysql 的字符集
show create table LOT_MATCH: 查看表的默认字符集;
/etc/mysql/conf.d/  新增 wy.cnf 添加 :
[mysqld]
character_set_server=utf8
参考:  http://bbs.konotes.org/thread-5638-1-1.html

source create_table.sql;   执行外部文件;

* mysql 备份.
mysqldump -u root -p mysql > 201009.sql;  备份整个数据库.
mysql -u root -p mysql < 201009.sql;   还原.   注意，不要用！！！  直接 source 201009.sql 来恢复

mysqldump -u root -p mysql TEST1 > TEST1.sql; 备份表 TEST1.
mysql -u root --password=mysql --database mysql < data/mysql/170118/ST_CONFIG.sql: 还原. 必须--password=mysql

* alter table LOT_KELLY_RULE change WIN_PROP WIN_PROB double;  修改列名, 由WIN_PROP 修改成 WIN_PROB.
alter table LOT_KELLY_CORP_RESULT change ODDS_CORP_NAME ODDS_CORP_NAME VARCHAR(50) NOT NULL;  修改 列的长度, 由20修改为50;

* show indexes from LOT_KELLY_CORP_RESULT;  查看表 LOT_KELLY_CORP_RESULT 的索引.
ALTER TABLE LOT_KELLY_CORP_RESULT DROP INDEX OK_URL_DATE;  删除索引;