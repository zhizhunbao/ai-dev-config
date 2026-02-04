# Sprint 日期计算脚本

## 功能说明

计算 Sprint 的开始日期、结束日期和关键时间点。

---

## 计算规则

### 基本参数

```yaml
sprint_length: 10 # 工作日
week_days: [Mon, Tue, Wed, Thu, Fri] # 工作日
holidays: [] # 节假日列表
```

### Sprint 日期计算

```python
def calculate_sprint_dates(start_date, sprint_number, sprint_length=10):
    """
    计算 Sprint 的开始和结束日期

    Args:
        start_date: 项目开始日期 (YYYY-MM-DD)
        sprint_number: Sprint 编号 (1, 2, 3...)
        sprint_length: Sprint 长度(工作日)

    Returns:
        sprint_start: Sprint 开始日期
        sprint_end: Sprint 结束日期
    """

    # 计算已过去的工作日
    days_passed = (sprint_number - 1) * sprint_length

    # 从开始日期推算
    sprint_start = add_work_days(start_date, days_passed)
    sprint_end = add_work_days(sprint_start, sprint_length - 1)

    return sprint_start, sprint_end


def add_work_days(date, work_days):
    """添加工作日（跳过周末和节假日）"""
    current = date
    days_added = 0

    while days_added < work_days:
        current = current + 1 day
        if is_work_day(current):
            days_added += 1

    return current


def is_work_day(date):
    """判断是否为工作日"""
    if date.weekday() in [5, 6]:  # 周六、周日
        return False
    if date in holidays:
        return False
    return True
```

---

## Sprint 时间点

### 标准两周 Sprint 结构

| Day | 日期偏移 | 事件                 | 时长     |
| --- | -------- | -------------------- | -------- |
| 1   | +0       | Sprint Planning      | 2-4 小时 |
| 1-9 | +0 ~ +8  | Sprint Execution     | 每天     |
| 10  | +9       | Sprint Review        | 1-2 小时 |
| 10  | +9       | Sprint Retrospective | 1 小时   |

### 计算仪式日期

```python
def get_ceremony_dates(sprint_start, sprint_end):
    """获取 Sprint 仪式日期"""
    return {
        "planning": sprint_start,
        "daily_standup": "每个工作日",
        "review": sprint_end,
        "retrospective": sprint_end
    }
```

---

## 示例计算

### 输入

```yaml
project_start: 2026-02-10 # 周二
total_sprints: 6
sprint_length: 10
```

### 输出

| Sprint   | 开始日期   | 结束日期   | 周数       |
| -------- | ---------- | ---------- | ---------- |
| Sprint 1 | 2026-02-10 | 2026-02-21 | Week 1-2   |
| Sprint 2 | 2026-02-24 | 2026-03-07 | Week 3-4   |
| Sprint 3 | 2026-03-10 | 2026-03-21 | Week 5-6   |
| Sprint 4 | 2026-03-24 | 2026-04-04 | Week 7-8   |
| Sprint 5 | 2026-04-07 | 2026-04-18 | Week 9-10  |
| Sprint 6 | 2026-04-21 | 2026-05-02 | Week 11-12 |

---

## 节假日处理

### 配置节假日

```yaml
holidays_2026:
  - 2026-01-01 # 元旦
  - 2026-02-09 # 农历新年
  - 2026-02-10
  - 2026-02-11
  # ... 其他节假日
```

### 节假日影响

当 Sprint 包含节假日时:

1. Sprint 容量相应减少
2. 或者 Sprint 结束日期顺延

```python
def adjust_for_holidays(sprint_start, sprint_end, holidays):
    """调整节假日影响"""
    holiday_count = count_holidays_in_range(sprint_start, sprint_end, holidays)

    if holiday_count > 0:
        # 选项 1: 减少容量
        adjusted_capacity = base_capacity * (10 - holiday_count) / 10

        # 选项 2: 延长 Sprint
        adjusted_end = add_work_days(sprint_end, holiday_count)

    return adjusted_capacity, adjusted_end
```

---

## 里程碑日期

### Phase 里程碑计算

```python
def calculate_milestones(sprints, phase_mapping):
    """
    计算 Phase 里程碑日期

    phase_mapping: {
        "Phase 1": [1, 2],  # Sprint 1-2
        "Phase 2": [3, 4],  # Sprint 3-4
        "Phase 3": [5, 6]   # Sprint 5-6
    }
    """
    milestones = {}

    for phase, sprint_range in phase_mapping.items():
        last_sprint = max(sprint_range)
        milestone_date = sprints[last_sprint].end_date
        milestones[phase] = milestone_date

    return milestones
```

---

## 日期格式化

### 输出格式

```python
# 完整格式
"2026-02-10"  # ISO 格式

# 显示格式
"Feb 10, 2026"  # 友好显示
"02/10 - 02/21"  # 范围显示

# Markdown 格式
"2026-02-10 → 2026-02-21"  # 使用箭头
```

---

## 验证规则

- [ ] Sprint 不跨越周末开始或结束
- [ ] 节假日已正确计算
- [ ] Sprint 之间无缝衔接
- [ ] 里程碑日期与 Phase 对应
