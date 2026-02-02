# Adapters - 平台适配器

> 此目录包含各 AI 编程助手平台的适配器配置。
> 适配器负责将 core/ 中的资源转换为各平台的专有格式。

## 支持的平台

| 平台            | 适配器目录     | 配置入口                          | 状态      |
| --------------- | -------------- | --------------------------------- | --------- |
| Claude Code     | `claude/`      | `CLAUDE.md` + `.claude/`          | ✅ 完整   |
| Cursor          | `cursor/`      | `.cursorrules`                    | ✅ 完整   |
| Windsurf        | `windsurf/`    | `.windsurfrules`                  | ✅ 完整   |
| Kiro            | `kiro/`        | `.kiro/steering/`                 | ✅ 完整   |
| OpenAI Codex    | `codex/`       | `AGENTS.md`                       | ✅ 完整   |
| Antigravity     | `antigravity/` | `.agent/`                         | ✅ 完整   |
| VS Code Copilot | `copilot/`     | `.github/copilot-instructions.md` | ✅ 完整   |

## 适配器结构

每个适配器目录包含：

```
{platform}/
├── README.md           # 平台说明
├── generator.js        # 配置生成器 (可选)
├── templates/          # 平台专用模板
│   ├── base.md         # 基础配置模板
│   └── project.md      # 项目配置模板
└── examples/           # 使用示例
```

## 使用方式

### 手动复制

```bash
# 复制 Claude Code 配置
cp adapters/claude/templates/base.md CLAUDE.md

# 复制 Cursor 配置
cp adapters/cursor/templates/base.md .cursorrules
```

### 使用初始化脚本

```powershell
# Windows
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform all

# Unix/Mac
./scripts/init-project.sh --path ~/projects/my-app --platform all
```

## 配置生成流程

```
core/rules/*.md    →  适配器合并  →  平台配置文件
core/skills/*      →  symlink    →  .agent/skills/ (或等效目录)
core/workflows/*   →  symlink    →  .agent/workflows/
```

## 添加新平台

1. 在 `adapters/` 下创建平台目录
2. 添加 `templates/base.md` 基础配置
3. 更新 `scripts/init-project.ps1` 添加平台支持
4. 在此 README 中添加平台说明
