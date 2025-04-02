# 使用 tonistiigi/xx 镜像作为基础镜像
FROM --platform=$BUILDPLATFORM tonistiigi/xx:1.5.0 AS xx

# 使用 Golang 镜像作为构建镜像
FROM --platform=$BUILDPLATFORM golang:1.23-alpine3.20 AS builder

COPY --from=xx / /

ARG TARGETPLATFORM

RUN xx-info env

ENV CGO_ENABLED=0
ENV XX_VERIFY_STATIC=1

WORKDIR /app

COPY . .

RUN cd cmd/gost && \
    xx-go build && \
    xx-verify gost

# 创建最终镜像
FROM alpine:3.20

# 添加 iptables 以支持 tun/tap
RUN apk add --no-cache iptables

# 创建用户和组
RUN addgroup --gid 10014 choreo && \
    adduser --disabled-password --no-create-home --uid 10014 --ingroup choreo choreouser

# 设置工作目录
WORKDIR /app

# 复制构建的 Gost 二进制文件
COPY --from=builder /app/cmd/gost/gost .

# 更改 Gost 二进制文件的所有权
RUN chown choreouser:choreo /app/gost

# 切换到非 root 用户
USER choreouser
# 运行 Gost
ENTRYPOINT ["/app/gost"]
CMD ["-L", "socks5://:8080"]
