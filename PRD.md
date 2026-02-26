# 通用知识地图技能 PRD

## 1. Executive Summary

**Problem Statement**: 信息碎片化和缺乏结构化知识管理导致各领域专业人士难以系统性地积累、组织和复用专业知识。无论是AI研究员、金融风控专家、产品经理、架构师还是全栈开发者，都需要一个灵活的知识管理体系。

**Proposed Solution**: 提供一个通用的知识地图技能，支持两种存储后端（Feishu 和 Obsidian），适用于任何专业领域的知识管理需求。通过四层架构和双向链接，帮助用户构建个性化的知识体系。

**Success Criteria**:
- 支持多种专业领域的知识管理（AI、金融、产品、架构、开发等）
- 支持两种存储方案的无缝切换
- 知识库增长：每周 ≥5 个新概念（按领域定制）
- 用户参与度：每周 ≥3 次手动注释
- RSS 处理延迟 <1 小时（可选）

## 2. User Experience & Functionality

### User Personas
- **AI研究员/工程师**: 需要跟进最新大模型技术发展
- **金融风控专家**: 需要跟踪市场动态、风险模型和监管政策
- **产品经理**: 需要管理用户需求、竞品分析和产品规划
- **架构设计师**: 需要记录系统设计、技术选型和最佳实践
- **全栈开发者**: 需要整理编程语言、框架、工具链和部署经验
- **学习者**: 需要构建个人学习知识体系

### Core Features (Common to Both Backends)
- **知识捕获**: 支持RSS监控、手动输入、外部文章导入等多种方式
- **概念提取**: 从内容中自动识别核心概念并建立关联
- **知识组织**: 基于四层架构（核心概念、项目/产品、参考资料、日记/日志）
- **关联构建**: 双向链接建立概念间的关联关系
- **模板系统**: 领域特定的标准化模板（如技术方案模板、产品需求模板等）
- **搜索与导航**: 多维度检索（标签、全文、关联关系）

### Storage Backend Options

#### Feishu Backend
- **优势**: 团队协作、云端访问、移动端支持、实时同步
- **适用场景**: 需要团队共享、多设备访问、企业环境
- **技术实现**: 
  - 应用云空间创建云文档
  - 移动到用户创建的知识库
  - 赋予用户修改权限
  - 用户可通过知识库界面编辑应用云空间不可见的文档
- **依赖技能**: `feishu-docs-v2`（本地增强版，支持知识库同步）

#### Obsidian Backend  
- **优势**: 离线优先、本地存储、版本控制、高度自定义
- **适用场景**: 个人使用、注重隐私、需要 Git 版本控制
- **技术依赖**: 本地文件系统、Markdown 格式、GitHub 同步（可选）

### Domain-Specific Examples

#### AI领域知识地图
- **核心概念**: 大模型、RLHF、MoE、RAG等
- **项目层**: 具体AI应用项目、实验记录
- **参考资料**: 论文、技术博客、会议演讲
- **RSS源**: arXiv、AI相关新闻、技术博客

#### 金融风控知识地图  
- **核心概念**: VaR、信用评分、反欺诈、合规要求
- **项目层**: 风控模型开发、监管报告
- **参考资料**: 监管文件、学术论文、行业报告
- **RSS源**: 金融新闻、监管公告、经济数据

#### 产品管理知识地图
- **核心概念**: 用户画像、MVP、A/B测试、增长黑客
- **项目层**: 产品路线图、需求文档、用户反馈
- **参考资料**: 竞品分析、用户研究、市场报告
- **RSS源**: 产品博客、行业新闻、用户反馈平台

#### 技术架构知识地图
- **核心概念**: 微服务、容器化、Serverless、可观测性
- **项目层**: 系统设计文档、技术决策记录
- **参考资料**: 架构模式、最佳实践、故障复盘
- **RSS源**: 技术博客、架构会议、开源项目更新

### User Stories
- **As a** 专业人士, **I want to** 选择适合我领域的知识管理方案 **so that** 我可以高效积累专业知识
- **As a** 用户, **I want to** 选择存储后端（Feishu 或 Obsidian）**so that** 我可以根据工作环境使用最适合的方案
- **As a** 知识工作者, **I want to** 通过标准化模板快速记录知识 **so that** 保持知识库的一致性和可维护性
- **As a** 团队成员, **I want to** 与同事共享和协作编辑知识 **so that** 提升团队整体知识水平

### Acceptance Criteria
- [ ] 用户可以在初始化时选择专业领域和存储后端
- [ ] 提供领域特定的模板和示例
- [ ] 支持手动添加外部内容到知识库
- [ ] 核心概念被提取并与现有知识节点关联
- [ ] 四层知识架构在两种后端中都得到实现
- [ ] Feishu方案支持应用云空间→知识库的文档迁移流程

### Non-Goals
- 实时协作编辑（Obsidian 方案）
- 移动端原生应用开发
- 复杂的权限管理系统（超出基础协作需求）

## 3. Technical Specifications

### Architecture Overview
1. **Domain Abstraction Layer**: 支持不同专业领域的配置
2. **Storage Abstraction Layer**: 统一接口，屏蔽后端差异
3. **Content Processor**: 内容提取和格式化
4. **Knowledge Organizer**: 实现四层架构的知识组织
5. **Backend Adapters**: 
   - Feishu Adapter: 调用 `feishu-docs-v2` 技能，支持知识库同步
   - Obsidian Adapter: 操作本地 Markdown 文件

### Feishu Backend Implementation Details
- **知识库要求**: 用户需提供可访问的飞书知识库（Wiki Space）
- **文档创建**: 在用户指定的知识库中创建标准化结构
- **权限设置**: 需要 `wiki:wiki`, `docx:document`, `drive:file` 权限
- **框架初始化**: 自动创建核心概念、文章笔记文件夹和索引页面
- **模板应用**: 使用预定义模板确保知识库结构一致性

### Integration Points
- **Feishu**: 飞书 Open API（文档、知识库操作）
- **Obsidian**: 本地文件系统 + Git（可选）
- **External Services**: RSS 源、网页内容提取服务（可选）

### Security & Privacy
- **Feishu**: 所有数据存储在用户的私人飞书空间中，应用仅在创建时有临时访问权限
- **Obsidian**: 所有数据本地存储，可选加密同步
- **API Credentials**: 安全存储在 .env 中

## 4. Implementation Strategy

### Phase 1: Core Framework
- 实现领域抽象层和通用功能
- 开发 Feishu 后端适配器（支持知识库同步）
- 基础内容处理和知识组织

### Phase 2: Obsidian Support  
- 开发 Obsidian 后端适配器
- 实现本地文件操作和 Git 集成
- 四层架构的本地实现

### Phase 3: Domain Templates
- 为不同专业领域提供预设模板
- 领域特定的RSS源配置
- 个性化的工作流优化

## 5. Risks & Roadmap

### Technical Risks
- Feishu API 速率限制可能影响处理速度
- Obsidian 格式变更可能影响兼容性
- 不同领域的知识结构差异较大，需要灵活的抽象设计

### Success Metrics
- **Domain Adoption**: 不同专业领域的用户采用率
- **Knowledge Growth**: 每周新增概念数量（按领域统计）
- **User Engagement**: 每周手动操作次数
- **System Reliability**: 文档创建和同步成功率 ≥99%