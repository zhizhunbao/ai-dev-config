# .shared - AI 开发配置中心

此目录是 AI 开发工具的核心配置，包含 Skills、Agents、Workflows 等。

## 目录结构

```
.shared/
├── skills/           # 130+ Skills（技能）
├── agents/           # 9 Agents（AI 角色）
├── workflows/        # 20+ Workflows（工作流）
├── templates/        # 模板文件
├── commands/         # 命令定义
├── prompts/          # 提示词模板
└── rules.md          # 共享规则
```

## Skills 分类

### 开发相关 (dev-*)
| Skill | 用途 |
|-------|------|
| `dev-senior_architect` | 架构设计 |
| `dev-senior_backend` | 后端开发 |
| `dev-senior_frontend` | 前端开发 |
| `dev-senior_fullstack` | 全栈开发 |
| `dev-senior_data_engineer` | 数据工程 |
| `dev-senior_devops` | DevOps |
| `dev-senior_qa` | 质量保证 |
| `dev-senior_security` | 安全 |
| `dev-code_reviewer` | 代码审查 |
| `dev-tdd_guide` | TDD 指南 |
| `dev-tech_stack_evaluator` | 技术栈评估 |
| `dev-quality_standards` | 质量标准 |
| `dev-security_standards` | 安全标准 |
| `dev-documentation_standards` | 文档标准 |
| `dev-product_manager` | 产品管理 |
| `dev-ux_designer` | UX 设计 |

### AI 学习相关 (ai_learning-*)
- `ai_learning-cv` - 计算机视觉
- `ai_learning-dl` - 深度学习
- `ai_learning-llm` - 大语言模型
- `ai_learning-ml` - 机器学习
- `ai_learning-nlp` - 自然语言处理
- `ai_learning-rl` - 强化学习
- 更多...

## Agents

| Agent | 文件 | 角色 |
|-------|------|------|
| 需求分析师 | `analyst.agent.yaml` | 需求收集分析 |
| 产品经理 | `pm.agent.yaml` | PRD、用户故事 |
| 架构师 | `architect.agent.yaml` | 系统设计 |
| 开发者 | `dev.agent.yaml` | 代码实现 |
| Scrum Master | `sm.agent.yaml` | Sprint 管理 |
| 测试工程师 | `tea.agent.yaml` | 测试设计 |
| UX 设计师 | `ux-designer.agent.yaml` | 界面设计 |
| 技术作者 | `tech-writer/` | 文档编写 |
| 独立开发者 | `quick-flow-solo-dev.agent.yaml` | 快速全栈 |

## Workflows

### 完整开发流程 (full-development/)
一个命令完成从需求到部署的 10 个阶段。

### 分阶段流程
| 阶段 | 目录 | 工作流 |
|------|------|--------|
| 分析 | `1-analysis/` | create-product-brief, research |
| 规划 | `2-plan-workflows/` | create-prd, create-ux-design |
| 方案 | `3-solutioning/` | create-architecture, create-epics-and-stories |
| 实现 | `4-implementation/` | dev-story, code-review, sprint-planning |

### 快速流程 (bmad-quick-flow/)
- `quick-spec` - 快速规格定义
- `quick-dev` - 快速开发

## Templates

| 模板 | 用途 |
|------|------|
| `spec-template.md` | 规格文档 |
| `plan-template.md` | 技术方案 |
| `tasks-template.md` | 任务清单 |
| `checklist-template.md` | 检查清单 |
| `agent-file-template.md` | Agent 定义 |

## 使用方式

此目录通过 symlinks 被 `.agent/` 引用：

```
.agent/
├── skills -> ../.shared/skills
├── agents -> ../.shared/agents
├── workflows -> ../.shared/workflows
└── templates -> ../.shared/templates
```

各 AI 平台通过自己的配置文件引用这些内容。
