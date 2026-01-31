# Windsurf Adapter

> Windsurf AI 平台适配器

## 配置文件

| 文件             | 用途                     |
| ---------------- | ------------------------ |
| `.windsurfrules` | 主配置文件（项目根目录） |

## 快速开始

### 1. 使用初始化脚本

```powershell
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform windsurf
```

### 2. 手动设置

```bash
# 复制基础配置
cp adapters/windsurf/templates/base.md .windsurfrules
```

## .windsurfrules 模板

参见 `templates/base.md`

## 参考链接

- [Windsurf 文档](https://codeium.com/windsurf)
