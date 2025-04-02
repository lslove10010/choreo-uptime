# 使用已经构建好的 gogost/gost 镜像
FROM gogost/gost:3.0.0-nightly.20250218

# 创建用户和组
RUN addgroup --gid 10014 choreo && \
    adduser --disabled-password --no-create-home --uid 10014 --ingroup choreo choreouser

# 设置工作目录
WORKDIR /app
# 复制 Gost 二进制文件并设置权限
COPY --from=builder /app/cmd/gost/gost .
RUN chmod +x /app/gost

# 切换到非 root 用户
USER 10014

# 运行 Gost
ENTRYPOINT ["./gost"]
CMD ["-D", "-L=socks5://:8080"]
