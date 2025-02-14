FROM louislam/uptime-kuma:latest

# 配置环境变量
ENV NODE_ENV=production

# 暴露端口
EXPOSE 3001

# 启动命令
CMD ["node", "server/server.js"]
