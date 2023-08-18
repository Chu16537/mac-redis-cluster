[](https://developer.aliyun.com/article/976532)
https://blog.csdn.net/flyzing/article/details/113178480



進入 redis後 設定 cluster 指令
redis-cli -a aa --cluster create 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 127.0.0.1:7006 --cluster-replicas 1

請把 127.0.0.1 改為 對外ip