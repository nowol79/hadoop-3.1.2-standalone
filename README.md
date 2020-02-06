## What?
hadoop + hive + tez : standalone hadoop SQL env

## PKGS
- hadoop-3.1.2
- hive-3.1.2
- tez-0.9.2

## RUN
```
$ docker run -d --name hadoop-standalone -v $PWD/logs:/opt/hadoop/hadoop-3.1.2/logs -p 50070:50070 -p 50075:50075 -p 8088:8088 -p 7070:7070 -p 7979:7979  nowol79/hadoop-3.1.2-standalone
```

or 
```
$ run.sh
```

## check list
- NameNode UI : http://localhost:50070
- DataNode UI : http://localhost:50075
- yarn UI : http://localhost:8088

## HIVE
```
$ docker exec -it hadoop-standalone /opt/hadoop/hive-3.1.2/bin/hive

SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/opt/hadoop/apache-tez-0.9.2-bin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/hadoop/hadoop-3.1.2/share/hadoop/common/lib/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
which: no hbase in (/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin)
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/opt/hadoop/apache-tez-0.9.2-bin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/hadoop/hive-3.1.2/lib/log4j-slf4j-impl-2.10.0.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/hadoop/hadoop-3.1.2/share/hadoop/common/lib/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
Hive Session ID = 3cf1aeda-2be6-40ca-b05e-b2ae0a509e40

Logging initialized using configuration in jar:file:/opt/hadoop/hive-3.1.2/lib/hive-common-3.1.2.jar!/hive-log4j2.properties Async: true
Hive-on-MR is deprecated in Hive 2 and may not be available in the future versions. Consider using a different execution engine (i.e. spark, tez) or using Hive 1.X releases.
Hive Session ID = f12065ab-4388-49d7-a4bf-3894f5318e2e


hive> show databases;
OK
default
Time taken: 0.698 seconds, Fetched: 1 row(s)

hive> create database my_db;
OK
Time taken: 0.659 seconds

hive> use my_db;
OK
Time taken: 0.044 seconds

hive> CREATE TABLE emp ( id INT, name STRING )
    > ROW FORMAT DELIMITED
    > FIELDS TERMINATED BY ','
    > LINES TERMINATED BY '\n'
    > STORED AS TEXTFILE;
OK
Time taken: 0.739 seconds

Create an example file : /tmp/data.txt
1,Skanda
2,Bhargav
3,Nilesh
4,Abhi

LOAD DATA LOCAL INPATH '~/tmp/data.txt' INTO TABLE my_db.emp;

hive> select * from my_db.emp;
OK
1	Skanda
2	Bhargav
3	Nilesh
4	Abhi

```
