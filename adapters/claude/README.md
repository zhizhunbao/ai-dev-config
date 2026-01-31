# Claude Code Adapter

> Claude Code (Anthropic) 平台适配器

## 配置文件

| 文件                    | 用途                                  |
| ----------------------- | ------------------------------------- |
| `CLAUDE.md`             | 主配置文件（项目根目录）              |
| `.claude/settings.json` | 设置文件                              |
| `.claude/skills/`       | Skills 目录（symlink 到 core/skills） |
| `.claude/hooks.json`    | Hooks 配置（可选）                    |

## 快速开始

### 1. 使用初始化脚本

```powershell
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform claude
```

### 2. 手动设置

```bash
# 复制基础配置
cp adapters/claude/templates/base.md CLAUDE.md

# 创建 .claude 目录
mkdir -p .claude

# 创建 skills 链接
ln -s ../../core/skills .claude/skills
```

## CLAUDE.md 模板

参见 `templates/base.md`

## 参考链接

- [Claude Code 文档](https://docs.anthropic.com/en/docs/claude-code)
- [Agent Skills 规范](https://agentskills.io/specification)
