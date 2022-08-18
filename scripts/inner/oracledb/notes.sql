SET TERMOUT ON;
SET SERVEROUTPUT ON;
SET ERRORLOGGING ON;
SET AUTOPRINT ON;
SET ECHO ON;
SET HEADING ON;

WHENEVER SQLERROR EXIT SQL.SQLCODE;

SELECT username, profile FROM dba_users WHERE username ='DOLPHIN';

CREATE PROFILE ocean LIMIT
    SESSIONS_PER_USER          UNLIMITED
    CPU_PER_SESSION            UNLIMITED
    CPU_PER_CALL               3000
    CONNECT_TIME               60;
ALTER USER dolphin
    PROFILE ocean;

CREATE ROLE super;
GRANT ALL PRIVILEGES TO super;
GRANT super TO dolphin;
ALTER USER dolphin DEFAULT ROLE super;
SELECT * FROM session_roles;

SET SQLFORMAT ANSICONSOLE;

SET HEADING OFF;
SELECT 'SELECT * FROM v$instance;' FROM DUAL;
SET HEADING ON;
--SELECT * FROM v$instance;
--SELECT instance_name, host_name, version, status FROM v$instance;

--SELECT * FROM v$statname;
--SELECT * FROM v$mystat;
--SELECT sn.statistic#, sn.name, ms.value
--    FROM v$statname sn
--    JOIN v$mystat ms
--    ON sn.statistic# = ms.con_id
--    WHERE sn.statistic# = 1;
--SELECT sn.statistic#, sn.name, COUNT(ms.value)
--    FROM v$statname sn
--    JOIN v$mystat ms
--    ON sn.statistic# = ms.con_id
--    WHERE sn.statistic# = 1
--    GROUP BY sn.statistic#, sn.name;
--DESCRIBE v$statname;

--SELECT DBMS_XDB_CONFIG.gethttpsport() FROM dual;

--DESCRIBE ecommerce.customers;
--INFO ecommerce.customers

--SELECT * FROM dba_tab_columns;
--SELECT count(*) FROM dba_tab_columns;

--ALTER SESSION SET CONTAINER=LOCAL_SQL_DEVELOPER;

--SELECT TABLE_NAME, TABLESPACE_NAME, CLUSTER_OWNER FROM user_tables;
--SELECT * FROM user_tables;

--SELECT * FROM all_tables;

--SELECT * FROM dba_tables;

SET TERMOUT OFF;
SET SERVEROUTPUT OFF;
SET ERRORLOGGING OFF;
SET AUTOPRINT OFF;
SET ECHO OFF;
SET HEADING OFF;