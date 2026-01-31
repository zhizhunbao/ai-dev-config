# OpenAI Codex Adapter

> OpenAI Codex 平台适配器

## 配置文件

| 文件        | 用途                     |
| ----------- | ------------------------ |
| `AGENTS.md` | 主配置文件（项目根目录） |

## 快速开始

### 1. 使用初始化脚本

```powershell
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform codex
```

### 2. 手动设置

```bash
# 复制基础配置
cp adapters/codex/templates/agents.md AGENTS.md
```

## AGENTS.md 模板

参见 `templates/agents.md`

## 参考链接

- [Codex CLI 文档](https://github.com/openai/codex)
