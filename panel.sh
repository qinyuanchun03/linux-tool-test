#!/bin/bash

# 脚本信息
SCRIPT_AUTHOR="江湖笔者"
SCRIPT_VERSION="1.0"
SCRIPT_DESCRIPTION="面板管理模块：安装宝塔面板（开心版、原版）和 1Panel"
WARNING_MESSAGE="
====================================
警告：
====================================
1. 此部分涉及面板安装和配置，操作前请确保您已了解相关技术知识。
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

# 函数：安装宝塔面板（原版）
install_bt_panel_official() {
    echo "正在安装宝塔面板（原版）..."
    wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh
    sudo bash install.sh
    echo "宝塔面板（原版）安装完成！"
}

# 函数：安装宝塔面板（开心版）
install_bt_panel_happy() {
    echo "正在安装宝塔面板（开心版）..."
    wget -O install.sh http://download.bt.cn/install/install_panel.sh
    sudo bash install.sh
    echo "宝塔面板（开心版）安装完成！"
}

# 函数：安装 1Panel
install_1panel() {
    echo "正在安装 1Panel..."
    curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh
    sudo bash quick_start.sh
    echo "1Panel 安装完成！"
}

# 显示面板管理菜单
show_panel_menu() {
    while true; do
        echo "面板管理菜单："
        echo "1) 安装宝塔面板（原版）"
        echo "2) 安装宝塔面板（开心版）"
        echo "3) 安装 1Panel"
        echo "4) 返回主菜单"
        read -p "请输入选项数字: " choice

        case $choice in
            1)
                install_bt_panel_official
                ;;
            2)
                install_bt_panel_happy
                ;;
            3)
                install_1panel
                ;;
            4)
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
    show_panel_menu
}

# 执行主函数
main