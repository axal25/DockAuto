# base image
FROM store/oracle/database-enterprise:12.2.0.1

MAINTAINER Jacek Oleś <jacek.oles0925@gmail.com>

USER root

# Passed as "--build-arg"
ARG P_Container_Workdir="unset"
ARG P_Container_Workdir_Tmp="unset"
ARG F_Container_Workdir_Tmp_ChangePasswordOutput="unset"
ARG F_Container_Workdir_Tmp_DebugSetupOutput="unset"
ARG F_Container_Workdir_Tmp_EcommerceOutput="unset"
ARG F_Container_Workdir_Tmp_SetupOutput="unset"
ARG F_Container_Workdir_Tmp_UnSetupOutput="unset"
ARG F_Container_Workdir_Tmp_TryServiceOutput="unset"
ARG P_Copied="unset"
ARG F_PrintFunctions="unset"
ARG F_ContainerFiles="unset"
ARG F_DebugSetup="unset"
ARG F_Ecommerce="unset"
ARG F_Entrypoint="unset"
ARG F_RunSqlCommand="unset"
ARG F_Secrets="unset"
ARG F_Setup="unset"
ARG F_SetupContainer="unset"
ARG F_Tdddemo="unset"
ARG F_UnSetup="unset"
ARG F_Vars="unset"

ENV P_Container_Workdir="$P_Container_Workdir"
ENV P_Container_Workdir_Tmp="$P_Container_Workdir_Tmp"
ENV F_Container_Workdir_Tmp_ChangePasswordOutput="$F_Container_Workdir_Tmp_ChangePasswordOutput"
ENV F_Container_Workdir_Tmp_DebugSetupOutput="$F_Container_Workdir_Tmp_DebugSetupOutput"
ENV F_Container_Workdir_Tmp_EcommerceOutput="$F_Container_Workdir_Tmp_EcommerceOutput"
ENV F_Container_Workdir_Tmp_SetupOutput="$F_Container_Workdir_Tmp_SetupOutput"
ENV F_Container_Workdir_Tmp_UnSetupOutput="$F_Container_Workdir_Tmp_UnSetupOutput"
ENV F_Container_Workdir_Tmp_TryServiceOutput="$F_Container_Workdir_Tmp_TryServiceOutput"
ENV P_Copied="$P_Copied"
ENV F_PrintFunctions="$F_PrintFunctions"
ENV F_ContainerFiles="$F_ContainerFiles"
ENV F_DebugSetup="$F_DebugSetup"
ENV F_Ecommerce="$F_Ecommerce"
ENV F_Entrypoint="$F_Entrypoint"
ENV F_RunSqlCommand="$F_RunSqlCommand"
ENV F_Secrets="$F_Secrets"
ENV F_Setup="$F_Setup"
ENV F_SetupContainer="$F_SetupContainer"
ENV F_Tdddemo="$F_Tdddemo"
ENV F_UnSetup="$F_UnSetup"
ENV F_Vars="$F_Vars"

RUN echo "P_Container_Workdir: \"$P_Container_Workdir\""
RUN echo "P_Container_Workdir_Tmp: \"$P_Container_Workdir_Tmp\""
RUN echo "F_Container_Workdir_Tmp_ChangePasswordOutput: \"$F_Container_Workdir_Tmp_ChangePasswordOutput\""
RUN echo "F_Container_Workdir_Tmp_DebugSetupOutput: \"$F_Container_Workdir_Tmp_DebugSetupOutput\""
RUN echo "F_Container_Workdir_Tmp_EcommerceOutput: \"$F_Container_Workdir_Tmp_EcommerceOutput\""
RUN echo "F_Container_Workdir_Tmp_SetupOutput: \"$F_Container_Workdir_Tmp_SetupOutput\""
RUN echo "F_Container_Workdir_Tmp_UnSetupOutput: \"$F_Container_Workdir_Tmp_UnSetupOutput\""
RUN echo "F_Container_Workdir_Tmp_TryServiceOutput: \"$F_Container_Workdir_Tmp_TryServiceOutput\""
RUN echo "P_Copied: \"$P_Copied\""
RUN echo "F_PrintFunctions: \"$F_PrintFunctions\""
RUN echo "F_ContainerFiles: \"$F_ContainerFiles\""
RUN echo "F_DebugSetup: \"$F_DebugSetup\""
RUN echo "F_Ecommerce: \"$F_Ecommerce\""
RUN echo "F_Entrypoint: \"$F_Entrypoint\""
RUN echo "F_RunSqlCommand: \"$F_RunSqlCommand\""
RUN echo "F_Secrets: \"$F_Secrets\""
RUN echo "F_Setup: \"$F_Setup\""
RUN echo "F_SetupContainer: \"$F_SetupContainer\""
RUN echo "F_Tdddemo: \"$F_Tdddemo\""
RUN echo "F_UnSetup: \"$F_UnSetup\""
RUN echo "F_Vars: \"$F_Vars\""

WORKDIR "$P_Container_Workdir"
ENTRYPOINT ["./entrypoint.sh"]
# Overriding ENTRYPOINT seems to also influence CMD
# Even though ENTRYPOINT is originally null

# CMD ["/bin/sh", "-c", "/bin/bash echo 'test'"]
# /usr/bin/echo: /usr/bin/echo: cannot execute binary file

CMD ["/bin/sh", "-c", "/bin/bash /home/oracle/setup/dockerInit.sh"]
# CMD ["/bin/sh", "-c", "/bin/bash /home/oracle/setup/dockerInit.sh && echo 'before' && source /home/oracle/.bashrc $F_Container_Workdir_SetupContainer && echo 'result: $?'"]
HEALTHCHECK --interval=60s --timeout=10s --retries=3 CMD /bin/bash /home/oracle/setup/healthcheck.sh

COPY "$P_Copied/$F_PrintFunctions" "$P_Container_Workdir"

COPY "$F_ContainerFiles" "$P_Container_Workdir"
COPY "$F_DebugSetup" "$P_Container_Workdir"
COPY "$F_Ecommerce" "$P_Container_Workdir"
COPY "$F_Entrypoint" "$P_Container_Workdir"
COPY "$F_RunSqlCommand" "$P_Container_Workdir"
COPY "$F_Secrets" "$P_Container_Workdir"
COPY "$F_Setup" "$P_Container_Workdir"
COPY "$F_SetupContainer" "$P_Container_Workdir"
COPY "$F_Tdddemo" "$P_Container_Workdir"
COPY "$F_UnSetup" "$P_Container_Workdir"
COPY "$F_Vars" "$P_Container_Workdir"

RUN chmod 777 -R "$P_Container_Workdir" \
    && source "$P_Container_Workdir/$F_ContainerFiles" \
	&& mkdir -p "$P_Container_Workdir_Tmp" \
	&& chmod 777 -R "$P_Container_Workdir_Tmp"

RUN yum -y update >/dev/null 2>&1

RUN /usr/bin/ol_yum_configure.sh >/dev/null 2>&1

# RUN yum -y install git >/dev/null 2>&1

RUN yum clean all >/dev/null 2>&1

USER oracle

# https://snyk.io/blog/10-docker-image-security-best-practices/

RUN echo "Dockerfile finished successfully"