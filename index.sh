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

# 调用地址定义
GITHUB_URL="https://raw.githubusercontent.com/qinyuanchun03/linux-tool-test/main"
CDN_URL="https://cdn.jsdelivr.net/gh/qinyuanchun03/linux-tool-test@main"

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

# 函数：选择调用地址
select_source() {
    echo -e "${CYAN}"
    echo "+================================================+"
    echo "|                🌐 选择调用地址 🌐             |"
    echo "+================================================+"
    echo -e "| ${GREEN}1) GitHub 版${CYAN}"
    echo -e "| ${GREEN}2) CDN 版（推荐）${CYAN}"
    echo "+================================================+"
    echo -e "${NC}"
    read -p "请输入选项数字: " source_choice

    case $source_choice in
        1)
            SOURCE_URL="$GITHUB_URL"
            ;;
        2)
            SOURCE_URL="$CDN_URL"
            ;;
        *)
            echo -e "${RED}== 无效的选项，默认使用 GitHub 版。 ==${NC}"
            SOURCE_URL="$GITHUB_URL"
            ;;
    esac

    echo -e "${GREEN}== 已选择调用地址: $SOURCE_URL ==${NC}"
}

# 主函数
main() {
    show_script_and_system_info
    select_source

    # 加载其他模块
    echo -e "${YELLOW}正在加载模块...${NC}"
    source <(curl -sL "$SOURCE_URL/common.sh")
    source <(curl -sL "$SOURCE_URL/network_tools.sh")
    source <(curl -sL "$SOURCE_URL/sites.sh")
    source <(curl -sL "$SOURCE_URL/swap.sh")
    source <(curl -sL "$SOURCE_URL/panel.sh")

    # 显示主菜单
    while true; do
        show_main_menu
        read -p "请输入选项数字: " choice

        case $choice in
            1)
                system_env
                ;;
            2)
                network_env
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
                echo -e "${GREEN}== 退出脚本。 ==${NC}"
                break
                ;;
            *)
                echo -e "${RED}== 无效的选项，请重新选择。 ==${NC}"
                ;;
        esac

        echo -e "${CYAN}按回车键继续...${NC}"
        read
    done
}

# 执行主函数
main
