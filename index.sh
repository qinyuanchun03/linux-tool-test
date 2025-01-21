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

# 源地址定义
SOURCE_RULES_KEY="https://rules-key.jianghu.space"
SOURCE_GITHUB="https://raw.githubusercontent.com/qinyuanchun03/linux-tool-test/refs/heads/main/index.sh"
SOURCE_CDN="https://cdn.jsdelivr.net/gh/qinyuanchun03/linux-tool-test@main/index.sh"  # 使用 jsDelivr CDN 地址

# 函数：获取用户的地理位置
get_user_location() {
    IP_INFO=$(curl -s https://ipinfo.io)
    COUNTRY=$(echo "$IP_INFO" | grep "country" | cut -d '"' -f 4)
    echo "$COUNTRY"
}

# 函数：根据 IP 判断结果推荐最佳源地址
recommend_source_url() {
    COUNTRY=$(get_user_location)
    if [[ "$COUNTRY" == "CN" ]]; then
        echo "$SOURCE_RULES_KEY"
    else
        echo "$SOURCE_GITHUB"
    fi
}

# 函数：询问用户是否接受推荐结果
ask_user_for_source() {
    RECOMMENDED_SOURCE=$(recommend_source_url)
    echo -e "${YELLOW}根据您的 IP 地址，推荐使用以下源地址：${NC}"
    echo -e "${GREEN}$RECOMMENDED_SOURCE${NC}"
    read -p "是否接受推荐结果？（y/n，默认 y）: " accept_recommendation

    if [[ "$accept_recommendation" == "n" || "$accept_recommendation" == "N" ]]; then
        echo -e "${CYAN}请手动选择源地址：${NC}"
        echo "1) $SOURCE_RULES_KEY"
        echo "2) $SOURCE_GITHUB"
        echo "3) $SOURCE_CDN"
        read -p "请输入选项数字（1/2/3）: " source_choice

        case $source_choice in
            1)
                echo "$SOURCE_RULES_KEY"
                ;;
            2)
                echo "$SOURCE_GITHUB"
                ;;
            3)
                echo "$SOURCE_CDN"
                ;;
            *)
                echo -e "${RED}无效的选项，使用推荐源地址：$RECOMMENDED_SOURCE${NC}"
                echo "$RECOMMENDED_SOURCE"
                ;;
        esac
    else
        echo "$RECOMMENDED_SOURCE"
    fi
}

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

# 函数：显示主菜单
show_main_menu() {
    show_script_and_system_info
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
}

# 主循环
while true; do
    show_main_menu
    read -p "请输入选项数字: " choice

    case $choice in
        1)
            SOURCE_URL=$(ask_user_for_source)
            curl -s "$SOURCE_URL/system_env.sh" | bash
            ;;
        2)
            SOURCE_URL=$(ask_user_for_source)
            curl -s "$SOURCE_URL/network_env.sh" | bash
            ;;
        3)
            SOURCE_URL=$(ask_user_for_source)
            curl -s "$SOURCE_URL/network_tools.sh" | bash
            ;;
        4)
            SOURCE_URL=$(ask_user_for_source)
            curl -s "$SOURCE_URL/sites.sh" | bash
            ;;
        5)
            SOURCE_URL=$(ask_user_for_source)
            curl -s "$SOURCE_URL/swap.sh" | bash
            ;;
        6)
            SOURCE_URL=$(ask_user_for_source)
            curl -s "$SOURCE_URL/panel.sh" | bash
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
