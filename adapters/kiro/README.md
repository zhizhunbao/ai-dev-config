# Kiro Adapter

> Kiro AI 平台适配器

## 配置文件

| 文件                        | 用途         |
| --------------------------- | ------------ |
| `.kiro/steering/project.md` | 项目配置     |
| `.kiro/steering/tasks.md`   | 任务配置     |
| `.kiro/specs/`              | 规格文档目录 |

## 快速开始

### 1. 使用初始化脚本

```powershell
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform kiro
```

### 2. 手动设置

```bash
# 创建目录结构
mkdir -p .kiro/steering
mkdir -p .kiro/specs

# 复制配置
cp adapters/kiro/templates/project.md .kiro/steering/project.md
```

## project.md 模板

参见 `templates/project.md`

## 参考链接

- [Kiro 文档](https://kiro.dev/docs)
