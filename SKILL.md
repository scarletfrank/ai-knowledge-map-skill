# AI Knowledge Map Skill

## Overview
AI知识地图技能提供两种存储后端的个人知识管理系统：
- **Feishu方案**: 基于飞书文档的云端知识库，支持团队协作和跨设备同步
- **Obsidian方案**: 基于本地Markdown文件的知识库，支持版本控制和离线使用

## When to Use
- 需要系统化管理任何专业领域的知识体系（AI、金融、产品、架构、开发等）
- 希望自动跟踪领域相关的RSS源并提取核心概念
- 需要构建概念间的关联关系网络和知识图谱
- 要求知识库支持双向链接和可视化结构
- 希望将碎片化信息转化为结构化知识资产

## Storage Backend Selection

### Feishu Backend
**适用场景**: 
- 需要团队协作功能
- 重视云端访问和移动端支持  
- 偏好开箱即用的文档体验

**依赖技能**: `feishu-docs-v2`

**用户要求**:
- 必须提供一个可访问的飞书知识库（Wiki Space）链接或 token
- 确保应用有 `wiki:wiki`, `docx:document`, `drive:file` 权限

### Obsidian Backend  
**适用场景**:
- 偏好离线优先的工作流
- 需要本地存储和Git版本控制
- 要求高度自定义和插件扩展

**依赖工具**: 本地文件系统 + Git

## Core Features
- **RSS监控**: 自动跟踪配置的AI相关RSS源
- **概念提取**: 从文章中自动识别核心AI概念
- **知识组织**: 四层架构（核心概念/项目/参考资料/日记）
- **关联构建**: 双向链接建立概念间关系
- **外部导入**: 支持手动添加外部文章到知识库

## Framework Structure

### Obsidian 本地框架
```
AI-Knowledge-Map/
├── concepts/           # 每个概念一个文件
│   ├── Agent.md
│   ├── LLM.md
│   └── RAG.md
├── articles/           # 每篇文章的笔记
│   └── 2026-02-24-article-summary.md
└── index.md            # 主索引页
```

### Feishu 知识库框架
```
AI 知识地图 (Wiki Space)
├── 核心概念 (Folder)
│   ├── Agent 系列
│   │   ├── Deep Agent
│   │   ├── Autonomous Agent
│   │   └── ...
│   ├── LLM 基础
│   └── ...
├── 文章笔记 (Folder)
│   ├── 2026-02-24 Deep Agents Overview
│   └── ...
└── 索引页面 (Index Doc)
```

## Getting Started
1. 选择存储后端（Feishu或Obsidian）
2. **Feishu用户**: 提供可访问的知识库链接/token
3. 配置RSS源列表
4. 设置知识库基础结构
5. 开始每日知识捕获流程

## Configuration
根据选择的后端，需要相应的权限和配置：
- **Feishu**: 需要`docx:document`、`wiki:wiki`等相关API权限，用户提供目标知识库
- **Obsidian**: 需要本地文件写入权限和可选的Git仓库

## Assets
详细框架模板和初始化脚本位于 `assets/` 目录：
- `obsidian-framework.md`: Obsidian 本地文件结构和模板
- `feishu-framework.md`: Feishu 知识库结构和文档模板  
- `init-example.sh`: 初始化脚本示例