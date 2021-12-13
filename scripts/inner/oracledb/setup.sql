SET TERMOUT ON;
SET SERVEROUTPUT ON;
SET ERRORLOGGING ON;
SET AUTOPRINT ON;
SET ECHO ON;
SET HEADING ON;

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

CREATE USER localSqlDeveloper2 IDENTIFIED BY localSqlDeveloper2password;

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

ALTER USER localSqlDeveloper1 IDENTIFIED BY localSqlDeveloper1password;
ALTER USER localSqlDeveloper2 IDENTIFIED BY localSqlDeveloper2Password;

------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET CONTAINER=CDB$ROOT;

CREATE USER c##sqlDeveloper IDENTIFIED BY c##sqlDeveloperPassword CONTAINER=ALL;

GRANT ALL PRIVILEGES TO c##sqlDeveloper;

ALTER USER c##sqlDeveloper IDENTIFIED BY c##sqlDeveloperPassword CONTAINER=ALL;

------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET CONTAINER=CDB$ROOT;

CREATE PLUGGABLE DATABASE ECOMMERCE
    ADMIN USER ecommerceUser IDENTIFIED BY "ecommercePwd1234567890"
    DEFAULT TABLESPACE ECOMMERCE
    DATAFILE '/home/oracle/oradata/ecommerce/ecommerce_users01.dbf'
    SIZE 250m AUTOEXTEND ON STORAGE (MAXSIZE 2G MAX_SHARED_TEMP_SIZE 1G)
    FILE_NAME_CONVERT=('/u02/app/oracle/oradata/ORCL/pdbseed/','/home/oracle/oradata/ecommerce/');

ALTER PLUGGABLE DATABASE ECOMMERCE OPEN;

ALTER SESSION SET CONTAINER=ECOMMERCE;

GRANT ALL PRIVILEGES TO ecommerceUser;

ALTER USER ecommerceUser IDENTIFIED BY ecommercePwd1234567890;

COMMIT;

SET TERMOUT OFF;
SET SERVEROUTPUT OFF;
SET ERRORLOGGING OFF;
SET AUTOPRINT OFF;
SET ECHO OFF;
SET HEADING OFF;