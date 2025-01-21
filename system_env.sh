#!/bin/bash

# 脚本信息
SCRIPT_AUTHOR="江湖笔者"
SCRIPT_VERSION="1.0"
SCRIPT_DESCRIPTION="系统环境配置模块：配置编程环境"
WARNING_MESSAGE="
====================================
警告：
====================================
1. 此部分涉及编程环境配置，操作前请确保您已了解相关技术知识。
2. 使用本脚本可能会对您的系统环境产生影响，请谨慎操作。
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

# 函数：检测系统环境并安装依赖
setup_environment() {
    echo "正在检测系统环境并安装依赖..."
    if ! command -v curl &> /dev/null; then
        echo "安装 curl..."
        sudo apt-get update
        sudo apt-get install -y curl
    fi

    if ! command -v git &> /dev/null; then
        echo "安装 Git..."
        sudo apt-get install -y git
    fi

    echo "系统环境配置完成！"
}

# 函数：安装 Python 和 Pip
install_python() {
    if ! command -v python3 &> /dev/null; then
        echo "正在安装 Python3 和 Pip..."
        sudo apt-get install -y python3 python3-pip
        echo "Python3 和 Pip 安装完成！"
    else
        echo "Python3 已安装。"
    fi

    # 设置环境变量
    echo "设置 Python 环境变量..."
    export PATH="$PATH:/usr/bin/python3"

    # 验证安装
    echo "验证 Python 安装..."
    python3 --version
    pip3 --version
}

# 函数：安装 Node.js 和 NPM
install_nodejs() {
    if ! command -v node &> /dev/null; then
        echo "正在安装 Node.js 和 NPM..."
        curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt-get install -y nodejs
        echo "Node.js 和 NPM 安装完成！"
    else
        echo "Node.js 已安装。"
    fi

    # 设置环境变量
    echo "设置 Node.js 环境变量..."
    export PATH="$PATH:/usr/bin/node"

    # 验证安装
    echo "验证 Node.js 安装..."
    node --version
    npm --version
}

# 函数：安装 Java (OpenJDK)
install_java() {
    if ! command -v java &> /dev/null; then
        echo "正在安装 OpenJDK..."
        sudo apt-get install -y openjdk-11-jdk
        echo "OpenJDK 安装完成！"
    else
        echo "Java 已安装。"
    fi

    # 设置环境变量
    echo "设置 Java 环境变量..."
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    export PATH="$PATH:$JAVA_HOME/bin"

    # 验证安装
    echo "验证 Java 安装..."
    java --version
}

# 函数：安装 Go
install_go() {
    if ! command -v go &> /dev/null; then
        echo "正在安装 Go..."
        sudo apt-get install -y golang
        echo "Go 安装完成！"
    else
        echo "Go 已安装。"
    fi

    # 设置环境变量
    echo "设置 Go 环境变量..."
    export GOPATH=$HOME/go
    export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

    # 验证安装
    echo "验证 Go 安装..."
    go version
}

# 函数：安装 Ruby 和 Gem
install_ruby() {
    if ! command -v ruby &> /dev/null; then
        echo "正在安装 Ruby 和 Gem..."
        sudo apt-get install -y ruby-full
        echo "Ruby 和 Gem 安装完成！"
    else
        echo "Ruby 已安装。"
    fi

    # 设置环境变量
    echo "设置 Ruby 环境变量..."
    export PATH="$PATH:/usr/bin/ruby"

    # 验证安装
    echo "验证 Ruby 安装..."
    ruby --version
    gem --version
}

# 函数：安装 PHP 和 Composer
install_php() {
    if ! command -v php &> /dev/null; then
        echo "正在安装 PHP 和 Composer..."
        sudo apt-get install -y php-cli php-mbstring unzip
        curl -sS https://getcomposer.org/installer | php
        sudo mv composer.phar /usr/local/bin/composer
        echo "PHP 和 Composer 安装完成！"
    else
        echo "PHP 已安装。"
    fi

    # 设置环境变量
    echo "设置 PHP 环境变量..."
    export PATH="$PATH:/usr/bin/php"

    # 验证安装
    echo "验证 PHP 安装..."
    php --version
    composer --version
}

# 函数：安装 Rust 和 Cargo
install_rust() {
    if ! command -v rustc &> /dev/null; then
        echo "正在安装 Rust 和 Cargo..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        source $HOME/.cargo/env
        echo "Rust 和 Cargo 安装完成！"
    else
        echo "Rust 已安装。"
    fi

    # 设置环境变量
    echo "设置 Rust 环境变量..."
    export PATH="$PATH:$HOME/.cargo/bin"

    # 验证安装
    echo "验证 Rust 安装..."
    rustc --version
    cargo --version
}

# 函数：安装 .NET Core SDK
install_dotnet() {
    if ! command -v dotnet &> /dev/null; then
        echo "正在安装 .NET Core SDK..."
        wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        sudo apt-get update
        sudo apt-get install -y apt-transport-https
        sudo apt-get install -y dotnet-sdk-5.0
        echo ".NET Core SDK 安装完成！"
    else
        echo ".NET Core 已安装。"
    fi

    # 设置环境变量
    echo "设置 .NET Core 环境变量..."
    export PATH="$PATH:/usr/share/dotnet"

    # 验证安装
    echo "验证 .NET Core 安装..."
    dotnet --version
}

# 函数：卸载未配置好的 Docker
uninstall_docker() {
    echo "正在卸载未配置好的 Docker 组件..."
    sudo apt-get remove -y docker docker-engine docker.io containerd runc
    sudo rm -rf /var/lib/docker
    echo "Docker 组件卸载完成！"
}

# 函数：安装 Docker
install_docker() {
    echo "正在安装 Docker..."
    # 安装依赖工具
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    # 添加 Docker 官方 GPG 密钥
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # 添加 Docker 软件源
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # 更新软件包列表并安装 Docker
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    # 启动 Docker 服务并设置为开机启动
    sudo systemctl start docker
    sudo systemctl enable docker

    echo "Docker 安装完成！"
}

# 函数：安装 Docker Compose
install_docker_compose() {
    echo "正在安装 Docker Compose..."
    # 下载最新版本的 Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # 赋予执行权限
    sudo chmod +x /usr/local/bin/docker-compose

    # 创建符号链接（可选）
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    echo "Docker Compose 安装完成！"
}

# 函数：配置 Docker
configure_docker() {
    echo "正在配置 Docker..."
    # 将当前用户加入 docker 组
    sudo usermod -aG docker $USER

    # 配置 Docker 开机自启动
    sudo systemctl enable docker

    echo "Docker 配置完成！"
}

# 函数：验证 Docker 和 Docker Compose 安装
verify_docker_installation() {
    echo "验证 Docker 和 Docker Compose 安装..."
    docker_version=$(docker --version)
    docker_compose_version=$(docker-compose --version)

    if [ -n "$docker_version" ] && [ -n "$docker_compose_version" ]; then
        echo "Docker 和 Docker Compose 安装成功！"
        echo "Docker 版本: $docker_version"
        echo "Docker Compose 版本: $docker_compose_version"
    else
        echo "Docker 或 Docker Compose 安装失败，请检查日志。"
        exit 1
    fi
}

# 显示编程环境配置菜单
show_programming_env_menu() {
    while true; do
        echo "编程环境配置菜单："
        echo "1) 安装 Python 和 Pip"
        echo "2) 安装 Node.js 和 NPM"
        echo "3) 安装 Java (OpenJDK)"
        echo "4) 安装 Go"
        echo "5) 安装 Ruby 和 Gem"
        echo "6) 安装 PHP 和 Composer"
        echo "7) 安装 Rust 和 Cargo"
        echo "8) 安装 .NET Core SDK"
        echo "9) 安装 Docker 和 Docker Compose"
        echo "10) 返回主菜单"
        read -p "请输入选项数字: " choice

        case $choice in
            1)
                install_python
                ;;
            2)
                install_nodejs
                ;;
            3)
                install_java
                ;;
            4)
                install_go
                ;;
            5)
                install_ruby
                ;;
            6)
                install_php
                ;;
            7)
                install_rust
                ;;
            8)
                install_dotnet
                ;;
            9)
                uninstall_docker
                install_docker
                install_docker_compose
                configure_docker
                verify_docker_installation
                ;;
            10)
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
    setup_environment
    show_programming_env_menu
}

# 执行主函数
main