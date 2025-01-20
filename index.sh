#!/bin/bash

# 作者信息
AUTHOR_NAME="江湖笔者"
AUTHOR_EMAIL="crazy2403@outlook.com"
SCRIPT_PURPOSE="适合linux新手的多功能脚本"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'  # 恢复默认颜色

# 显示脚本信息
show_info() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}作者: ${YELLOW}$AUTHOR_NAME${NC}"
    echo -e "${GREEN}邮箱: ${YELLOW}$AUTHOR_EMAIL${NC}"
    echo -e "${GREEN}脚本用途: ${YELLOW}$SCRIPT_PURPOSE${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}系统信息:${NC}"
    echo -e "${BLUE}-------------------${NC}"
    echo -e "${GREEN}系统版本: ${YELLOW}$(lsb_release -d | cut -f2)${NC}"
    echo -e "${GREEN}系统运行内存: ${YELLOW}$(free -h | grep Mem | awk '{print $2}')${NC}"
    echo -e "${GREEN}系统硬盘大小: ${YELLOW}$(df -h / | grep / | awk '{print $2}')${NC}"
    echo -e "${GREEN}系统硬盘剩余: ${YELLOW}$(df -h / | grep / | awk '{print $4}')${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

# 面板类工具子菜单
panel_tools_submenu() {
    while true; do
        show_info  # 显示脚本信息
        echo -e "${GREEN}面板类工具子菜单${NC}"
        echo -e "${BLUE}-------------------${NC}"
        echo -e "${GREEN}1. 安装 1Panel${NC}"
        echo -e "${GREEN}2. 安装 宝塔开心版${NC}"
        echo -e "${GREEN}3. 返回主菜单${NC}"
        echo ""
        read -p "请选择一个选项 (1-3): " sub_choice

        case $sub_choice in
            1)
                install_1panel
                ;;
            2)
                install_baota
                ;;
            3)
                echo -e "${YELLOW}返回主菜单...${NC}"
                break
                ;;
            *)
                echo -e "${RED}无效选项，请重新选择。${NC}"
                ;;
        esac
        echo ""
    done
}

# 安装 1Panel
install_1panel() {
    echo -e "${YELLOW}正在安装 1Panel...${NC}"
    echo -e "${GREEN}1Panel 是一个现代化的服务器管理面板。${NC}"
    echo -e "${GREEN}安装完成后，您可以通过 http://<VPS_IP>:80 访问面板。${NC}"

    # 下载并安装 1Panel
    curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && bash quick_start.sh

    echo -e "${GREEN}1Panel 安装完成。${NC}"
    echo -e "${GREEN}请通过 http://<VPS_IP>:80 访问面板。${NC}"
}

# 安装 宝塔开心版
install_baota() {
    echo -e "${YELLOW}正在安装 宝塔开心版...${NC}"
    echo -e "${GREEN}宝塔开心版是一个功能强大的服务器管理面板。${NC}"
    echo -e "${GREEN}安装完成后，您可以通过 http://<VPS_IP>:8888 访问面板。${NC}"

    # 下载并安装 宝塔开心版
    wget -O install.sh http://download.bt.cn/install/install_panel.sh && bash install.sh

    echo -e "${GREEN}宝塔开心版安装完成。${NC}"
    echo -e "${GREEN}请通过 http://<VPS_IP>:8888 访问面板。${NC}"
}

# 主菜单
main_menu() {
    while true; do
        show_info  # 显示脚本信息
        echo -e "${GREEN}主菜单${NC}"
        echo -e "${BLUE}---------${NC}"
        echo -e "${GREEN}1. 系统环境配置${NC}"
        echo -e "${GREEN}2. 网络配置${NC}"
        echo -e "${GREEN}3. 编程环境配置${NC}"
        echo -e "${GREEN}4. 博客框架配置${NC}"
        echo -e "${GREEN}5. 网络工具配置${NC}"
        echo -e "${GREEN}6. 面板类工具${NC}"
        echo -e "${GREEN}7. 管理CPU设置${NC}"
        echo -e "${GREEN}8. 退出${NC}"
        echo ""
        read -p "请选择一个选项 (1-8): " choice

        case $choice in
            1)
                system_submenu
                ;;
            2)
                network_submenu
                ;;
            3)
                dev_submenu
                ;;
            4)
                blogs_submenu
                ;;
            5)
                net_tool_submenu
                ;;
            6)
                panel_tools_submenu
                ;;
            7)
                manage_cpu
                ;;
            8)
                echo -e "${YELLOW}正在退出...${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}无效选项，请重新选择。${NC}"
                ;;
        esac
        echo ""
    done
}

# 启动主菜单
main_menu
