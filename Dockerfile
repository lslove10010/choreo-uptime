# 使用 Uptime Kuma 官方镜像
FROM louislam/uptime-kuma:latest

# 创建用户和组
RUN addgroup --gid 10014 choreo && \
    adduser --disabled-password --no-create-home --uid 10014 --ingroup choreo choreouser

# 创建 worker 目录并更改所有权
RUN mkdir -p /app/worker && \
    mkdir -p /app/data && \
    chown -R choreouser:choreo /app/worker && \
    chown -R choreouser:choreo /app/data

# 复制并设置入口点脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 切换到非 root 用户
USER 10014

# 暴露端口
EXPOSE 3001

# 启动命令
ENTRYPOINT ["/entrypoint.sh"]
