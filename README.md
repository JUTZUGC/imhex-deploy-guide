# ImHex 一键安装指南

> 第三方部署指南 · 非 ImHex 官方仓库。官方项目：[WerWolv/ImHex](https://github.com/WerWolv/ImHex)
> 内容来自官方文档（2026-11-04）。项目迭代快，请以[官方文档](https://docs.werwolv.net)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把安装包下载并校验好。

⚠️ 桌面图形应用，仅支持电脑端。macOS 构建未签名，首次打开要在「隐私与安全性」里手动放行；Linux 建议用对应发行版的 deb/rpm，其它发行版用 AppImage 或 Flatpak。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/imhex-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按你的系统下载官方安装包并完成安装，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## ImHex 是什么？

ImHex 是开源的面向逆向工程师与开发者的十六进制编辑器，自带类 C 模式语言（协议：GPL-2.0，<img src="https://img.shields.io/github/stars/WerWolv/ImHex?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

十六进制编辑器：字节修补与补丁管理、无限撤销、多类型数据解析、字符串与十六进制搜索，配合自定义模式语言把文件结构可视化，还能用数据处理器做解密与转换。

- 55739 stars，逆向圈常用
- 类 C 模式语言解析文件结构
- 无限撤销与补丁管理
- 内置数据处理器与解码器
- 支持插件扩展
- GPL-2.0

（来源：[官方仓库](https://github.com/WerWolv/ImHex)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 55739 stars | 社区活跃 |
| 模式语言解析复杂文件结构 | — |
| 界面信息密度高 | 适合逆向 |
| 插件生态可扩展 | — |
| 支持 Windows / macOS / Linux | — |
| GPL-2.0 | — |

| 需要注意 | 说明 |
|---|---|
| 上手门槛高于普通十六进制编辑器 | — |
| 模式语言需要单独学习 | — |
| 内存占用偏高 | — |
| macOS 包未签名 | — |
| 部分发行版需要 AppImage | — |
| 大文件仍需分页处理 | — |

> 以上基于官方文档与社区反馈整理（2026-11-04），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
curl -fL -o imhex.deb https://github.com/WerWolv/ImHex/releases/download/v1.38.1/imhex-1.38.1-Ubuntu-24.04-x86_64.deb
sudo dpkg -i imhex.deb
imhex --version
```

安装包来源：[https://github.com/WerWolv/ImHex#imhex](https://github.com/WerWolv/ImHex#imhex)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认各平台安装包与 macOS 未签名提示 | 已核对 2026-11-04 |
| 确认当前版本 v1.38.1 的产物命名 | 已核对 2026-11-04 |
| 未实测下载、安装与模式加载 | 说明 2026-11-04 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-04 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-04 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不带 MCP；本仓库的 MCP server 提供安装包选择、模式语言与常见问题说明。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-04）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\imhex-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 各平台安装包

| 平台 | 文件 |
|---|---|
| Windows | `imhex-*-Windows-x86_64.msi` 或便携版 zip |
| macOS | `imhex-*-macOS-arm64.dmg` / `x86_64.dmg` |
| Ubuntu / Debian | 对应版本的 `.deb` |
| Fedora / RHEL | 对应版本的 `.rpm` |
| 其它 Linux | `.AppImage`、`.flatpak`、`.snap` |

## 第一个模式

```c
struct Header {
    char magic[4];
    u32 version;
    u32 entry_count;
};

Header header @ 0x00;
```

保存为 `.hexpat` 后在 Pattern 面板加载，即可按结构高亮文件内容。

## 注意

- 模式语言是 ImHex 自有语法，不是标准 C
- 大文件建议用分页视图，避免一次读入内存
- 插件从官方插件仓库安装，别装来路不明的包
- macOS 版未签名，需要手动允许

## 常见坑

- macOS 打不开：在隐私与安全性里允许，或执行 `xattr -rd com.apple.quarantine`
- 模式加载报错：检查语法与偏移量，模式语言不是标准 C
- 打开大文件卡顿：启用分页视图
- Linux 缺依赖：优先用对应发行版的 deb/rpm
- 插件装不上：确认 ImHex 版本与插件 ABI 匹配
- 中文显示异常：在设置里切换字体与编码
- 便携版丢失配置：配置默认写在用户目录

## 免责声明

本仓库为第三方指南，与 ImHex 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-04），项目迭代快，请以[官方文档](https://docs.werwolv.net)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
