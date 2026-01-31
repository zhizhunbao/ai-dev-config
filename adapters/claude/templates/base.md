# Project Name - Claude Code Configuration

> 由 ai-dev-config 生成

## Project Context

[项目描述]

## AI Behavior Guidelines

1. **语言**: 使用中文进行解释和说明
2. **技术术语**: 保留英文原文，如 "PCA"、"API"、"React"
3. **响应风格**: 简洁、可操作、结构化
4. **不确定时**: 主动询问而非假设
5. **修改文件**: 显示变更差异（diff）
6. **安全优先**: 不硬编码密钥、不引入 XSS/SQL 注入

## Coding Standards

### 命名规范

- 使用描述性的变量和函数名
- Python: `snake_case`
- JavaScript/TypeScript: `camelCase`
- React 组件: `PascalCase`
- CSS 文件: `kebab-case`

### 注释规范

- 使用双语注释（中文为主，技术术语保留英文）
- 文件顶部添加块注释说明用途
- 复杂逻辑需要注释解释

### 格式规范

- Python: 4 空格缩进
- JavaScript/TypeScript: 2 空格缩进
- 每行最多 120 字符

## Security Guidelines

- 无硬编码的密钥（API keys、passwords、tokens）
- 所有用户输入已验证
- SQL 注入防护（参数化查询）
- XSS 防护（HTML 已清理）
- 使用环境变量管理敏感配置

## Git Workflow

遵循 Conventional Commits：

```
<type>: <description>

Co-Authored-By: Claude <noreply@anthropic.com>
```

Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`, `ci`, `style`

---

**Skills 目录**: `.claude/skills/`
