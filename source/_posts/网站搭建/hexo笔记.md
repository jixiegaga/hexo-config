---
title: hexo笔记
date: 2023-03-10 14:51:05
tags: ["hexo"]
categories: ["网站搭建"]
---

# 常用指令 #
```PowerShell
# 生成文章
hexo new "文章名"

# 部署本地服务器
hexo s

# 清楚缓存
hexo clean

# 生成静态文件
hexo g

# 部署远端服务器
hexo d

# 常用二连, 生成并部署, 以下两条作用一样
hexo g -d
hexo d -g
```   
其他指令参考文档:<https://hexo.io/zh-cn/docs/commands#generate>

# 新电脑部署旧网站 #
## 旧电脑操作 ##
保存hexo路径下的以下文件:   
>   scaffolds   
    source   
    themes   
    .gitignore   
    db.json   
    package-lock.json   
    package.json   
    _config.butterfly.yml   
    _config.landscape.yml   
>   _config.yml   

## 新电脑操作 ##
1. 在网站文件夹内初始化hexo(需先安装node.js环境)
    ```PowerShell
    # 安装 hexo-cli
    npm install hexo-cli -g

    # 安装依赖
    npm install
   ```
2. 将在旧电脑保存下来的东西丢进网站文件夹内


