# Scrum 术语表 (Glossary)

## 核心概念

### Sprint

**定义**: 固定时长的开发周期，通常为 1-4 周。  
**作用**: 在 Sprint 结束时交付可工作的产品增量。  
**最佳实践**: 保持 2 周为标准周期。

---

### Product Backlog

**定义**: 产品待办事项列表，包含所有需要完成的功能、需求、改进项。  
**维护者**: Product Owner  
**特点**: 动态更新，按优先级排序。

---

### Sprint Backlog

**定义**: 当前 Sprint 要完成的用户故事和任务列表。  
**来源**: 从 Product Backlog 选取。  
**承诺**: 团队在 Sprint Planning 时承诺完成。

---

### User Story (用户故事)

**定义**: 从用户角度描述的功能需求。  
**格式**: 作为 [角色]，我想要 [功能]，以便 [价值]。  
**英文**: As a [role], I want [feature], so that [benefit].

---

### Acceptance Criteria (验收标准)

**定义**: 用户故事完成的具体条件。  
**格式**: Given-When-Then 或检查清单。  
**作用**: 明确 "完成" 的定义。

---

### Story Point (故事点)

**定义**: 衡量用户故事相对复杂度的单位。  
**范围**: 1, 2, 3, 5, 8, 13 (斐波那契数列)  
**注意**: 不等于时间，是相对估算。

---

### Velocity (速度)

**定义**: 团队每个 Sprint 完成的故事点数。  
**用途**: 预测未来 Sprint 的容量。  
**计算**: 取最近 3-5 个 Sprint 的平均值。

---

### Increment (增量)

**定义**: Sprint 结束时交付的可用产品版本。  
**要求**: 满足 Definition of Done。  
**特点**: 每个 Sprint 都应产出增量。

---

## 角色 (Roles)

### Product Owner (PO)

**职责**:

- 管理 Product Backlog
- 定义用户故事和优先级
- 代表业务需求
- 验收交付成果

---

### Scrum Master (SM)

**职责**:

- 确保 Scrum 流程正确执行
- 移除团队障碍
- 促进团队沟通
- 保护团队免受干扰

---

### Development Team (开发团队)

**职责**:

- 自组织完成 Sprint 任务
- 估算用户故事
- 交付产品增量
- 持续改进技术实践

---

## 仪式 (Ceremonies)

### Sprint Planning (冲刺规划会)

**时机**: Sprint 开始时  
**时长**: 2-4 小时 (2 周 Sprint)  
**输出**: Sprint Backlog 和 Sprint Goal

**议程**:

1. What: 选择本 Sprint 要做的用户故事
2. How: 拆分任务，估算工时

---

### Daily Standup (每日站会)

**时机**: 每天同一时间  
**时长**: 15 分钟  
**格式**: 站立进行

**三个问题**:

1. 昨天做了什么？
2. 今天要做什么？
3. 有什么阻碍？

---

### Sprint Review (冲刺评审会)

**时机**: Sprint 最后一天  
**时长**: 1-2 小时  
**参与者**: 团队 + 利益相关者

**内容**:

- 演示完成的功能
- 收集反馈
- 更新 Product Backlog

---

### Sprint Retrospective (冲刺回顾会)

**时机**: Sprint 最后一天 (Review 后)  
**时长**: 1 小时  
**参与者**: Scrum 团队

**讨论**:

- 做得好的 (Keep)
- 需改进的 (Improve)
- 行动项 (Actions)

---

## 工件 (Artifacts)

### Definition of Done (完成的定义)

**定义**: 用户故事被认为完成的标准清单。

**典型 DoD**:

- [ ] 代码已提交
- [ ] 测试通过
- [ ] 代码已 Review
- [ ] 文档已更新
- [ ] 无已知缺陷

---

### Definition of Ready (就绪的定义)

**定义**: 用户故事可以进入 Sprint 的条件。

**典型 DoR**:

- [ ] 故事清晰可理解
- [ ] 验收标准明确
- [ ] 依赖已识别
- [ ] 可以估算

---

### Burndown Chart (燃尽图)

**定义**: 显示 Sprint 剩余工作量随时间变化的图表。  
**X 轴**: Sprint 天数  
**Y 轴**: 剩余故事点/时间  
**用途**: 跟踪进度，预测完成情况

---

## 优先级框架

### MoSCoW 方法

| 级别   | 含义           | 处理                 |
| ------ | -------------- | -------------------- |
| Must   | 必须有         | 本 Sprint 必须完成   |
| Should | 应该有         | 尽量在本 Sprint 完成 |
| Could  | 可以有         | 有余量时完成         |
| Won't  | 不会有（暂时） | 放入后续 Sprint      |

---

### WSJF (权重最短作业优先)

**公式**:

```
WSJF = (业务价值 + 时间紧迫性 + 风险降低) / 工作量
```

**用途**: 量化优先级排序

---

## 估算方法

### Planning Poker (规划扑克)

**流程**:

1. 展示用户故事
2. 每人独立出牌
3. 同时亮牌
4. 讨论差异
5. 重新投票直到一致

---

### T-shirt Sizing (T恤尺码)

**映射**:
| 尺码 | 故事点 | 含义 |
| ---- | ------ | -------- |
| XS | 1 | 极小 |
| S | 2 | 小 |
| M | 3 | 中 |
| L | 5 | 大 |
| XL | 8 | 很大 |
| XXL | 13+ | 需要拆分 |

---

## 常用缩写

| 缩写 | 全称                   | 中文         |
| ---- | ---------------------- | ------------ |
| PO   | Product Owner          | 产品负责人   |
| SM   | Scrum Master           | Scrum 主管   |
| US   | User Story             | 用户故事     |
| AC   | Acceptance Criteria    | 验收标准     |
| SP   | Story Point            | 故事点       |
| DoD  | Definition of Done     | 完成的定义   |
| DoR  | Definition of Ready    | 就绪的定义   |
| WIP  | Work In Progress       | 进行中的工作 |
| MVP  | Minimum Viable Product | 最小可行产品 |

---

## 相关资源

- [Scrum Guide](https://scrumguides.org/)
- [Atlassian Agile Coach](https://www.atlassian.com/agile)
- [Mountain Goat Software](https://www.mountaingoatsoftware.com/)
