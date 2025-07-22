# 使用轻量级 rust:alpine 作为基础镜像
FROM rust:alpine

# 安装依赖，包括 WireGuard 工具
RUN apk add --no-cache bash linux-headers musl-dev wireguard-tools

# 复制入口点脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 假设 vnts 二进制文件已预编译或通过源代码构建
# 如果原 Dockerfile 从源代码构建，请保留相关构建步骤
COPY vnts /usr/local/bin/vnts
RUN chmod +x /usr/local/bin/vnts

# 暴露 vnts 默认端口（29870 用于 Web，29872 用于隧道）
EXPOSE 29870 29872/tcp 29872/udp

# 设置入口点以处理命令行参数
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
