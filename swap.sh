#!/bin/bash

# 脚本信息
SCRIPT_AUTHOR="江湖笔者"
SCRIPT_VERSION="1.0"
SCRIPT_DESCRIPTION="Swap 管理模块：创建、启用、禁用、查看和删除 Swap"
WARNING_MESSAGE="
====================================
警告：
====================================
1. 此部分涉及系统 Swap 配置，操作前请确保您已了解相关技术知识。
2. 使用本脚本可能会对您的系统性能产生影响，请谨慎操作。
3. 本脚本仅供学习和测试使用，请遵守当地法律法规。
4. 使用本脚本造成的任何后果与作者无关，请自行承担风险。
====================================
"

# 显示脚本信息和警告
show_script_info() {
    echo "===================================="
    echo "脚本信息"
    echo "===================================="
    echo "脚本作者: $SCRIPT_AUTHOR"
    echo "脚本版本: $SCRIPT_VERSION"
    echo "脚本用途: $SCRIPT_DESCRIPTION"
    echo "$WARNING_MESSAGE"
    echo "按回车键继续，或按 Ctrl+C 退出..."
    read
}

# 函数：计算推荐的 Swap 大小
calculate_swap_size() {
    local mem_size=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    mem_size=$((mem_size / 1024)) # 转换为 MB

    if [ "$mem_size" -lt 2048 ]; then
        # 如果内存小于 2GB，Swap 大小为内存的 2 倍
        echo "$((mem_size * 2))M"
    elif [ "$mem_size" -lt 8192 ]; then
        # 如果内存小于 8GB，Swap 大小等于内存大小
        echo "${mem_size}M"
    else
        # 如果内存大于等于 8GB，Swap 大小为 4GB
        echo "4096M"
    fi
}

# 函数：一键配置 Swap
auto_configure_swap() {
    echo "正在检测系统内存并计算推荐的 Swap 大小..."
    local swap_size=$(calculate_swap_size)
    echo "推荐的 Swap 大小为: $swap_size"

    # 创建 Swap 文件
    echo "正在创建 ${swap_size} 的 Swap 文件..."
    sudo fallocate -l "$swap_size" /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile

    # 启用 Swap
    echo "正在启用 Swap..."
    sudo swapon /swapfile

    # 配置开机自动启用 Swap
    echo "正在配置开机自动启用 Swap..."
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab > /dev/null

    echo "Swap 一键配置完成！"
    echo "Swap 大小: $swap_size"
    echo "Swap 已启用并设置为开机自动加载。"
}

# 函数：创建 Swap 文件
create_swap() {
    read -p "请输入 Swap 文件大小（例如 1G、2G）: " swap_size
    echo "正在创建 ${swap_size} 的 Swap 文件..."
    sudo fallocate -l "$swap_size" /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    echo "Swap 文件创建完成！"
}

# 函数：启用 Swap
enable_swap() {
    echo "正在启用 Swap..."
    sudo swapon /swapfile
    echo "Swap 已启用！"
}

# 函数：禁用 Swap
disable_swap() {
    echo "正在禁用 Swap..."
    sudo swapoff /swapfile
    echo "Swap 已禁用！"
}

# 函数：查看 Swap 状态
show_swap_status() {
    echo "当前 Swap 状态："
    swapon --show
    free -h
}

# 函数：删除 Swap 文件
delete_swap() {
    echo "正在删除 Swap 文件..."
    sudo swapoff /swapfile
    sudo rm -f /swapfile
    echo "Swap 文件已删除！"
}

# 显示 Swap 管理菜单
show_swap_menu() {
    while true; do
        echo "Swap 管理菜单："
        echo "1) 一键配置 Swap（新手小白推荐）"
        echo "2) 创建 Swap 文件"
        echo "3) 启用 Swap"
        echo "4) 禁用 Swap"
        echo "5) 查看 Swap 状态"
        echo "6) 删除 Swap 文件"
        echo "7) 返回主菜单"
        read -p "请输入选项数字: " choice

        case $choice in
            1)
                auto_configure_swap
                ;;
            2)
                create_swap
                ;;
            3)
                enable_swap
                ;;
            4)
                disable_swap
                ;;
            5)
                show_swap_status
                ;;
            6)
                delete_swap
                ;;
            7)
                echo "返回主菜单。"
                break
                ;;
            *)
                echo "无效的选项，请重新选择。"
                ;;
        esac

        echo "按回车键继续..."
        read
    done
}

# 主函数
main() {
    show_script_info
    show_swap_menu
}

# 执行主函数
main