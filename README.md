**作者：江湖笔者**  
**联系邮箱：crazy2403@outlook.com**
---

# Linux 模块化配置脚本
---

## 面向人群

本脚本适用于以下人群：

1. **Linux 初学者**：
   - 如果你是 Linux 新手，希望快速配置系统环境（如安装 Python、Node.js、Java 等编程语言），本脚本提供了简单易用的菜单选项，帮助你快速完成环境搭建。

2. **开发者**：
   - 如果你是一名开发者，需要在 Linux 系统上配置开发环境（如 Docker、Rust、.NET Core 等），本脚本可以为你提供一键安装和配置功能，节省大量时间。

3. **运维人员**：
   - 如果你是一名运维工程师，需要快速配置网络环境（如防火墙、端口管理）或安装网络工具（如 XUI、V2ray、CFwarp 等），本脚本提供了便捷的操作选项。

4. **建站爱好者**：
   - 如果你希望快速搭建个人博客或文件存储服务（如 Hexo、Hugo、Alist、Cloudreve 等），本脚本可以帮助你快速完成建站工具的安装和配置。

5. **服务器管理员**：
   - 如果你需要管理服务器的 Swap 分区或安装面板工具（如宝塔面板、1Panel），本脚本提供了简单易用的管理功能。

6. **技术爱好者**：
   - 如果你对 Linux 系统配置和网络工具有兴趣，本脚本可以作为一个学习和测试的工具，帮助你快速体验各种功能。

---

通过精简内容，`README.md` 文件更加简洁明了，直接突出脚本的目标用户群体。
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

## 调用地址

请看 **一键调用指令**

## 一键调用指令

在终端中运行以下命令即可一键调用脚本：

```bash
bash <(curl -sL https://raw.githubusercontent.com/qinyuanchun03/linux-tool-test/main/index.sh)
```

## 使用说明

1. 运行上述一键调用指令后，脚本会自动下载并启动。
2. 根据提示选择需要配置的功能模块。
3. 按照菜单选项完成配置。

## 注意事项

1. 请确保系统已安装 `curl` 工具。如果未安装，可以使用以下命令安装：
   ```bash
   sudo apt-get install curl -y  # Ubuntu/Debian
   sudo yum install curl -y      # CentOS/RHEL
   ```

2. 部分功能需要管理员权限（`sudo`），请确保您有足够的权限运行脚本。

3. 使用本脚本前，请仔细阅读每个模块的警告信息，确保您了解相关操作的风险。

---

## 示例截图

### 主菜单
<img width="363" alt="b72152a985dd9cecc6b147f681616e6" src="https://github.com/user-attachments/assets/2b0e2ed0-b836-49b8-aedc-2ec51bf842e5" />

## 说明

请按照你的需要合理使用，小白请结合本仓库说明，分辨这个脚本和你需要达到的目的，避免因使用本脚本产生不必要的后果


---

## 贡献与反馈

如果您有任何问题或建议，欢迎提交 Issue 或 Pull Request：  
[GitHub 仓库](https://github.com/qinyuanchun03/linux-tool-test)

---

## 许可证

本项目采用 [MIT 许可证](https://opensource.org/licenses/MIT)。
