# 设置 IP 地址
ip="127.0.0.1"

# 指定 port
ports=("7001" "7002" "7003" "7004" "7005" "7006")

# 设置密码
pw="aa"

# 启动 Redis 容器
for port in "${ports[@]}"; do
    echo "port:$port 创建数据"
    mkdir -p "$PWD/data/$port/conf" && PORT="$port" envsubst < ./redis-cluster.conf > "$PWD/data/$port/conf/redis.conf" &&
    mkdir -p "$PWD/data/$port/data"

    echo "port:$port 启动 Redis"
    docker run -d -ti \
    -p "${port}:${port}" -p "1${port}:1${port}" \
    -v "$PWD/data/$port/conf/redis.conf:/usr/local/etc/redis/redis.conf" \
    -v "$PWD/data/$port/data:/data" \
    --restart always \
    --name "redis-$port" \
    redis redis-server /usr/local/etc/redis/redis.conf --requirepass "$pw"
done

# 等待 Redis 容器启动
sleep 5

# 确保容器都已经启动后再执行后续操作
for port in "${ports[@]}"; do
    while true; do
        if docker ps | grep -q "redis-$port"; then
            break
        else
            echo "等待 redis-$port 容器启动..."
            sleep 2
        fi
    done
done

# 如果密码非空，则设置密码
if [ -n "$pw" ]; then
    command="echo \"yes\" | redis-cli -a $pw --cluster create"
else
    command="echo \"yes\" | redis-cli --cluster create"
fi

# 添加 IP 地址和端口到命令
for port in "${ports[@]}"; do
    command+=" ${ip}:${port}"
done

# 添加副本数量
command+=" --cluster-replicas 1"
echo $command
# 执行命令
eval "$command"

