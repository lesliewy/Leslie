DB2 CREATE DATABASE MYDB2 
DFT_EXTENT_SZ 4
CATALOG TABLESPACE MANAGED BY DATABASE USING
   (FILE 'c:\MyInstall\IBM\DB2\mydatabases\db2data\' 2000)
   EXTENTSIZE 8 PREFETCHSIZE 16
TEMPORARY TABLESPACE MANAGED BY SYSTEM USING
   ('c:\MyInstall\IBM\DB2\mydatabases\tempts\')
USER TABLESPACE MANAGED BY DATABASE USING
   (FILE 'c:\MyInstall\IBM\DB2\mydatabases\ts\USERTS.DAT' 1200)
   EXTENTSIZE 24 PREFETCHSIZE 48