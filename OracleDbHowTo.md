# Oracle Database how to

1. Connect to docker container's sqplus  
`$ docker exec -it $ORACLE_DB_CONTAINER_NAME bash -c "source /home/oracle/.bashrc; sqlplus /nolog"`  
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
`> quit`