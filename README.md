# Linux 模块化配置脚本

---



**作者：江湖笔者**  
**联系邮箱：crazy2403@outlook.com**

---

## 特别说明
- **测试环境**：本脚本已经在中国大陆服务器和海外 VPS 上进行了初步测试，确保基本功能的可用性。
- **当前版本**：当前版本为 `1.1.0`，不代表最终水平，仍需进一步优化和完善。
- **反馈与合作**：我们非常欢迎大家的反馈和合作，共同完善这个脚本。如果您有任何问题或建议，请提交 Issue 或 Pull Request。
- **代码公开**：本项目代码完全公开，您可以自由查看、修改和分发。
- **项目背景**：本项目基于 [DeepSeek](https://www.deepseek.com) 完成，感谢 DeepSeek 提供的技术支持。

---

## 目录
1. [简介](#简介)
2. [调用方式](#调用方式)
   - [GitHub Raw](#github-raw)
   - [jsDelivr](#jsdelivr)
   - [Cloudflare](#cloudflare)
3. [功能列表](#功能列表)
4. [使用说明](#使用说明)
5. [注意事项](#注意事项)
6. [面向人群](#面向人群)
7. [示例截图](#示例截图)
8. [贡献与反馈](#贡献与反馈)
9. [许可证](#许可证)

---

## 简介
本项目是一个 Linux 模块化配置脚本，旨在帮助用户快速配置系统环境、网络环境、网络工具、建站工具等。脚本支持多种调用方式，用户可以根据需求选择最适合的方式。

---

## 调用方式

### GitHub Raw
- 直接调用 GitHub 的原始文件。
- 示例命令：
  ```bash
  bash <(curl -sL https://github.com/qinyuanchun03/linux-tool-test/raw/main/index.sh)
  ```

### jsDelivr
- 通过 jsDelivr 的 CDN 调用脚本，适合全球用户，尤其是中国大陆地区。
- 示例命令：
  ```bash
  bash <(curl -sL https://cdn.jsdelivr.net/gh/qinyuanchun03/linux-tool-test@main/index.sh)
  ```

### Cloudflare
- 通过 Cloudflare 的自定义域名调用脚本，适合需要更高安全性和自定义域名的场景。
- 示例命令：
  ```bash
  bash <(curl -sL https://rules-key.jianghu.space/index.sh)
  ```

---

## 功能列表
1. **系统环境配置**：
   - 安装 Python、Node.js、Java、Go、Ruby、PHP、Rust、.NET Core、Docker 等编程环境。

2. **网络环境配置**：
   - 安装防火墙工具（UFW 或 Firewalld）。
   - 开启或关闭端口。
   - 开启或关闭所有端口。

3. **网络工具配置**：
   - 安装 XUI、V2ray、CFwarp、CFtunnel 等网络工具。

4. **简单建站配置**：
   - 安装 Hexo、Hugo、Alist、Cloudreve 等建站工具。

5. **Swap 管理**：
   - 创建、启用、禁用、查看和删除 Swap。

6. **面板管理**：
   - 安装宝塔面板（原版或开心版）和 1Panel。

---

## 使用说明
1. 运行上述任意一种调用方式启动脚本。
2. 根据提示选择需要配置的功能模块。
3. 按照菜单选项完成配置。

---

## 注意事项
1. **网络连接**：
   - 确保运行脚本的设备能够正常访问 GitHub、jsDelivr 或 Cloudflare。
   - 如果网络连接不稳定，可能会导致脚本加载失败。

2. **权限问题**：
   - 部分功能需要管理员权限（如安装软件、配置防火墙等），请确保以 `sudo` 权限运行脚本。

3. **脚本更新**：
   - 如果需要更新脚本，请重新下载最新版本，或直接通过 GitHub、jsDelivr、Cloudflare 调用最新版本。

---

## 面向人群
本脚本适用于以下人群：
1. **Linux 初学者**：快速配置系统环境。
2. **开发者**：快速搭建开发环境。
3. **运维人员**：快速配置网络环境和工具。
4. **建站爱好者**：快速搭建个人博客或文件存储服务。
5. **服务器管理员**：管理 Swap 分区或安装面板工具。
6. **技术爱好者**：学习和测试 Linux 系统配置和网络工具。

---

## 示例截图
### 主菜单
<img width="363" alt="b72152a985dd9cecc6b147f681616e6" src="https://github.com/user-attachments/assets/2b0e2ed0-b836-49b8-aedc-2ec51bf842e5" />

---

## 贡献与反馈
如果您有任何问题或建议，欢迎提交 Issue 或 Pull Request：  
[GitHub 仓库](https://github.com/qinyuanchun03/linux-tool-test)

---

## 许可证
本项目采用 [MIT 许可证](https://opensource.org/licenses/MIT)。

---
