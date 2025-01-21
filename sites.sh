#!/bin/bash

# 脚本信息
SCRIPT_AUTHOR="江湖笔者"
SCRIPT_VERSION="1.0"
SCRIPT_DESCRIPTION="简单建站模块：安装 Hexo、Hugo、Alist 或 Cloudreve"
WARNING_MESSAGE="
====================================
警告：
====================================
1. 此部分涉及建站工具配置，操作前请确保您已了解相关技术知识。
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
    if ! command -v git &> /dev/null; then
        echo "安装 Git..."
        sudo apt-get update
        sudo apt-get install -y git
    fi

    if ! command -v node &> /dev/null; then
        echo "安装 Node.js..."
        curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi

    if ! command -v npm &> /dev/null; then
        echo "安装 NPM..."
        sudo apt-get install -y npm
    fi

    if ! command -v go &> /dev/null; then
        echo "安装 Go..."
        sudo apt-get install -y golang
    fi

    echo "系统环境配置完成！"
}

# 函数：安装 Hexo
install_hexo() {
    echo "正在安装 Hexo..."
    sudo npm install -g hexo-cli
    echo "Hexo 安装完成！"
    echo "使用以下命令创建 Hexo 项目："
    echo "  hexo init <项目名称>"
    echo "  cd <项目名称>"
    echo "  hexo server"
}

# 函数：安装 Hugo
install_hugo() {
    echo "正在安装 Hugo..."
    sudo apt-get install -y hugo
    echo "Hugo 安装完成！"
    echo "使用以下命令创建 Hugo 项目："
    echo "  hugo new site <项目名称>"
    echo "  cd <项目名称>"
    echo "  hugo server"
}

# 函数：安装 Alist
install_alist() {
    echo "正在安装 Alist..."
    curl -fsSL "https://alist.nn.ci/v3.sh" | bash -s install
    echo "Alist 安装完成！"
    echo "使用以下命令启动 Alist："
    echo "  ./alist server"
}

# 函数：安装 Cloudreve
install_cloudreve() {
    echo "正在安装 Cloudreve..."
    wget https://github.com/cloudreve/Cloudreve/releases/latest/download/cloudreve_linux_amd64.tar.gz
    tar -zxvf cloudreve_linux_amd64.tar.gz
    chmod +x cloudreve
    ./cloudreve &

    # 配置进程守护
    echo "正在配置 Cloudreve 进程守护..."
    cat <<EOF | sudo tee /etc/systemd/system/cloudreve.service > /dev/null
[Unit]
Description=Cloudreve
After=network.target

[Service]
ExecStart=$(pwd)/cloudreve
WorkingDirectory=$(pwd)
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl daemon-reload
    sudo systemctl start cloudreve
    sudo systemctl enable cloudreve

    echo "Cloudreve 安装完成！"
    echo "访问地址: http://<服务器IP>:5212"
    echo "默认用户名: admin@cloudreve.org"
    echo "默认密码: admin"
    echo "请尽快修改默认密码！"
}

# 显示建站工具菜单
show_sites_menu() {
    while true; do
        echo "建站工具菜单："
        echo "1) 安装 Hexo"
        echo "2) 安装 Hugo"
        echo "3) 安装 Alist"
        echo "4) 安装 Cloudreve"
        echo "5) 返回主菜单"
        read -p "请输入选项数字: " choice

        case $choice in
            1)
                setup_environment
                install_hexo
                ;;
            2)
                setup_environment
                install_hugo
                ;;
            3)
                setup_environment
                install_alist
                ;;
            4)
                setup_environment
                install_cloudreve
                ;;
            5)
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
    show_sites_menu
}

# 执行主函数
main