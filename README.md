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

## check 
- NameNode UI : http://localhost:50070
- DataNode UI : http://localhost:50075
- yarn UI : http://localhost:8088
