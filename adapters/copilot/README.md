# VS Code Copilot Adapter

> GitHub Copilot (VS Code) 平台适配器

## 配置文件

| 文件                              | 用途       |
| --------------------------------- | ---------- |
| `.github/copilot-instructions.md` | 主配置文件 |

## 快速开始

### 1. 使用初始化脚本

```powershell
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform copilot
```

### 2. 手动设置

```bash
# 创建目录
mkdir -p .github

# 复制基础配置
cp adapters/copilot/templates/instructions.md .github/copilot-instructions.md
```

## copilot-instructions.md 模板

参见 `templates/instructions.md`

## 参考链接

- [GitHub Copilot 文档](https://docs.github.com/en/copilot)
- [Copilot 自定义指令](https://docs.github.com/en/copilot/customizing-copilot/adding-repository-custom-instructions-for-github-copilot)
