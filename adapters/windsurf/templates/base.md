# Project Rules - Windsurf Configuration

> 由 ai-dev-config 生成

## AI Behavior Guidelines

1. 使用中文进行解释和说明
2. 技术术语保留英文原文
3. 响应风格：简洁、可操作、结构化
4. 不确定时主动询问
5. 修改文件时显示 diff
6. 安全优先：不硬编码密钥

## Coding Standards

### 命名规范

- Python: `snake_case`
- JavaScript/TypeScript: `camelCase`
- React 组件: `PascalCase`
- CSS 文件: `kebab-case`

### 注释规范

- 使用双语注释（中文为主）
- 文件顶部添加块注释
- 复杂逻辑需要注释解释

### 格式规范

- Python: 4 空格缩进
- JavaScript/TypeScript: 2 空格缩进
- 每行最多 120 字符

## Security Guidelines

- 使用环境变量管理密钥
- 验证所有用户输入
- 使用参数化查询防止 SQL 注入
- 清理 HTML 防止 XSS

## Git Workflow

遵循 Conventional Commits：`<type>: <description>`

Types: feat, fix, refactor, docs, test, chore
