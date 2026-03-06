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

## ✨ 验证的最佳实践流程 (2026-03-05)

### 推荐的完整工作流：
1. **使用 `feishu-doc-creator-skill` 创建云文档**
   - 支持完整的 Markdown 到飞书块转换
   - 自动处理权限（添加协作者）
   - 内容格式完美保留

2. **使用官方 API 移动到知识库**
   ```bash
   # 移动文档到知识库
   curl -X POST "https://open.feishu.cn/open-apis/wiki/v2/spaces/{space_id}/nodes/move_docs_to_wiki" \
     -H "Authorization: Bearer {access_token}" \
     -H "Content-Type: application/json" \
     -d '{
       "obj_type": "docx",
       "obj_token": "{document_id}",
       "parent_node_token": "{target_parent_token}"
     }'
   ```

3. **使用官方 API 更新标题（如果需要）**
   ```bash
   # 更新 Wiki 节点标题
   curl -X POST "https://open.feishu.cn/open-apis/wiki/v2/spaces/{space_id}/nodes/{node_token}/update_title" \
     -H "Authorization: Bearer {access_token}" \
     -H "Content-Type: application/json" \
     -d '{"title": "新标题"}'
   ```

### ⚠️ 重要提示
- **避免直接使用 `feishu-wiki` 技能**：经测试可能存在兼容性问题
- **优先使用官方 REST API**：更稳定可靠，错误信息明确
- **标题格式注意**：确保使用纯文本而非 JSON 格式

## 🤖 自动触发机制 (2026-03-06 更新)

### 触发关键词
当用户提到以下任一关键词时，**自动调用 ai-knowledge-map 技能**：
- "写篇文章" + "知识库"
- "记录到知识库"
- "添加到知识库"
- "保存到飞书"
- "写一篇技术文章" + "飞书"
- "整理成一篇文章" + "知识库"

### 自动化流程
```
用户请求 → 检测关键词 → 调用 ai-knowledge-map → 
1. 本地创建 Markdown 文章（workspace/）
2. 使用 feishu-md-parser 解析为飞书块格式
3. 使用 feishu_doc.create 创建云文档
4. 使用官方 API 添加完整内容（分批，每批≤50 块）
5. 使用官方 API 移动到知识库"文章笔记"目录
6. 返回文档链接和摘要
```

### 示例用法
**用户**: "学习下 edict 项目，整理成一篇文章，放入知识库"
**AI**: 
1. ✅ 检测关键词："整理成一篇文章" + "知识库"
2. ✅ 自动调用 ai-knowledge-map 技能
3. ✅ 本地创建 `edict-analysis-2026-03-04.md`
4. ✅ 使用 feishu-doc-creator-skill 创建飞书文档
5. ✅ 使用官方 API 移动到知识库
6. ✅ 返回："✅ 文章已创建：https://feishu.cn/docx/xxx"

### 注意事项
- **标题格式**：自动添加日期前缀 `YYYY-MM-DD`
- **存放位置**：默认放入"文章笔记"目录
- **内容完整**：确保 Markdown 文件有完整内容后再转换
- **分批添加**：飞书 API 限制每批最多 50 个块

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
# 1. 先创建完整内容的云文档
python feishu-doc-creator-skill/feishu-doc-orchestrator/scripts/orchestrator.py content.md "2026-03-05 文档标题"

# 2. 使用 curl 移动到知识库
curl -X POST "https://open.feishu.cn/open-apis/wiki/v2/spaces/7610312220454423754/nodes/move_docs_to_wiki" \
  -H "Authorization: Bearer $(get_access_token)" \
  -H "Content-Type: application/json" \
  -d '{"obj_type":"docx","obj_token":"DOC_ID","parent_node_token":"PARENT_TOKEN"}'
```