# Docker Zookeeper
## Usage

```
docker run --name zookeeper -d --rm -it -p 7000:7000 -p 2181:2181 -p 3888:3888 -p 2888:2888 zookeeper:3.6.2 zkServer.sh --config /etc/zookeeper start-foreground
```

```
docker run --rm -it zookeeper:3.6.2 zkCli.sh -server server1
docker run --rm -it zookeeper:3.6.2 zkCli.sh -server server1:2181,server2:2181,server3:2181
```

```
curl http://server1:7000/metrics
```
