# Oracle Database how to

1. Connect to docker container's sqplus  
`$ docker exec -it "$v_oracle_db_container_name" bash -c "source /home/oracle/.bashrc; sqlplus /nolog"`  
Orignally  
`$ docker exec -it oracledbcontainer bash -c "source /home/oracle/.bashrc; sqlplus /nolog"`
1. Connect as user sys  
`> CONNECT sys AS sysdba`  
and enter password
    1. Oracle default password `Oradoc_db1`
    1. This configuration default password `OracleDatabasePassword12345678`)
1. Try seeing added table  
`SELECT * FROM region_types;`
1. To quit connection to docker container's sqlplus  
`> quit`# Oracle Database how to

### OracleDb course information

#### SQL Statements in SQL Language
##### SQL Queries vs. DML vs. DDL
SQL Queries - retrieve data
DML Commands - Data Modification Language - modify existing data (insert, update, delete) 
DDL Commands - Data Definition Language - create new objects (create)

#### Frequent problems
`DROP TABLE ORA-00054: resource busy and acquire with NOWAIT specified or timeout expired` \
Cause: DML (insert/delete/update) \
Fix: add COMMIT \
Free session using:
```
SELECT
O.OBJECT_NAME,
S.SID,
S.SERIAL#,
P.SPID,
S.PROGRAM,
SQ.SQL_FULLTEXT,
S.LOGON_TIME
FROM
V$LOCKED_OBJECT L,
DBA_OBJECTS O,
V$SESSION S,
V$PROCESS P,
V$SQL SQ
WHERE
L.OBJECT_ID = O.OBJECT_ID
AND L.SESSION_ID = S.SID
AND S.PADDR = P.ADDR
AND S.SQL_ADDRESS = SQ.ADDRESS;

--alter system kill session 'SID,SERIAL#';

--alter system kill session '25,30853';
```

`SELECT * FROM V$SESSION WHERE STATUS = 'ACTIVE'`

```
select
c.owner,
c.object_name,
c.object_type,
b.sid,
b.serial#,
b.status,
b.osuser,
b.machine
from
v$locked_object a,
v$session b,
dba_objects c
where
b.sid = a.session_id
and
a.object_id = c.object_id;

--ALTER SYSTEM KILL SESSION 'sid,serial#';`

`--LOCK TABLE 'region_types';
```