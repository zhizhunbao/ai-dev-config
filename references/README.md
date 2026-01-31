# References - 参考项目集合

> 本目录包含用于 Skill 和 Workflow 开发的参考项目。
> 大部分以 Git Submodule 形式管理。

## 工作流规范 (Workflow Specification)

### 1. BMAD-METHOD ⭐⭐⭐

> **Breakthrough Method of Agile AI Driven Development**

**最完整的工作流规范框架**，包含 21 个专业 Agent 和 50+ 个工作流。

- **GitHub**: https://github.com/bmad-code-org/BMAD-METHOD
- **文档**: https://docs.bmad-method.org

**标准工作流：**

```
/product-brief → /create-prd → /create-architecture → /create-epics-and-stories → /dev-story → /code-review
```

---

### 2. spec-kit ⭐⭐⭐

> **GitHub 官方 Spec-Driven Development 工具包**

- **GitHub**: https://github.com/github/spec-kit
- **博客**: https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/

**四阶段工作流：**

```
/specify → /plan → /tasks → /implement
```

---

### 3. Agent Skills 规范 (Anthropic 官方) ⭐⭐⭐

> **Agent Skills 开放标准规范**

- **GitHub**: https://github.com/anthropics/skills
- **规范**: https://agentskills.io/specification

**已采用平台：** Claude Code、Cursor、VS Code、GitHub Copilot、OpenAI Codex、Windsurf、Amp、Goose

---

## 其他参考

| 项目                      | 说明                    | GitHub                                                                                    |
| ------------------------- | ----------------------- | ----------------------------------------------------------------------------------------- |
| claude-flow               | 多 Agent 编排平台       | [ruvnet/claude-flow](https://github.com/ruvnet/claude-flow)                               |
| claude-skills             | 社区 Skills 集合        | [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills)           |
| claude-code-spec-workflow | Claude Code Spec 工作流 | [Pimzino/claude-code-spec-workflow](https://github.com/Pimzino/claude-code-spec-workflow) |

---

## 添加 Submodule

```bash
# 添加新的参考项目
git submodule add https://github.com/xxx/project-name references/project-name

# 更新所有 submodules
git submodule update --init --recursive
```
