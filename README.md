# AI Dev Config

跨平台 AI 开发配置中心 - 统一管理 Skills、Agents、Workflows，支持 Claude Code、Cursor、Windsurf、Kiro 等多种 AI 编程工具。

## 特性

- **130+ Skills** - 涵盖开发全流程的技能库
- **9 Agents** - 专业化的 AI 角色定义
- **20+ Workflows** - 从需求到部署的完整工作流
- **跨平台支持** - 一套配置，多平台使用
- **一键初始化** - 快速为新项目配置 AI 开发环境

## 支持的平台

| 平台 | 配置文件 | 状态 |
|------|----------|------|
| Claude Code | `CLAUDE.md` | ✅ |
| Cursor | `.cursorrules` | ✅ |
| Windsurf | `.windsurfrules` | ✅ |
| Kiro | `.kiro/steering/` | ✅ |
| VS Code Copilot | `.github/copilot-instructions.md` | ✅ |

## 快速开始

### 方式 1: 初始化脚本（推荐）

**Windows (PowerShell):**
```powershell
.\scripts\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform all
```

**Linux/Mac:**
```bash
./scripts/init-project.sh ~/projects/my-app all
```

### 方式 2: 手动复制

```bash
# 1. 复制 .shared 目录
cp -r /path/to/ai-dev-config/.shared /your-project/.shared

# 2. 创建 symlinks
mkdir .agent
cd .agent
ln -s ../.shared/skills skills
ln -s ../.shared/agents agents
ln -s ../.shared/workflows workflows
ln -s ../.shared/templates templates

# 3. 创建平台配置
cp .shared/rules.md CLAUDE.md
```

### 方式 3: Git Submodule

```bash
git submodule add https://github.com/yourname/ai-dev-config .ai-config
ln -s .ai-config/.shared .shared
```

## 目录结构

```
ai-dev-config/
├── .shared/
│   ├── skills/           # 130+ Skills
│   │   ├── dev-*/        # 开发相关
│   │   ├── ai_learning-*/# AI 学习相关
│   │   └── ...
│   ├── agents/           # 9 Agents
│   │   ├── analyst.agent.yaml
│   │   ├── architect.agent.yaml
│   │   ├── dev.agent.yaml
│   │   ├── pm.agent.yaml
│   │   └── ...
│   ├── workflows/        # 20+ Workflows
│   │   ├── full-development/  # 完整开发流程
│   │   ├── 1-analysis/
│   │   ├── 2-plan-workflows/
│   │   ├── 3-solutioning/
│   │   ├── 4-implementation/
│   │   └── ...
│   ├── templates/        # 模板文件
│   ├── commands/         # 命令定义
│   ├── prompts/          # 提示词
│   └── rules.md          # 共享规则
├── scripts/
│   ├── init-project.ps1  # Windows 初始化脚本
│   └── init-project.sh   # Linux/Mac 初始化脚本
├── docs/                 # 文档
└── README.md
```

## 核心功能

### 1. 完整开发工作流 (`/full-dev`)

一个命令，完成从需求到部署的完整流程：

```bash
/full-dev                # 启动或继续
/full-dev status         # 查看进度
/full-dev skip           # 跳过当前阶段
/full-dev goto backend   # 跳转到指定阶段
```

**10 个阶段：**
1. 需求分析 → `docs/requirements.md`
2. 产品需求文档 → `docs/prd.md`
3. 系统架构 → `docs/architecture.md`
4. 任务分解 → `docs/stories.md`
5. 数据库设计 → `docs/database.md`
6. 后端开发 → `src/backend/`
7. 前端开发 → `src/frontend/`
8. 测试 → `tests/`
9. 代码审查 → `docs/review-report.md`
10. 部署 → 部署配置

### 2. Agents（AI 角色）

| Agent | 角色 | 职责 |
|-------|------|------|
| `analyst` | 需求分析师 | 需求收集、分析、文档 |
| `pm` | 产品经理 | PRD、用户故事、验收标准 |
| `architect` | 架构师 | 系统设计、技术选型 |
| `dev` | 开发者 | 代码实现、单元测试 |
| `sm` | Scrum Master | Sprint 管理、进度跟踪 |
| `tea` | 测试工程师 | 测试设计、自动化测试 |
| `ux-designer` | UX 设计师 | 界面设计、交互设计 |
| `tech-writer` | 技术作者 | 文档编写 |
| `quick-flow-solo-dev` | 独立开发者 | 快速全栈开发 |

### 3. Skills（技能）

**开发 Skills:**
- `dev-senior_architect` - 架构设计
- `dev-senior_backend` - 后端开发
- `dev-senior_frontend` - 前端开发
- `dev-senior_fullstack` - 全栈开发
- `dev-senior_data_engineer` - 数据工程
- `dev-senior_devops` - DevOps
- `dev-senior_qa` - 质量保证
- `dev-code_reviewer` - 代码审查
- 更多...

**标准 Skills:**
- `dev-quality_standards` - 质量标准
- `dev-security_standards` - 安全标准
- `dev-documentation_standards` - 文档标准

## 配置说明

### 初始化后的项目结构

```
your-project/
├── .shared/              # 配置目录（从 ai-dev-config 复制）
├── .agent/               # Symlinks
│   ├── skills -> ../.shared/skills
│   ├── agents -> ../.shared/agents
│   ├── workflows -> ../.shared/workflows
│   └── templates -> ../.shared/templates
├── CLAUDE.md             # Claude Code 配置
├── .cursorrules          # Cursor 配置
├── .windsurfrules        # Windsurf 配置
├── .kiro/                # Kiro 配置
│   └── steering/
│       └── project.md
└── .dev-state.yaml       # 工作流状态（自动生成）
```

### 状态追踪

工作流进度保存在 `.dev-state.yaml`：

```yaml
project: my-app
current_phase: 3
phases:
  requirements:
    status: completed
  prd:
    status: completed
  architecture:
    status: in_progress
  # ...
```

## 自定义

### 添加新 Skill

1. 在 `.shared/skills/` 创建目录
2. 添加 `SKILL.md` 文件：

```markdown
---
name: my-skill
description: My custom skill
---

# My Skill

## Instructions
...
```

### 添加新 Workflow

1. 在 `.shared/workflows/` 创建目录
2. 添加 `workflow.md` 和 `steps/` 目录

### 添加新 Agent

1. 在 `.shared/agents/` 创建 `.agent.yaml` 文件
2. 定义 persona、capabilities、menu

## 来源

本项目的配置来自以下开源项目：

- [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD) - Agents & Workflows
- [GitHub Spec-Kit](https://github.com/github/spec-kit) - Templates
- [claude-skills](https://github.com/alirezarezvani/claude-skills) - Skills
- [Anthropic Agent Skills](https://github.com/anthropics/skills) - Skills 规范

## License

MIT
