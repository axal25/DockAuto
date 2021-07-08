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

!echo "from inside of oracledb_setup.sql"
