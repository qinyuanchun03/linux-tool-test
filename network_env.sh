#!/bin/bash

# 加载通用函数脚本
source ./common.sh

# 显示网络环境配置子菜单
show_network_submenu() {
    while true; do
        echo "网络环境配置子菜单："
        echo "1) 安装防火墙工具"
        echo "2) 开启端口"
        echo "3) 关闭端口"
        echo "4) 开启所有端口"
        echo "5) 关闭所有端口"
        echo "6) 返回主菜单"
        read -p "请输入选项数字: " network_choice

        case $network_choice in
            1)
                distro=$(detect_distro)
                case $distro in
                    ubuntu|debian)
                        install_ufw
                        ;;
                    centos|rhel|fedora)
                        install_firewalld
                        ;;
                    *)
                        echo "不支持的系统，请手动安装防火墙工具。"
                        ;;
                esac
                ;;
            2)
                read -p "请输入要开启的端口号: " port
                open_port "$port"
                ;;
            3)
                read -p "请输入要关闭的端口号: " port
                close_port "$port"
                ;;
            4)
                open_all_ports
                ;;
            5)
                close_all_ports
                ;;
            6)
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

# 显示网络环境配置菜单
show_network_submenu