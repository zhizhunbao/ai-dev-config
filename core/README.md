# Core - AI 开发配置核心资源

> 此目录包含所有 AI 开发工具的核心配置资源。
> 各平台通过 symlinks 引用此目录的内容。

## 目录结构

```
core/
├── skills/           # 技能定义 (Agent Skills 规范)
├── agents/           # Agent 角色配置 (YAML 格式)
├── workflows/        # 工作流定义
├── templates/        # 模板文件
├── commands/         # 命令定义
├── prompts/          # Prompt 模板
└── rules/            # 共享规则
```

## Skills 分类

| 前缀            | 类别     | 数量 |
| --------------- | -------- | ---- |
| `dev-*`         | 开发相关 | 30+  |
| `ai_learning-*` | AI 学习  | 10+  |
| `learning-*`    | 通用学习 | 15+  |
| `career-*`      | 职业相关 | 5+   |
| 其他            | 生活工具 | 70+  |

## 使用方式

各平台通过 symlinks 引用：

```powershell
# Windows (使用 Junction)
cmd /c mklink /J ".agent\skills" "core\skills"

# Unix/Mac
ln -s core/skills .agent/skills
```

## 平台配置映射

| 平台            | 配置目录                          | symlink 目标    |
| --------------- | --------------------------------- | --------------- |
| Antigravity     | `.agent/`                         | `core/*`        |
| Claude Code     | `.claude/skills/`                 | `core/skills/*` |
| Cursor          | `.cursor/rules/`                  | `core/rules/*`  |
| VS Code Copilot | `.github/copilot-instructions.md` | N/A             |
