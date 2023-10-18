#!/bin/bash
# 设置 IP 地址
ip="127.0.0.1"

# 指定 port
ports=("7001" "7002" "7003" "7004" "7005" "7006")

# 密码
pw="aa"

# 遍历所有节点并执行关闭操作
for port in "${ports[@]}"; do
    if [ -z "$pw" ]; then
        # 使用 redis-cli 连接到节点
        redis-cli -h "$ip" -p "$port" cluster reset
    else
        # 使用 redis-cli 连接到节点
        redis-cli -h "$ip" -p "$port" -a "$pw" cluster reset
    fi
    echo "port $port removed"
done

# 关闭并删除 Docker 容器
for port in "${ports[@]}"; do 
  docker stop "redis-${port}"
  docker rm "redis-${port}"
done
