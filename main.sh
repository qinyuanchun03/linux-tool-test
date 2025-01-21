#!/bin/bash

# 加载通用函数脚本
source ./common.sh

# 显示主菜单
show_main_menu() {
    show_script_info
    show_system_info
    echo "主菜单："
    echo "1) 系统环境配置"
    echo "2) 网络环境配置"
    echo "3) 网络工具配置"
    echo "4) 简单建站配置"
    echo "5) Swap 管理"
    echo "6) 面板管理"
    echo "7) 退出"
}

# 主循环
while true; do
    show_main_menu
    read -p "请输入选项数字: " choice

    case $choice in
        1)
            ./system_env.sh
            ;;
        2)
            ./network_env.sh
            ;;
        3)
            ./network_tools.sh
            ;;
        4)
            ./sites.sh
            ;;
        5)
            ./swap.sh
            ;;
        6)
            ./panel.sh
            ;;
        7)
            echo "退出脚本。"
            break
            ;;
        *)
            echo "无效的选项，请重新选择。"
            ;;
    esac

    echo "按回车键继续..."
    read
done