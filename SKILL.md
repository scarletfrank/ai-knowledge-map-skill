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

## ✨ 最佳实践：完整工作流 (2026-03-06)

### 推荐的三阶段工作流：
#### 第一阶段：本地 Markdown 维护
- 在 `articles-notes/` 目录维护原始 Markdown 文件
- 文件命名格式：`YYYY-MM-DD-主题.md`
- 便于版本控制、备份和离线查看
- 作为飞书文档的唯一源文件

#### 第二阶段：使用 feishu-doc-orchestrator 创建文档
```bash
# 最快创建方式 - 单命令完成全部步骤
python skills/feishu-doc-orchestrator/scripts/orchestrator.py \
  articles-notes/2026-03-06-edict-analysis.md \
  "2026-03-06 Edict 项目深度解析：三省六部制 AI 协作架构"
```

这个命令会自动完成：
- ✅ Markdown 解析为飞书块格式
- ✅ 创建飞书云文档（带正确标题）
- ✅ 自动处理权限（添加协作者+转移所有权）
- ✅ 批量添加所有内容块
- ✅ 验证文档可访问性
- ✅ 记录创建日志

#### 第三阶段：移动到知识库指定节点
```bash
# 识别目标节点并移动
# 根据文章内容自动判断目标位置：
# - 技术文档 → "关键技术" 节点
# - 学习笔记 → "文章笔记" 节点  
# - 概念定义 → "核心概念" 节点

curl -X POST "https://open.feishu.cn/open-apis/wiki/v2/spaces/{space_id}/nodes/move_docs_to_wiki" \
  -H "Authorization: Bearer {access_token}" \
  -H "Content-Type: application/json" \
  -d '{
    "obj_type": "docx",
    "obj_token": "{document_id}",
    "parent_node_token": "{target_parent_token}"
  }'
```

### 📋 节点分类规则
| 文章类型 | 目标节点 | 判断标准 |
|---------|---------|---------|
| **技术实现文档** | 核心概念/关键技术 | 包含代码、API、技术架构 |
| **学习笔记/总结** | 文章笔记 | 个人学习、踩坑经验、最佳实践 |
| **概念定义** | 核心概念/[领域] | 术语解释、概念说明、理论框架 |
| **项目文档** | 核心概念/项目 | 项目规划、需求文档、设计文档 |

### ⚠️ 重要提示
- **避免直接使用 `feishu-wiki` 技能**：经测试可能存在兼容性问题
- **优先使用官方 REST API**：更稳定可靠，错误信息明确
- **标题必须包含日期前缀**：`YYYY-MM-DD 主题` 格式
- **本地源文件是权威**：所有修改应在本地 Markdown 中进行，然后重新生成

## 🤖 自动触发机制 (2026-03-06)

当用户说出以下关键词组合时，自动触发知识库文章创建流程：

### 触发关键词
- "写篇文章" + ("知识库" | "飞书" | "记录")
- "记录到" + ("知识库" | "飞书")
- "添加到" + ("知识库" | "飞书")  
- "保存到" + ("知识库" | "飞书")
- "整理成一篇文章" + ("知识库" | "飞书")
- "写一篇技术文章" + ("知识库" | "飞书")

### 自动化流程
```
用户请求 → 检测关键词 → 调用 ai-knowledge-map → 
1. 在 articles-notes/ 目录创建 YYYY-MM-DD-主题.md
2. 使用 orchestrator.py 一键创建飞书文档
3. 根据内容分析确定目标知识库节点
4. 使用官方 API 移动到正确位置
5. 返回文档链接和摘要
```

### 本地文章管理
- 所有原始 Markdown 文件存放在 `articles-notes/` 目录
- 文件命名格式：`YYYY-MM-DD-主题.md`
- 便于版本控制、备份和离线查看
- 作为飞书文档的源文件，可随时重新生成

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

### 手动创建并移动文档（推荐方式）
```bash
# 1. 先在本地创建 Markdown 源文件
echo "# 2026-03-06 测试文章\n内容..." > articles-notes/2026-03-06-test.md

# 2. 使用 orchestrator 一键创建
python skills/feishu-doc-orchestrator/scripts/orchestrator.py \
  articles-notes/2026-03-06-test.md \
  "2026-03-06 测试文章"

# 3. 移动到知识库（根据内容判断目标节点）
curl -X POST "https://open.feishu.cn/open-apis/wiki/v2/spaces/7610312220454423754/nodes/move_docs_to_wiki" \
  -H "Authorization: Bearer $(get_access_token)" \
  -H "Content-Type: application/json" \
  -d '{"obj_type":"docx","obj_token":"DOC_ID","parent_node_token":"ARTICLES_NODE_TOKEN"}'
```