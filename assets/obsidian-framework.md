# Obsidian 知识库框架结构

## 目录结构
```
AI-Knowledge-Map/
├── concepts/           # 核心概念目录
│   ├── Agent.md        # 每个概念一个独立文件
│   ├── LLM.md
│   └── RAG.md
├── articles/           # 文章笔记目录  
│   └── 2026-02-24-article-summary.md
└── index.md            # 主索引页面
```

## 文件模板

### 概念文件模板 (concepts/{concept}.md)
```markdown
# {概念名称}

## 定义
{概念的精确定义}

## 相关概念
- [[相关概念1]]
- [[相关概念2]]

## 应用场景
{概念的实际应用场景}

## 参考资料
- [[文章笔记1]]
- [[文章笔记2]]
```

### 文章笔记模板 (articles/{date}-{title}.md)
```markdown
# {文章标题}

**日期**: {YYYY-MM-DD}
**来源**: {文章URL或来源}

## 核心要点
- {要点1}
- {要点2}

## 提取的概念
- [[概念1]]
- [[概念2]]

## 个人思考
{个人见解和关联}
```

### 主索引模板 (index.md)
```markdown
# AI 知识地图索引

## 核心概念
```dataview
list from "concepts"
```

## 最新文章笔记
```dataview
list from "articles"
sort file.ctime desc
limit 10
```

## 知识图谱
```dataviewjs
// 双向链接图谱
```
```