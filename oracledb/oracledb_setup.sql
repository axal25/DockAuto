SELECT c.CON_ID, c.NAME, c.*
FROM V$CONTAINERS c
ORDER BY c.CON_ID, c.NAME;

SELECT db.CON_ID, db.NAME, db.*
FROM V$DATABASE db
ORDER BY db.CON_ID, db.NAME;

SHOW PDBS;

SELECT df.CON_ID, df.NAME, df.*
FROM V$DATAFILE df
ORDER BY df.CON_ID, df.name;

SELECT tf.CON_ID, tf.NAME, tf.*
FROM V$TEMPFILE tf
ORDER BY tf.CON_ID;

SELECT c.NAME,
       db.NAME,
       df.NAME,
       tf.NAME,
       c.DBID,
       db.DBID,
       c.CON_ID,
       df.CON_ID,
       tf.CON_ID
FROM V$CONTAINERS c
         LEFT JOIN V$DATABASE db ON c.DBID = db.DBID
         JOIN V$DATAFILE df ON c.CON_ID = df.CON_ID
         JOIN V$TEMPFILE tf ON c.CON_ID = tf.CON_ID
ORDER BY c.CON_ID, c.NAME;
ALTER USER SYS IDENTIFIED BY password;

CREATE TABLE region_types
(
    id   number(3)    NOT NULL,
    type varchar2(50) NOT NULL,
    CONSTRAINT region_types_pk PRIMARY KEY (id)
);

INSERT ALL INTO region_types
VALUES (0, 'VOIVODESHIP')
INTO region_types
VALUES (1, 'STATE')
SELECT 1
FROM DUAL;

!echo "from inside of oracledb_setup.sql"
