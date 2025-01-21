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

# 函数：系统环境配置
system_env() {
    while true; do
        echo -e "${CYAN}"
        echo "+================================================+"
        echo "|                🛠️ 系统环境配置 🛠️            |"
        echo "+================================================+"
        echo -e "| ${GREEN}1) 安装 Python 和 Pip${CYAN}"
        echo -e "| ${GREEN}2) 安装 Node.js 和 NPM${CYAN}"
        echo -e "| ${GREEN}3) 安装 Java (OpenJDK)${CYAN}"
        echo -e "| ${GREEN}4) 安装 Go${CYAN}"
        echo -e "| ${GREEN}5) 安装 Ruby 和 Gem${CYAN}"
        echo -e "| ${GREEN}6) 安装 PHP 和 Composer${CYAN}"
        echo -e "| ${GREEN}7) 安装 Rust 和 Cargo${CYAN}"
        echo -e "| ${GREEN}8) 安装 .NET Core SDK${CYAN}"
        echo -e "| ${GREEN}9) 安装 Docker 和 Docker Compose${CYAN}"
        echo -e "| ${GREEN}10) 返回主菜单${CYAN}"
        echo "+================================================+"
        echo -e "${NC}"
        read -p "请输入选项数字: " choice

        case $choice in
            1)
                echo -e "${YELLOW}正在安装 Python 和 Pip...${NC}"
                sudo apt-get update
                sudo apt-get install -y python3 python3-pip
                echo -e "${GREEN}== Python 和 Pip 安装完成！ ==${NC}"
                ;;
            2)
                echo -e "${YELLOW}正在安装 Node.js 和 NPM...${NC}"
                curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
                sudo apt-get install -y nodejs
                echo -e "${GREEN}== Node.js 和 NPM 安装完成！ ==${NC}"
                ;;
            3)
                echo -e "${YELLOW}正在安装 Java (OpenJDK)...${NC}"
                sudo apt-get install -y openjdk-11-jdk
                echo -e "${GREEN}== Java (OpenJDK) 安装完成！ ==${NC}"
                ;;
            4)
                echo -e "${YELLOW}正在安装 Go...${NC}"
                sudo apt-get install -y golang
                echo -e "${GREEN}== Go 安装完成！ ==${NC}"
                ;;
            5)
                echo -e "${YELLOW}正在安装 Ruby 和 Gem...${NC}"
                sudo apt-get install -y ruby-full
                echo -e "${GREEN}== Ruby 和 Gem 安装完成！ ==${NC}"
                ;;
            6)
                echo -e "${YELLOW}正在安装 PHP 和 Composer...${NC}"
                sudo apt-get install -y php-cli php-mbstring unzip
                curl -sS https://getcomposer.org/installer | php
                sudo mv composer.phar /usr/local/bin/composer
                echo -e "${GREEN}== PHP 和 Composer 安装完成！ ==${NC}"
                ;;
            7)
                echo -e "${YELLOW}正在安装 Rust 和 Cargo...${NC}"
                curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
                source $HOME/.cargo/env
                echo -e "${GREEN}== Rust 和 Cargo 安装完成！ ==${NC}"
                ;;
            8)
                echo -e "${YELLOW}正在安装 .NET Core SDK...${NC}"
                wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
                sudo dpkg -i packages-microsoft-prod.deb
                sudo apt-get update
                sudo apt-get install -y apt-transport-https
                sudo apt-get install -y dotnet-sdk-5.0
                echo -e "${GREEN}== .NET Core SDK 安装完成！ ==${NC}"
                ;;
            9)
                echo -e "${YELLOW}正在安装 Docker 和 Docker Compose...${NC}"
                sudo apt-get update
                sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                sudo apt-get update
                sudo apt-get install -y docker-ce
                sudo usermod -aG docker $USER
                sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                sudo chmod +x /usr/local/bin/docker-compose
                echo -e "${GREEN}== Docker 和 Docker Compose 安装完成！ ==${NC}"
                ;;
            10)
                echo -e "${GREEN}== 返回主菜单。 ==${NC}"
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

# 函数：网络环境配置
network_env() {
    while true; do
        echo -e "${CYAN}"
        echo "+================================================+"
        echo "|                🌐 网络环境配置 🌐             |"
        echo "+================================================+"
        echo -e "| ${GREEN}1) 安装防火墙工具${CYAN}"
        echo -e "| ${GREEN}2) 开启端口${CYAN}"
        echo -e "| ${GREEN}3) 关闭端口${CYAN}"
        echo -e "| ${GREEN}4) 开启所有端口${CYAN}"
        echo -e "| ${GREEN}5) 关闭所有端口${CYAN}"
        echo -e "| ${GREEN}6) 返回主菜单${CYAN}"
        echo "+================================================+"
        echo -e "${NC}"
        read -p "请输入选项数字: " choice

        case $choice in
            1)
                echo -e "${YELLOW}正在安装防火墙工具...${NC}"
                if command -v apt-get &> /dev/null; then
                    sudo apt-get install -y ufw
                elif command -v yum &> /dev/null; then
                    sudo yum install -y firewalld
                else
                    echo -e "${RED}不支持的系统，请手动安装防火墙工具。${NC}"
                fi
                echo -e "${GREEN}== 防火墙工具安装完成！ ==${NC}"
                ;;
            2)
                read -p "请输入要开启的端口号: " port
                echo -e "${YELLOW}正在开启端口 $port...${NC}"
                if command -v ufw &> /dev/null; then
                    sudo ufw allow "$port"
                elif command -v firewall-cmd &> /dev/null; then
                    sudo firewall-cmd --zone=public --add-port="$port/tcp" --permanent
                    sudo firewall-cmd --reload
                else
                    echo -e "${RED}不支持的系统，请手动配置防火墙。${NC}"
                fi
                echo -e "${GREEN}== 端口 $port 已开启！ ==${NC}"
                ;;
            3)
                read -p "请输入要关闭的端口号: " port
                echo -e "${YELLOW}正在关闭端口 $port...${NC}"
                if command -v ufw &> /dev/null; then
                    sudo ufw delete allow "$port"
                elif command -v firewall-cmd &> /dev/null; then
                    sudo firewall-cmd --zone=public --remove-port="$port/tcp" --permanent
                    sudo firewall-cmd --reload
                else
                    echo -e "${RED}不支持的系统，请手动配置防火墙。${NC}"
                fi
                echo -e "${GREEN}== 端口 $port 已关闭！ ==${NC}"
                ;;
            4)
                echo -e "${YELLOW}正在开启所有端口...${NC}"
                if command -v ufw &> /dev/null; then
                    sudo ufw allow from any to any
                elif command -v firewall-cmd &> /dev/null; then
                    sudo firewall-cmd --zone=public --add-port=1-65535/tcp --permanent
                    sudo firewall-cmd --zone=public --add-port=1-65535/udp --permanent
                    sudo firewall-cmd --reload
                else
                    echo -e "${RED}不支持的系统，请手动配置防火墙。${NC}"
                fi
                echo -e "${GREEN}== 所有端口已开启！ ==${NC}"
                ;;
            5)
                echo -e "${YELLOW}正在关闭所有端口...${NC}"
                if command -v ufw &> /dev/null; then
                    sudo ufw deny from any to any
                elif command -v firewall-cmd &> /dev/null; then
                    sudo firewall-cmd --zone=public --remove-port=1-65535/tcp --permanent
                    sudo firewall-cmd --zone=public --remove-port=1-65535/udp --permanent
                    sudo firewall-cmd --reload
                else
                    echo -e "${RED}不支持的系统，请手动配置防火墙。${NC}"
                fi
                echo -e "${GREEN}== 所有端口已关闭！ ==${NC}"
                ;;
            6)
                echo -e "${GREEN}== 返回主菜单。 ==${NC}"
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

# 主循环
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
