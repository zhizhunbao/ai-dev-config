# Cursor Adapter

> Cursor AI 平台适配器

## 配置文件

| 文件                 | 用途                     |
| -------------------- | ------------------------ |
| `.cursorrules`       | 主配置文件（项目根目录） |
| `.cursor/rules/*.md` | 规则文件目录             |

## 快速开始

### 1. 使用初始化脚本

```powershell
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform cursor
```

### 2. 手动设置

```bash
# 复制基础配置
cp adapters/cursor/templates/base.md .cursorrules

# 或创建 rules 目录结构
mkdir -p .cursor/rules
cp adapters/cursor/templates/base.md .cursor/rules/project.md
```

## .cursorrules 模板

参见 `templates/base.md`

## 参考链接

- [Cursor 文档](https://docs.cursor.com/)
