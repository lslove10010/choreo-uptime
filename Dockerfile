# 使用 Uptime Kuma 的官方镜像作为基础
FROM louislam/uptime-kuma:latest

# 创建一个非 root 用户
RUN adduser --disabled-password --gecos '' uptimekuma

# 将应用程序目录的所有权更改为新用户
RUN chown -R uptimekuma:uptimekuma /app

# 切换到新用户
USER uptimekuma

# 暴露端口
EXPOSE 3001

# 启动命令
CMD ["node", "server/server.js"]
