# Big Data Docker Containers
Docker containers for running big data platform. Containers for Hadoop, Hive, Impala, Zookeeper and Postgres. 
## Quick Start
```
cd bigdata-docker/base/
docker-compose build base-centos
cd ../
docker-compose build 
docker-compose -p bigdata-net up zookeeper postgres hadoop
# wait for containers to start
docker-compose -p bigdata-net up hive impala
```
## Building Containers
All containers can be build using docker-compose.
```
docker-compose build
```
Individual containers can be built by referencing the container name.
```
docker-compose build impala
```
__Note on Building:__ Currently the Hive and Impala containers are build from a custom base image (CentOS with a specific version of the JDK installed). This image has its own docker-compose file and will need to be built prior to Hive and Impala using the docker-compose file in the base directory.
```
cd base/
docker-compose build base-centos
```
## Running Containers
All containers can be run using docker-compose
The -p option is used to specify the docker network for the containers.
```
docker-compose -p bigdata-net up
```
Individual containers can be run by referencing the container name.
```
docker-compose -p bigdata-net up postgres
```
## Accessing Containers
Use docker-compose to access containers by name.
```
docker-compose -p bigdata-net exec impala bash
```
## Container Structure
<img src="https://raw.githubusercontent.com/mtempleton94/bigdata-docker/master/images/bigdata-docker-structure.PNG" width="350">

## Adding Data to the HDFS
[TODO]

## Running Hive Queries
__Using beeline__
1. From the Hive container, run the beeline CLI
```
beeline
```
2. Connect to the HiveServer2
```
!connect jdbc:hive2://localhost:10000
```
3. Run Queries
```
show databases;
```

__Using JDBC with Maven__
[TODO]

## Running Impala Queries
__Using Impala Shell__
[TODO]

__Using JDBC with Maven__
[TODO]

## TODO
- Merge the base image into the main docker-compose file
- Wait for dependent containers to start up before starting othes so all containers can be brought up at once.
- Separate containers for hadoop name and data nodes so multiple data nodes can be run.
- Change Java version to JDK to allow Maven based Java projects to run.
- Maven support for impala container
- Add an Accumulo container
