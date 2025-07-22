
#!/bin/sh
# vnts Docker 容器的入口点脚本
# 确保所有命令行参数（包括 --allow-wg）传递给 vnts 二进制文件

# 检查并加载 tun 模块（参考 lmq8267/vnts 的要求）
if ! lsmod | grep -q tun; then
    echo "正在加载 tun 模块..."
    modprobe tun || insmod /lib/modules/tun.ko || echo "警告：无法加载 tun 模块"
fi

# 检查 WireGuard 模块（为 --allow-wg 提供支持）
if ! lsmod | grep -q wireguard; then
    echo "WireGuard 模块未加载，尝试加载..."
    modprobe wireguard || echo "警告：WireGuard 模块不可用，--allow-wg 可能无法正常工作"
fi

# 使用所有传入参数执行 vnts
exec /usr/local/bin/vnts "$@"
