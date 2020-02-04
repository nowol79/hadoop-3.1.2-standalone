rm -rf ./logs

docker run -d --name hadoop-standalone -v $PWD/logs:/opt/hadoop/hadoop-3.1.2/logs -p 50070:50070 -p 50075:50075 -p 7070:7070 -p 7979:7979 -p 8088:8088 nowol79/hadoop-3.1.2-standalone
