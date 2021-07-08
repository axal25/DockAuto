# base image
FROM store/oracle/database-enterprise:12.2.0.1

USER root

RUN yum -y update \
	&& yum -y install git \
	&& yum clean all
# RUN yum -y install git
RUN /usr/bin/ol_yum_configure.sh

COPY copied_from/common/common_outer_shell_functions.sh /oracledb/setup/common_outer_shell_functions.sh
COPY copied_from/oracledb/oracledb_outer_vars.env /oracledb/setup/oracledb_outer_vars.env

COPY oracledb_inner_vars.env /oracledb/setup/oracledb_inner_vars.env
COPY oracledb_inner_users.env /oracledb/setup/oracledb_inner_users.env
COPY oracledb_inner_paths.env /oracledb/setup/oracledb_inner_paths.env

COPY oracledb_inner_run.sh /oracledb/setup/oracledb_inner_run.sh
COPY oracledb_inner_run_try_service.sh /oracledb/setup/oracledb_inner_run_try_service.sh
COPY oracledb_inner_run_change_sys_password_from_default.sh /oracledb/setup/oracledb_inner_run_change_sys_password_from_default.sh
COPY oracledb_inner_run_setup.sh /oracledb/setup/oracledb_inner_run_setup.sh

COPY oracledb_setup.sql /oracledb/setup/oracledb_setup.sql

COPY oracledb_inner_run_TO_DO.sh /oracledb/setup/oracledb_inner_run_TO_DO.sh

USER oracle

# /home/oracle/setup/dockerInit.sh
# ADD host/path/to/your/sql/your_sql_file.sql /docker-entrypoint-initdb.d/ # to be tested

RUN echo "ORACLE Database - Dockerfile finished sucessfully"
