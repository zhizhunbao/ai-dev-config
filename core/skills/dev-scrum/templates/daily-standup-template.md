# Daily Standup 记录模板

## Sprint {{SPRINT_NUMBER}} - Day {{DAY_NUMBER}}

**日期**: {{DATE}}  
**参与者**: {{PARTICIPANTS}}

---

## 🗣️ 今日站会

### {{MEMBER_NAME}}

**昨天完成**:

- {{YESTERDAY_1}}

**今天计划**:

- {{TODAY_1}}

**阻碍/风险**:

- {{BLOCKER_1}} (如无填 "无")

---

## 📊 Sprint 状态

### 任务看板快照

| 状态      | 任务数           | 故事点            |
| --------- | ---------------- | ----------------- |
| ⬜ Todo   | {{TODO_COUNT}}   | {{TODO_POINTS}}   |
| 🔄 WIP    | {{WIP_COUNT}}    | {{WIP_POINTS}}    |
| 🔍 Review | {{REVIEW_COUNT}} | {{REVIEW_POINTS}} |
| ✅ Done   | {{DONE_COUNT}}   | {{DONE_POINTS}}   |

### 燃尽进度

```
计划完成: {{EXPECTED_DONE}}%
实际完成: {{ACTUAL_DONE}}%
差异: {{VARIANCE}}% {{ON_TRACK ? "✅ 正轨" : "⚠️ 落后"}}
```

---

## 🚨 当前阻碍

| #   | 阻碍描述           | 影响用户故事 | 负责人 | 状态 |
| --- | ------------------ | ------------ | ------ | ---- |
| 1   | {{BLOCKER_DESC_1}} | US-XXX       | -      | ⏸️   |

---

## 📝 行动项

| 行动         | 负责人 | 截止 |
| ------------ | ------ | ---- |
| {{ACTION_1}} | -      | 今天 |

---

## 快速统计

- **Sprint 剩余天数**: {{REMAINING_DAYS}}
- **剩余故事点**: {{REMAINING_POINTS}}
- **每日需完成**: {{DAILY_VELOCITY}} 点

---

**下次站会**: {{NEXT_STANDUP}}
