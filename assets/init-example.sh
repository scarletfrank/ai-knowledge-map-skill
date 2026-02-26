#!/bin/bash
# AI Knowledge Map 初始化示例脚本

# 用户需要提供的参数
WIKI_SPACE_TOKEN="your_wiki_space_token"  # 飞书知识库 token
DOMAIN="AI"  # 知识领域

# 1. 创建根目录结构
feishu_wiki create --space-id "$WIKI_SPACE_TOKEN" --title "$DOMAIN 知识地图" --obj-type wiki

# 2. 创建核心概念文件夹
feishu_wiki create --parent-token "root_wiki_token" --title "核心概念" --obj-type folder

# 3. 创建文章笔记文件夹  
feishu_wiki create --parent-token "root_wiki_token" --title "文章笔记" --obj-type folder

# 4. 创建索引页面
INDEX_CONTENT="# $DOMAIN 知识地图索引

## 核心概念
- [AI 基础概念](core_concepts_folder_link)

## 最新文章笔记
- 待添加...

## 统计信息
- 总概念数: 0
- 总文章数: 0
- 最后更新: $(date +%Y-%m-%d)"

feishu_doc create --folder-token "$WIKI_SPACE_TOKEN" --title "索引页面" --content "$INDEX_CONTENT"

echo "AI 知识地图初始化完成！"
echo "知识库地址: https://wiki.feishu.cn/space/$WIKI_SPACE_TOKEN"