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

**依赖技能**: `feishu-docs-v2` (增强版，支持知识库操作)

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

## Getting Started
1. 选择存储后端（Feishu或Obsidian）
2. 配置RSS源列表
3. 设置知识库基础结构
4. 开始每日知识捕获流程

## Configuration
根据选择的后端，需要相应的权限和配置：
- **Feishu**: 需要`docx:document`等相关API权限，通过`feishu-docs-v2`技能处理所有底层文档操作
- **Obsidian**: 需要本地文件写入权限和可选的Git仓库

## Architecture
- **业务逻辑层**: `ai-knowledge-map` 专注于知识地图的结构定义、模板管理和业务流程
- **基础能力层**: `feishu-docs-v2` 处理所有底层的飞书API调用、Markdown转换、权限管理等细节

## Usage Examples

### 初始化大模型知识地图
```bash
# 使用 feishu-docs-v2 的 wiki-create-doc 命令
node scripts/wiki-enhanced.js create-doc \
  --space-id 7610312220454423754 \
  --title "核心概念" \
  --structure "knowledge-map-root"
```

### 创建子概念文档
```bash
# 使用预定义的模板
node scripts/wiki-enhanced.js create-doc \
  --space-id 7610312220454423754 \
  --parent-node AiK2wHSHJi4E15kvZx3clycEn7g \
  --title "LLM 基础" \
  --template "concept-template"
```

### 批量创建知识地图结构
```bash
# 使用结构配置文件
node scripts/wiki-enhanced.js create-structure \
  --space-id 7610312220454423754 \
  --config ./ai-knowledge-map/config/ai-structure.json
```