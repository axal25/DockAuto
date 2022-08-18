SET TERMOUT ON;
SET SERVEROUTPUT ON;
SET ERRORLOGGING ON;
SET AUTOPRINT ON;
SET ECHO ON;
SET HEADING ON;

-- Cluster > Catalog > Schema > Table > Columns & Rows

WHENEVER SQLERROR EXIT SQL.SQLCODE;
--WHENEVER SQLERROR CONTINUE NONE;

CREATE PLUGGABLE DATABASE LOCAL_SQL_DEVELOPER
    ADMIN USER localSqlDeveloper1 IDENTIFIED BY "localSqlDeveloper1password"
    DEFAULT TABLESPACE LOCAL_SQL_DEVELOPER_USERS
    DATAFILE '/home/oracle/oradata/localSqlDeveloper/local_sql_developer_users01.dbf'
    SIZE 250m AUTOEXTEND ON STORAGE (MAXSIZE 2G MAX_SHARED_TEMP_SIZE 1G)
    FILE_NAME_CONVERT=('/u02/app/oracle/oradata/ORCL/pdbseed/','/home/oracle/oradata/localSqlDeveloper/');

ALTER PLUGGABLE DATABASE LOCAL_SQL_DEVELOPER OPEN;

ALTER SESSION SET CONTAINER=LOCAL_SQL_DEVELOPER;
--alter session set current_schema

CREATE USER localSqlDeveloper2 IDENTIFIED BY "localSqlDeveloper2password";

-- GRANT CONNECT TO localSqlDeveloper1;
-- GRANT CREATE SESSION TO localSqlDeveloper1;
-- DBA - role: create, alter, destroy custom named types
-- GRANT CONNECT, RESOURCE, DBA TO localSqlDeveloper1;
-- GRANT CREATE SESSION GRANT ANY PRIVILEGE TO localSqlDeveloper1;
-- GRANT UNLIMITED TABLESPACE TO localSqlDeveloper1;
--GRANT
--      SELECT,
--      INSERT,
--      UPDATE,
--      DELETE
--    ON
--      schema.LOCAL_SQL_DEVELOPER_USERS
--    TO
--      localSqlDeveloper1;


GRANT ALL PRIVILEGES TO localSqlDeveloper1;
GRANT ALL PRIVILEGES TO localSqlDeveloper2;

ALTER USER localSqlDeveloper1 IDENTIFIED BY "localSqlDeveloper1password";
ALTER USER localSqlDeveloper2 IDENTIFIED BY "localSqlDeveloper2Password";

------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET CONTAINER=CDB$ROOT;

CREATE USER c##sqlDeveloper IDENTIFIED BY "c##sqlDeveloperPassword" CONTAINER=ALL;

GRANT ALL PRIVILEGES TO c##sqlDeveloper;

ALTER USER c##sqlDeveloper IDENTIFIED BY "c##sqlDeveloperPassword" CONTAINER=ALL;

------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET CONTAINER=CDB$ROOT;

CREATE PLUGGABLE DATABASE ecommerce
    ADMIN USER ecommerce IDENTIFIED BY "ecommerce_main_Pwd_1234567890"
    DEFAULT TABLESPACE ecommerce
    DATAFILE '/home/oracle/oradata/ecommerce/ecommerce.dbf'
    SIZE 250m AUTOEXTEND ON STORAGE (MAXSIZE 2G MAX_SHARED_TEMP_SIZE 1G)
    FILE_NAME_CONVERT=('/u02/app/oracle/oradata/ORCL/pdbseed/','/home/oracle/oradata/ecommerce/');

ALTER PLUGGABLE DATABASE ecommerce OPEN;

ALTER SESSION SET CONTAINER=ecommerce;

GRANT ALL PRIVILEGES TO ecommerce;

ALTER USER ecommerce IDENTIFIED BY "ecommerce_main_Pwd_1234567890";

CREATE USER ecommerceUser1 IDENTIFIED BY "ecommerceUser1_Pwd1234567890";

GRANT ALL PRIVILEGES TO ecommerceUser1;

ALTER USER ecommerceUser1 IDENTIFIED BY "ecommerceUser1_Pwd1234567890" CONTAINER=CURRENT;

COMMIT;

SET TERMOUT OFF;
SET SERVEROUTPUT OFF;
SET ERRORLOGGING OFF;
SET AUTOPRINT OFF;
SET ECHO OFF;
SET HEADING OFF;