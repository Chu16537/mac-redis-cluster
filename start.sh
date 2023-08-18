for port in `seq 7001 7006`; do 
  docker run -d -ti \
  -p ${port}:${port} -p 1${port}:1${port} \
  -v /Users/user/redis/${port}/conf/redis.conf:/usr/local/etc/redis/redis.conf \
  -v /Users/user/redis/${port}/data:/data \
  --restart always \
  --name redis-${port} \
  redis redis-server /usr/local/etc/redis/redis.conf \
  --requirepass aa;
done