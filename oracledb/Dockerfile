# base image
FROM store/oracle/database-enterprise:12.2.0.1

USER root

RUN yum -y update \
	&& yum -y install git \
	&& yum clean all
# RUN yum -y install git
RUN /usr/bin/ol_yum_configure.sh

# Passed in oracledb_outer_build_and_run_docker.sh as "--build-arg"
ARG SETUP_DIR_PATH_FWD_SLASH_ENDED="/not_exitsting_folder/should_be_passed_from/oracledb_outer_build_and_run_docker.sh/as/--build-arg"

WORKDIR $SETUP_DIR_PATH_FWD_SLASH_ENDED

# Overriding ENTRYPOINT seems to also CMD
# Even though ENTRYPOINT is originally null 
ENTRYPOINT ["./oracledb_inner_entrypoint.sh"]
CMD ["/bin/sh", "-c", "/bin/bash /home/oracle/setup/dockerInit.sh"]

COPY copied_from/common/common_outer_shell_functions.sh $SETUP_DIR_PATH_FWD_SLASH_ENDED
COPY copied_from/oracledb/oracledb_outer_vars.env $SETUP_DIR_PATH_FWD_SLASH_ENDED

COPY oracledb_inner_vars.env $SETUP_DIR_PATH_FWD_SLASH_ENDED
COPY oracledb_inner_users.env $SETUP_DIR_PATH_FWD_SLASH_ENDED
COPY oracledb_inner_paths.env $SETUP_DIR_PATH_FWD_SLASH_ENDED
COPY oracledb_inner_entrypoint.sh $SETUP_DIR_PATH_FWD_SLASH_ENDED

COPY oracledb_inner_setup.sh $SETUP_DIR_PATH_FWD_SLASH_ENDED
COPY oracledb_inner_try_service.sh $SETUP_DIR_PATH_FWD_SLASH_ENDED
COPY oracledb_inner_change_sys_password_from_default.sh $SETUP_DIR_PATH_FWD_SLASH_ENDED
COPY oracledb_inner_sql_setup.sh $SETUP_DIR_PATH_FWD_SLASH_ENDED

COPY oracledb_setup.sql $SETUP_DIR_PATH_FWD_SLASH_ENDED

RUN source "${SETUP_DIR_PATH_FWD_SLASH_ENDED}oracledb_inner_paths.env" \
	&& mkdir -p $SETUP_TMP_DIR_PATH \
	&& chmod 777 $SETUP_TMP_DIR_PATH

# CMD has already access to entry point so do not need source
# CMD 'mkdir -p $SETUP_TMP_DIR_PATH';
# CMD 'chmod 777 $SETUP_TMP_DIR_PATH';

USER oracle

RUN echo "ORACLE Database - Dockerfile finished sucessfully"
