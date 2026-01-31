# AI Dev Config

> 跨平台 AI 编程助手统一配置框架

## 📁 目录结构

```
ai-dev-config/
├── core/                    # 核心资源
│   ├── skills/              # 130+ 技能定义
│   ├── agents/              # 9 Agent 角色配置
│   ├── workflows/           # 20+ 工作流定义
│   ├── templates/           # 模板文件
│   ├── commands/            # 命令定义
│   ├── prompts/             # Prompt 模板
│   └── rules/               # 规则定义
├── adapters/                # 平台适配器
│   ├── claude/              # Claude Code
│   ├── cursor/              # Cursor
│   ├── windsurf/            # Windsurf
│   ├── kiro/                # Kiro
│   ├── codex/               # OpenAI Codex
│   ├── antigravity/         # Antigravity
│   └── copilot/             # VS Code Copilot
├── references/              # 参考项目 (git submodules)
├── scripts/                 # 初始化脚本
└── README.md
```

---

## 🚀 快速开始

### 使用初始化脚本

```powershell
# Windows - 初始化所有平台
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform all

# 或指定单个平台
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform claude
```

```bash
# Unix/Mac
./scripts/init-project.sh --path ~/projects/my-app --platform all
```

### 手动设置

1. 复制 `core/` 目录到目标项目
2. 创建平台配置文件
3. 设置 symlinks 指向 `core/skills/` 等

---

## 📦 平台配置映射

| 平台            | 配置入口                          | Skills 目录       |
| --------------- | --------------------------------- | ----------------- |
| Claude Code     | `CLAUDE.md` + `.claude/`          | `.claude/skills/` |
| Cursor          | `.cursorrules`                    | `.cursor/rules/`  |
| Windsurf        | `.windsurfrules`                  | N/A               |
| Kiro            | `.kiro/steering/`                 | `.kiro/specs/`    |
| OpenAI Codex    | `AGENTS.md`                       | N/A               |
| Antigravity     | `.agent/`                         | `.agent/skills/`  |
| VS Code Copilot | `.github/copilot-instructions.md` | N/A               |

---

## 📚 核心资源

### Skills 分类

| 前缀            | 类别     | 示例                                       |
| --------------- | -------- | ------------------------------------------ |
| `dev-*`         | 开发相关 | `dev-senior_frontend`, `dev-code_reviewer` |
| `ai_learning-*` | AI 学习  | `ai_learning-ml`, `ai_learning-dl`         |
| `learning-*`    | 通用学习 | `learning-code_screenshot`                 |
| `career-*`      | 职业相关 | `career-resume`, `career-interview`        |

### Agents

| Agent      | 文件                   | 角色          |
| ---------- | ---------------------- | ------------- |
| 需求分析师 | `analyst.agent.yaml`   | 需求收集分析  |
| 产品经理   | `pm.agent.yaml`        | PRD、用户故事 |
| 架构师     | `architect.agent.yaml` | 系统设计      |
| 开发者     | `dev.agent.yaml`       | 代码实现      |
| 测试工程师 | `tea.agent.yaml`       | 测试设计      |

### Workflows

| 工作流       | 目录                                | 说明                |
| ------------ | ----------------------------------- | ------------------- |
| 完整开发流程 | `full-development/`                 | 需求→设计→开发→测试 |
| 快速流程     | `bmad-quick-flow/`                  | 快速规格+开发       |
| 分阶段流程   | `1-analysis/` ~ `4-implementation/` | 按阶段执行          |

---

## 📖 参考项目

| 项目                                                        | 说明                           |
| ----------------------------------------------------------- | ------------------------------ |
| [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD) | 最完整的 Agent 工作流框架      |
| [spec-kit](https://github.com/github/spec-kit)              | GitHub 官方 Spec-Driven 工具包 |
| [anthropic-skills](https://github.com/anthropics/skills)    | Agent Skills 开放标准          |

---

## 🔧 自定义

### 添加新 Skill

```
core/skills/
└── my-skill/
    ├── SKILL.md          # 必需，包含 YAML frontmatter
    ├── scripts/          # 可选
    └── templates/        # 可选
```

### 添加新平台适配器

1. 在 `adapters/` 下创建目录
2. 添加 `templates/` 子目录
3. 更新 `scripts/init-project.ps1`

---

## 📄 License

MIT
