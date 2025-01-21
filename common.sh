#!/bin/bash

# 脚本信息
SCRIPT_AUTHOR="江湖笔者"
SCRIPT_VERSION="1.0"
SCRIPT_DESCRIPTION="新手的Linux模块化配置脚本"

# 函数：显示脚本信息
show_script_info() {
    echo "===================================="
    echo "脚本信息"
    echo "===================================="
    echo "脚本作者: $SCRIPT_AUTHOR"
    echo "脚本版本: $SCRIPT_VERSION"
    echo "脚本用途: $SCRIPT_DESCRIPTION"
    echo "===================================="
}

# 函数：显示系统信息
show_system_info() {
    echo "系统信息:"
    echo "------------------------------------"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "操作系统: $NAME $VERSION"
    else
        echo "操作系统: 未知"
    fi
    echo "系统运行内存: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    echo "CPU: $(lscpu | grep "Model name" | cut -d ':' -f 2 | xargs)"
    echo "硬盘容量（剩余）: $(df -h / | awk 'NR==2 {print $4}')"
    echo "硬盘容量（总共）: $(df -h / | awk 'NR==2 {print $2}')"
    echo "===================================="
}

# 函数：检测系统发行版
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

# 函数：配置基于用户IP的DNS
configure_dns() {
    echo "正在配置DNS..."
    IP_INFO=$(curl -s https://ipinfo.io)
    COUNTRY=$(echo "$IP_INFO" | grep "country" | cut -d '"' -f 4)
    echo "检测到您的IP所在国家: $COUNTRY"

    case $COUNTRY in
        CN)
            echo "推荐使用阿里云DNS：223.5.5.5 和 223.6.6.6"
            echo "nameserver 223.5.5.5" | sudo tee /etc/resolv.conf > /dev/null
            echo "nameserver 223.6.6.6" | sudo tee -a /etc/resolv.conf > /dev/null
            ;;
        US)
            echo "推荐使用Google DNS：8.8.8.8 和 8.8.4.4"
            echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
            echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf > /dev/null
            ;;
        *)
            echo "未检测到特定国家，使用默认DNS：1.1.1.1 和 8.8.8.8"
            echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf > /dev/null
            echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf > /dev/null
            ;;
    esac
    echo "DNS配置完成！"
}

# 函数：配置编程环境
configure_programming_env() {
    while true; do
        echo "请选择需要安装的编程环境："
        echo "1) Python 和 Pip"
        echo "2) Node.js 和 NPM"
        echo "3) Java (OpenJDK)"
        echo "4) Go"
        echo "5) Ruby 和 Gem"
        echo "6) PHP 和 Composer"
        echo "7) Rust 和 Cargo"
        echo "8) .NET Core SDK"
        echo "9) Docker"
        echo "10) Kubernetes 工具 (kubectl 和 Minikube)"
        echo "11) 返回上一级菜单"
        read -p "请输入选项数字: " env_choice

        case $env_choice in
            1)
                if ! command -v python3 &> /dev/null; then
                    echo "安装Python3和Pip..."
                    sudo apt-get update
                    sudo apt-get install -y python3 python3-pip
                else
                    echo "Python3已安装。"
                fi
                ;;
            2)
                if ! command -v node &> /dev/null; then
                    echo "安装Node.js和NPM..."
                    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
                    sudo apt-get install -y nodejs
                else
                    echo "Node.js已安装。"
                fi
                ;;
            3)
                if ! command -v java &> /dev/null; then
                    echo "安装OpenJDK..."
                    sudo apt-get install -y openjdk-11-jdk
                else
                    echo "Java已安装。"
                fi
                ;;
            4)
                if ! command -v go &> /dev/null; then
                    echo "安装Go语言..."
                    sudo apt-get install -y golang
                else
                    echo "Go已安装。"
                fi
                ;;
            5)
                if ! command -v ruby &> /dev/null; then
                    echo "安装Ruby和Gem..."
                    sudo apt-get install -y ruby-full
                else
                    echo "Ruby已安装。"
                fi
                ;;
            6)
                if ! command -v php &> /dev/null; then
                    echo "安装PHP和Composer..."
                    sudo apt-get install -y php-cli php-mbstring unzip
                    curl -sS https://getcomposer.org/installer | php
                    sudo mv composer.phar /usr/local/bin/composer
                else
                    echo "PHP已安装。"
                fi
                ;;
            7)
                if ! command -v rustc &> /dev/null; then
                    echo "安装Rust和Cargo..."
                    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
                    source $HOME/.cargo/env
                else
                    echo "Rust已安装。"
                fi
                ;;
            8)
                if ! command -v dotnet &> /dev/null; then
                    echo "安装.NET Core SDK..."
                    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
                    sudo dpkg -i packages-microsoft-prod.deb
                    sudo apt-get update
                    sudo apt-get install -y apt-transport-https
                    sudo apt-get install -y dotnet-sdk-5.0
                else
                    echo ".NET Core已安装。"
                fi
                ;;
            9)
                if ! command -v docker &> /dev/null; then
                    echo "安装Docker..."
                    sudo apt-get update
                    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
                    sudo apt-get update
                    sudo apt-get install -y docker-ce
                    sudo usermod -aG docker $USER
                else
                    echo "Docker已安装。"
                fi
                ;;
            10)
                if ! command -v kubectl &> /dev/null; then
                    echo "安装kubectl..."
                    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
                    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
                else
                    echo "kubectl已安装。"
                fi

                if ! command -v minikube &> /dev/null; then
                    echo "安装Minikube..."
                    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
                    sudo install minikube-linux-amd64 /usr/local/bin/minikube
                else
                    echo "Minikube已安装。"
                fi
                ;;
            11)
                echo "返回上一级菜单。"
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

# 函数：配置软件源
configure_repo() {
    echo "正在配置软件源..."
    IP_INFO=$(curl -s https://ipinfo.io)
    COUNTRY=$(echo "$IP_INFO" | grep "country" | cut -d '"' -f 4)
    echo "检测到您的IP所在国家: $COUNTRY"

    case $COUNTRY in
        CN)
            echo "检测到中国，推荐以下镜像源："
            echo "1) 阿里云"
            echo "2) 腾讯云"
            echo "3) 清华大学"
            echo "4) 手动输入源"
            read -p "请选择一个镜像源（输入数字）: " mirror_choice

            case $mirror_choice in
                1)
                    REPO_URL="https://mirrors.aliyun.com"
                    ;;
                2)
                    REPO_URL="https://mirrors.cloud.tencent.com"
                    ;;
                3)
                    REPO_URL="https://mirrors.tuna.tsinghua.edu.cn"
                    ;;
                4)
                    read -p "请输入自定义镜像源URL: " REPO_URL
                    ;;
                *)
                    echo "无效的选择，使用默认源。"
                    REPO_URL="http://archive.ubuntu.com"
                    ;;
            esac
            ;;
        *)
            echo "检测到其他国家，推荐使用官方源。"
            REPO_URL="http://archive.ubuntu.com"
            ;;
    esac

    if [ -f /etc/apt/sources.list ]; then
        sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
        echo "已备份当前的源配置文件：/etc/apt/sources.list.backup"
    fi

    if [[ "$REPO_URL" != "" ]]; then
        echo "正在更新源为: $REPO_URL"
        sudo sed -i "s|http://archive.ubuntu.com|$REPO_URL|g" /etc/apt/sources.list
        sudo apt-get update
        echo "软件源配置完成！"
    else
        echo "未选择有效的镜像源，跳过更新。"
    fi

    read -p "是否测试镜像源的连接速度？（y/n）: " test_speed
    if [[ "$test_speed" == "y" ]]; then
        echo "正在测试镜像源的连接速度..."
        ping -c 4 $(echo "$REPO_URL" | awk -F/ '{print $3}')
    fi
}

# 函数：设置系统时区
set_timezone() {
    echo "当前时区: $(timedatectl | grep "Time zone" | cut -d ':' -f 2)"
    read -p "请输入要设置的时区（例如 Asia/Shanghai）： " timezone
    sudo timedatectl set-timezone "$timezone"
    echo "时区已设置为: $(timedatectl | grep "Time zone" | cut -d ':' -f 2)"
}

# 函数：查看网络信息
show_network_info() {
    echo "网络信息:"
    echo "------------------------------------"
    echo "IP地址: $(hostname -I | awk '{print $1}')"
    echo "网关: $(ip route | grep default | awk '{print $3}')"
    echo "DNS: $(grep nameserver /etc/resolv.conf | awk '{print $2}')"
    echo "===================================="
}

# 函数：安装UFW（适用于Ubuntu/Debian）
install_ufw() {
    if ! command -v ufw &> /dev/null; then
        echo "正在安装UFW..."
        sudo apt-get update
        sudo apt-get install -y ufw
        echo "UFW安装完成！"
    else
        echo "UFW已安装。"
    fi
}

# 函数：安装Firewalld（适用于CentOS/RHEL/Fedora）
install_firewalld() {
    if ! command -v firewall-cmd &> /dev/null; then
        echo "正在安装Firewalld..."
        sudo yum install -y firewalld
        sudo systemctl start firewalld
        sudo systemctl enable firewalld
        echo "Firewalld安装完成！"
    else
        echo "Firewalld已安装。"
    fi
}

# 函数：开启端口（通用）
open_port() {
    local port=$1
    distro=$(detect_distro)

    case $distro in
        ubuntu|debian)
            sudo ufw allow "$port"
            echo "端口 $port 已开启（使用UFW）。"
            ;;
        centos|rhel|fedora)
            sudo firewall-cmd --zone=public --add-port="$port/tcp" --permanent
            sudo firewall-cmd --reload
            echo "端口 $port 已开启（使用Firewalld）。"
            ;;
        *)
            echo "不支持的系统，请手动配置防火墙。"
            ;;
    esac
}

# 函数：关闭端口（通用）
close_port() {
    local port=$1
    distro=$(detect_distro)

    case $distro in
        ubuntu|debian)
            sudo ufw delete allow "$port"
            echo "端口 $port 已关闭（使用UFW）。"
            ;;
        centos|rhel|fedora)
            sudo firewall-cmd --zone=public --remove-port="$port/tcp" --permanent
            sudo firewall-cmd --reload
            echo "端口 $port 已关闭（使用Firewalld）。"
            ;;
        *)
            echo "不支持的系统，请手动配置防火墙。"
            ;;
    esac
}

# 函数：开启所有端口（通用）
open_all_ports() {
    distro=$(detect_distro)

    case $distro in
        ubuntu|debian)
            sudo ufw allow from any to any
            echo "所有端口已开启（使用UFW）。"
            ;;
        centos|rhel|fedora)
            sudo firewall-cmd --zone=public --add-port=1-65535/tcp --permanent
            sudo firewall-cmd --zone=public --add-port=1-65535/udp --permanent
            sudo firewall-cmd --reload
            echo "所有端口已开启（使用Firewalld）。"
            ;;
        *)
            echo "不支持的系统，请手动配置防火墙。"
            ;;
    esac
}

# 函数：关闭所有端口（通用）
close_all_ports() {
    distro=$(detect_distro)

    case $distro in
        ubuntu|debian)
            sudo ufw deny from any to any
            echo "所有端口已关闭（使用UFW）。"
            ;;
        centos|rhel|fedora)
            sudo firewall-cmd --zone=public --remove-port=1-65535/tcp --permanent
            sudo firewall-cmd --zone=public --remove-port=1-65535/udp --permanent
            sudo firewall-cmd --reload
            echo "所有端口已关闭（使用Firewalld）。"
            ;;
        *)
            echo "不支持的系统，请手动配置防火墙。"
            ;;
    esac
}