# DockAuto
A template project for automating creation of 2 separate dockers: 1 for Oracle database, 1 for Tomcat Java 11 application

## How to run

1. Clone repository  
`git clone https://github.com/axal25/DockAuto.git`
2. Change folder to repository folder  
`cd DockAuto`
3. Run statup script  
`./docker_outer_build_and_run.sh`

## Optional customization

1. Fill out optional parameters inside file  
`/copy_to/common/common_outer_vars.sh`

## To do

1. Finished:
    1. Basic Oracle Database Docker setup finished
        1. Waiting on docker statup
        1. Connect service readiness
        1. Default password change
        1. Call to oracledb_setup.sql
1. To be done:
    1. Parametrize oracledb setup file names
        1. Pass them from DOCKER-ENV or SHELL-ENV file from docker_outer_build_run.sh to:
            1. oracledb/Dockerfile
            1. oracledb/oracledb_inner_setup.sh
                1. so on
        1. Filename: copy_to/oracledb/oracledb_outer_paths.env
    1. ./oracledb/oracledb_setup.sql - to be filled, tested
    1. customize oracledb_setup.sql source (git?)? optional (accessible, customizable)?
        1. one file for customizable variables - overriding existing variables
    1. Move password to be changed to from default somewhere accessible, customizable
    1. Tomcatapp docker	
