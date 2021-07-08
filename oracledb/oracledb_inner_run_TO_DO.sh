#!/bin/bash

cd /oracledb/setup/

source common_outer_shell_functions.sh

command_info "source oracledb_inner_vars.env"
source oracledb_inner_vars.env

command_info "source oracledb_inner_users.env"
source oracledb_inner_users.env

command_info "source oracledb_inner_paths.env"
source oracledb_inner_paths.env

section_info "WORKS TO THIS POINT"

creds1="sys/Oradoc_db1@localhost"
creds2="sys/Oradoc_db1@ORCLCDB.localdomain"
creds3="sys/Oradoc_db1@ORCLCDB"

command_info "Create execute function"

execute() {
  # param 1 is $1 - username
  # param 2 is $2 - password
  # param 3 is $3 - schema
  # param 4 is $4 - script
  sqlplus -S /nolog <<EOF

WHENEVER SQLERROR EXIT SQL.SQLCODE;
SET ECHO OFF
SET HEADING OFF
SET HEAD OFF
SET AUTOPRINT OFF
SET TERMOUT OFF
SET SERVEROUTPUT ON

CONNECT $1/$2@$3;
$4

EXIT;
EOF
}

command_info "execute \$USERNAME_SYS \$PASSWORD_SYS \$SCHEMA_SYS /oracledb_setup.sql"

execute $USERNAME_SYS $PASSWORD_SYS $SCHEMA_SYS /oracledb_setup.sql

# sqlplus sys/sys@PDB as sysdba
# sqlplus sys/Oradoc_db1@ORCLCDB as sysdba
# lsnrctl status
# sqlplus / as sysdba
# source /home/oracle/.bashrc
# sqlplus /oracledb_setup.sql
# sqlplus sys/Oradoc_db1 AS SYSDBA

# https://stackoverflow.com/questions/21183088/how-can-i-wait-for-a-docker-container-to-be-up-and-running
# https://dzone.com/articles/creating-an-oracle-database-docker-image

echo "original runsql"

creds="sys/Oradoc_db1"
host1='localhost'
host2='ORCLCDB.localdomain'
host3='ORCLCDB'

runsqlorig1() {
  # param 1 is $1
  sqlplus -S /nolog <<EOF
  CONNECT $1@host1;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  $2
  exit;
EOF
}

command_info "runsqlorig1()"

runsqlorig1 "$creds" "SHOW PDBS;"

runsqlorig2() {
  # param 1 is $1
  sqlplus -S /nolog <<EOF
  CONNECT $1@host2;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  $2
  exit;
EOF
}

command_info "runsqlorig2()"

runsqlorig2 "$creds" "SHOW PDBS;"

runsqlorig3() {
  # param 1 is $1
  sqlplus -S /nolog <<EOF
  CONNECT $1@host3;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  $2
  exit;
EOF
}

command_info "runsqlorig3()"

runsqlorig3 "$creds" "SHOW PDBS;"

section_info "myrunsql()"

myrunsql() {
  # param 1 is $1
  sqlplus -S /nolog <<EOF
  CONNECT $1;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  $2
  exit;
EOF
}

command_info "creds1"

myrunsql "$creds1" "SHOW PDBS;"

command_info "creds2"

myrunsql "$creds2" "SHOW PDBS;"

command_info "creds3"

myrunsql "$creds3" "SHOW PDBS;"

section_info "myrunsqlAsSysdba()"

myrunsqlAsSysdba() {
  # param 1 is $1
  sqlplus -S /nolog <<EOF
  CONNECT $1 as sysdba;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  $2
  exit;
EOF
}

command_info "creds1 as sysdba"

myrunsqlAsSysdba "$creds1" "SHOW PDBS;"

command_info "creds2 as sysdba"

myrunsqlAsSysdba "$creds2" "SHOW PDBS;"

command_info "creds3 as sysdba"

myrunsqlAsSysdba "$creds3" "SHOW PDBS;"

# docker exec -it oracledbcontainer bash -c "source /home/oracle/.bashrc; sqlplus /nolog"
# CONNECT sys/Oradoc_db1@ORCLCDB as sysdba

section_info "Static implementations"

command_info "@ORCLCDB.localdomain as sysdba"

sqlplus -S /nolog <<EOF
  CONNECT sys/Oradoc_db1@ORCLCDB.localdomain;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  SHOW PDBS;
  exit;
EOF

command_info "@ORCLCDB as sysdba"

sqlplus -S /nolog <<EOF
  CONNECT sys/Oradoc_db1@ORCLCDB as sysdba;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  SHOW PDBS;
  exit;
EOF

command_info "@localdomain as sysdba"

sqlplus -S /nolog <<EOF
  CONNECT sys/Oradoc_db1@localdomain as sysdba;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  SHOW PDBS;
  exit;
EOF

command_info "@localhost as sysdba"

sqlplus -S /nolog <<EOF
  CONNECT sys/Oradoc_db1@localhost as sysdba;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  SHOW PDBS;
  exit;
EOF

command_info "@ORCLCDB.localdomain as sysdba"

sqlplus -S /nolog <<EOF
  CONNECT sys/Oradoc_db1@ORCLCDB.localdomain as sysdba;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  SHOW PDBS;
  exit;
EOF

command_info "@ORCLCDB as sysdba"

sqlplus -S /nolog <<EOF
  CONNECT sys/Oradoc_db1@ORCLCDB as sysdba;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  SHOW PDBS;
  exit;
EOF

command_info "@localdomain as sysdba"

sqlplus -S /nolog <<EOF
  CONNECT sys/Oradoc_db1@localdomain as sysdba;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  SHOW PDBS;
  exit;
EOF

command_info "@localhost as sysdba"

sqlplus -S /nolog <<EOF
  CONNECT sys/Oradoc_db1@localhost as sysdba;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  SHOW PDBS;
  exit;
EOF

command_info "sys/Oradoc_db1@localhost:1521/ORCLCDB as sysdba"

sqlplus -S /nolog <<EOF
  CONNECT sys/Oradoc_db1@localhost:1521/ORCLCDB as sysdba;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  SHOW PDBS;
  exit;
EOF

command_info "sys/Oradoc_db1@localdomain:1521/ORCLCDB as sysdba"

sqlplus -S /nolog <<EOF
  CONNECT sys/Oradoc_db1@localdomain:1521/ORCLCDB as sysdba;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  SHOW PDBS;
  exit;
EOF

section_info "sys/Oradoc_db1@localhost:1521/ORCLCDB.localdomain as sysdba"

command_info "CONNECT $USERNAME_SYS/$PASSWORD_SYS@$HOST/$SCHEMA_SYS.$DOMAIN AS $ROLE_SYS >>> @/oracledb_setup.sql"

sqlplus -S /nolog <<EOF
  CONNECT $USERNAME_SYS/$PASSWORD_SYS@$HOST/$SCHEMA_SYS.$DOMAIN AS $ROLE_SYS;
  whenever sqlerror exit sql.sqlcode;
  set echo off
  set heading off
  @/oracledb_setup.sql
  exit;
EOF
