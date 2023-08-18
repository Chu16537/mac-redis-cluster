for port in `seq 7001 7006`; do 
  docker stop redis-${port}
  docker rm redis-${port}
done