# Sprint 计划生成脚本

## 使用说明

此脚本指导 AI 助手如何从 PRD 文档生成完整的 Sprint 计划。

---

## 输入参数

```yaml
required:
  - prd_path: PRD 文档路径
  - start_date: Sprint 开始日期 (YYYY-MM-DD)

optional:
  - team_size: 团队人数 (默认: 1)
  - sprint_length: Sprint 天数 (默认: 10)
  - focus_factor: 专注系数 (默认: 0.7)
  - output_dir: 输出目录 (默认: docs/sprints/)
```

---

## 执行步骤

### Step 1: 解析 PRD

1. 读取 PRD 文档
2. 提取所有用户故事 (User Stories)
3. 提取验收标准 (Acceptance Criteria)
4. 识别 Phase 划分
5. 识别依赖关系

**输出格式**:

```yaml
stories:
  - id: US-001
    title: 用户故事标题
    phase: 1
    acceptance_criteria:
      - AC-1
      - AC-2
    dependencies: []
```

### Step 2: 估算故事点

1. 根据估算指南评估每个故事
2. 考虑以下因素:
   - 复杂度 (Complexity)
   - 工作量 (Effort)
   - 不确定性 (Uncertainty)
3. 使用斐波那契数列: 1, 2, 3, 5, 8, 13

**估算规则**:

```
1 点: 极简任务，≤0.5 天
2 点: 简单任务，0.5-1 天
3 点: 中等任务，1-2 天
5 点: 较复杂任务，2-4 天
8 点: 复杂任务，4-6 天
13 点: 极复杂，需拆分
```

### Step 3: 优先级排序

1. 使用 MoSCoW 方法分类:
   - P0 (Must Have): 核心功能，必须完成
   - P1 (Should Have): 重要功能，尽量完成
   - P2 (Could Have): 增强功能，有余量完成
   - P3 (Won't Have): 延后功能

2. 排序规则:
   - 优先处理 P0 任务
   - 考虑依赖关系
   - Phase 1 优先于 Phase 2

### Step 4: 计算 Sprint 容量

```python
def calculate_capacity(team_size, sprint_days, focus_factor):
    """计算 Sprint 容量"""
    ideal_hours = team_size * sprint_days * 8  # 每天 8 小时
    focused_hours = ideal_hours * focus_factor

    # 1 故事点 ≈ 4 小时
    story_points = focused_hours / 4

    return round(story_points)

# 示例: 单人 2 周
# capacity = 1 * 10 * 8 * 0.7 / 4 = 14 点
```

### Step 5: 分配用户故事到 Sprint

算法:

```python
def allocate_stories(stories, sprints, capacity_per_sprint):
    """将故事分配到 Sprint"""
    # 按优先级和依赖排序
    sorted_stories = sort_by_priority_and_deps(stories)

    for story in sorted_stories:
        for sprint in sprints:
            if sprint.remaining_capacity >= story.points:
                if all_deps_satisfied(story, sprint):
                    sprint.add(story)
                    break

    return sprints
```

### Step 6: 生成输出文件

1. 生成 `README.md` (Sprint 总览)
2. 生成 `sprint-X.md` (每个 Sprint 详情)
3. 更新模板占位符

---

## 示例执行

### 输入

```yaml
prd_path: docs/requirements/phase1_prd.md
start_date: 2026-02-10
team_size: 1
```

### 输出目录结构

```
docs/sprints/
├── README.md           # Sprint 总览
├── sprint-1.md         # Sprint 1: 基础架构
├── sprint-2.md         # Sprint 2: 核心功能
└── sprint-3.md         # Sprint 3: 完善优化
```

---

## 验证检查清单

生成后验证:

- [ ] 所有 PRD 用户故事已纳入计划
- [ ] 每个 Sprint 容量未超载
- [ ] 依赖关系正确处理
- [ ] 优先级合理分配
- [ ] 日期计算正确
- [ ] 模板占位符已替换

---

## 注意事项

1. **保守估算**: 宁可高估，不要低估
2. **预留 Buffer**: 保持 20-30% 余量
3. **依赖优先**: 确保依赖项先完成
4. **持续调整**: 计划可在 Sprint 中调整
