#!/bin/bash

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # 重置颜色

# 脚本信息
SCRIPT_AUTHOR="江湖笔者"
SCRIPT_VERSION="1.0"
SCRIPT_DESCRIPTION="Linux 模块化配置脚本（All-in-One）"

# 加载方式变量
SOURCE_TYPE=""  # 用户选择的加载方式
BASE_URL=""     # 基础 URL

# 函数：显示脚本信息和系统信息
show_script_and_system_info() {
    echo -e "${CYAN}"
    echo "+================================================+"
    echo "|                🛠️ 脚本信息 🛠️                 |"
    echo "+================================================+"
    echo -e "| 脚本作者: ${GREEN}$SCRIPT_AUTHOR${CYAN}"
    echo -e "| 脚本版本: ${GREEN}$SCRIPT_VERSION${CYAN}"
    echo -e "| 脚本用途: ${GREEN}$SCRIPT_DESCRIPTION${CYAN}"
    echo "+------------------------------------------------+"
    echo -e "|                🖥️ 系统信息 🖥️                 |"
    echo "+------------------------------------------------+"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo -e "| 操作系统: ${GREEN}$NAME $VERSION${CYAN}"
    else
        echo -e "| 操作系统: ${RED}未知${CYAN}"
    fi
    echo -e "| 系统运行内存: ${GREEN}$(free -h | awk '/^Mem:/ {print $3 "/" $2}')${CYAN}"
    echo -e "| CPU: ${GREEN}$(lscpu | grep "Model name" | cut -d ':' -f 2 | xargs)${CYAN}"
    echo -e "| 硬盘容量（剩余）: ${GREEN}$(df -h / | awk 'NR==2 {print $4}')${CYAN}"
    echo -e "| 硬盘容量（总共）: ${GREEN}$(df -h / | awk 'NR==2 {print $2}')${CYAN}"
    echo "+================================================+"
    echo -e "${NC}"
}

# 函数：显示调用方式选择菜单
show_source_menu() {
    echo -e "${CYAN}"
    echo "+================================================+"
    echo "|                🌐 选择调用方式 🌐             |"
    echo "+================================================+"
    echo -e "| ${GREEN}1) 使用 GitHub Raw 调用${CYAN}"
    echo -e "| ${GREEN}2) 使用 jsDelivr 调用${CYAN}"
    echo -e "| ${GREEN}3) 使用 Cloudflare 调用${CYAN}"
    echo -e "| ${GREEN}4) 退出${CYAN}"
    echo "+================================================+"
    echo -e "${NC}"
}

# 函数：设置基础 URL
set_base_url() {
    local source_choice=$1
    case $source_choice in
        1)
            SOURCE_TYPE="GitHub Raw"
            BASE_URL="https://github.com/qinyuanchun03/linux-tool-test/raw/main"
            ;;
        2)
            SOURCE_TYPE="jsDelivr"
            BASE_URL="https://cdn.jsdelivr.net/gh/qinyuanchun03/linux-tool-test@main"
            ;;
        3)
            SOURCE_TYPE="Cloudflare"
            BASE_URL="https://rules-key.jianghu.space"
            ;;
        *)
            echo -e "${RED}无效的选项，请重新选择。${NC}"
            return 1
            ;;
    esac
    echo -e "${GREEN}已选择加载方式: ${SOURCE_TYPE}${NC}"
    return 0
}

# 函数：加载子菜单脚本
load_submenu() {
    local submenu_name=$1
    local submenu_url="${BASE_URL}/${submenu_name}"
    echo -e "${YELLOW}正在加载子菜单: ${submenu_name}...${NC}"
    bash <(curl -sL "${submenu_url}")
}

# 函数：显示主菜单
show_main_menu() {
    while true; do
        echo -e "${CYAN}"
        echo "+================================================+"
        echo "|                🎯 主菜单 🎯                   |"
        echo "+================================================+"
        echo -e "| ${GREEN}1) 系统环境配置${CYAN}"
        echo -e "| ${GREEN}2) 网络环境配置${CYAN}"
        echo -e "| ${GREEN}3) 网络工具配置${CYAN}"
        echo -e "| ${GREEN}4) 简单建站配置${CYAN}"
        echo -e "| ${GREEN}5) Swap 管理${CYAN}"
        echo -e "| ${GREEN}6) 面板管理${CYAN}"
        echo -e "| ${GREEN}7) 退出${CYAN}"
        echo "+================================================+"
        echo -e "${NC}"
        read -p "请输入选项数字: " choice

        case $choice in
            1)
                load_submenu "system_env.sh"
                ;;
            2)
                load_submenu "network_env.sh"
                ;;
            3)
                load_submenu "network_tools.sh"
                ;;
            4)
                load_submenu "sites.sh"
                ;;
            5)
                load_submenu "swap.sh"
                ;;
            6)
                load_submenu "panel.sh"
                ;;
            7)
                echo -e "${GREEN}退出脚本。${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}无效的选项，请重新选择。${NC}"
                ;;
        esac

        echo -e "${CYAN}按回车键继续...${NC}"
        read
    done
}

# 主循环
while true; do
    show_script_and_system_info
    show_source_menu
    read -p "请输入选项数字: " source_choice

    if set_base_url "$source_choice"; then
        show_main_menu
    fi

    echo -e "${CYAN}按回车键继续...${NC}"
    read
done
