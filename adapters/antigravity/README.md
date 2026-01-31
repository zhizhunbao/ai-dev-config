# Antigravity Adapter

> Antigravity AI (Google DeepMind) 平台适配器

## 配置文件

| 文件                | 用途                                  |
| ------------------- | ------------------------------------- |
| `.agent/`           | 主配置目录                            |
| `.agent/skills/`    | Skills 目录（symlink 到 core/skills） |
| `.agent/workflows/` | Workflows 目录                        |

## 快速开始

### 1. 使用初始化脚本

```powershell
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform antigravity
```

### 2. 手动设置

```bash
# 创建 .agent 目录
mkdir -p .agent

# 创建 symlinks
ln -s ../core/skills .agent/skills
ln -s ../core/workflows .agent/workflows
```

## 目录结构

```
.agent/
├── skills/       → core/skills/
├── workflows/    → core/workflows/
├── agents/       → core/agents/
└── templates/    → core/templates/
```

## 参考链接

- [Antigravity 文档](https://cloud.google.com/antigravity)
