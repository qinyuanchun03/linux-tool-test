#!/bin/bash

# 脚本信息
SCRIPT_AUTHOR="江湖笔者"
SCRIPT_VERSION="1.0"
SCRIPT_DESCRIPTION="网络工具模块：安装 XUI、V2ray、CFwarp 或 CFtunnel"
WARNING_MESSAGE="
====================================
警告：
====================================
1. 此部分涉及高级网络工具配置，操作前请确保您已了解相关技术知识。
2. 使用本脚本可能会对您的网络环境产生重大影响，请谨慎操作。
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

# 函数：安装 XUI
install_xui() {
    echo "正在安装 XUI..."
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
    echo "XUI 安装完成！"
}

# 函数：一键配置 XUI
auto_configure_xui() {
    echo "一键配置 XUI 将执行以下操作："
    echo "1. 安装 XUI"
    echo "2. 设置账户密码为 admin"
    echo "3. 在 3389 端口运行"
    echo "===================================="
    read -p "请确认是否继续（输入 yes 继续，其他输入终止）: " confirm

    if [[ "$confirm" != "yes" ]]; then
        echo "用户取消操作，终止脚本。"
        exit 0
    fi

    # 安装 XUI
    install_xui

    # 配置 XUI
    echo "正在配置 XUI..."
    cat <<EOF > /etc/x-ui/x-ui.conf
{
  "web": {
    "port": 3389,
    "username": "admin",
    "password": "admin"
  }
}
EOF

    # 重启 XUI 服务
    systemctl restart x-ui
    echo "XUI 已配置完成！"
    echo "访问地址: http://<服务器IP>:3389"
    echo "用户名: admin"
    echo "密码: admin"
}

# 函数：安装 V2ray
install_v2ray() {
    echo "正在安装 V2ray..."
    bash <(curl -Ls https://install.direct/go.sh)
    echo "V2ray 安装完成！"
}

# 函数：安装 CFwarp
install_cfwarp() {
    echo "正在安装 CFwarp..."
    wget -N https://gitlab.com/rwkgyg/CFwarp/raw/main/CFwarp.sh
    chmod +x CFwarp.sh
    ./CFwarp.sh
    echo "CFwarp 安装完成！"
}

# 函数：安装 CFtunnel
install_cftunnel() {
    echo "正在安装 CFtunnel..."
    wget -N https://gitlab.com/rwkgyg/CFwarp/raw/main/CFtunnel.sh
    chmod +x CFtunnel.sh
    ./CFtunnel.sh
    echo "CFtunnel 安装完成！"
}

# 显示网络工具菜单
show_network_tools_menu() {
    while true; do
        echo "网络工具菜单："
        echo "1) 安装 XUI"
        echo "2) 一键配置 XUI（默认账户密码为 admin，端口 3389）"
        echo "3) 安装 V2ray"
        echo "4) 安装 CFwarp"
        echo "5) 安装 CFtunnel"
        echo "6) 返回主菜单"
        read -p "请输入选项数字: " choice

        case $choice in
            1)
                install_xui
                ;;
            2)
                auto_configure_xui
                ;;
            3)
                install_v2ray
                ;;
            4)
                install_cfwarp
                ;;
            5)
                install_cftunnel
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

# 主函数
main() {
    show_script_info
    show_network_tools_menu
}

# 执行主函数
main