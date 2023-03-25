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

---

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
1. 安装Node.js环境:<https://nodejs.org/en/download/>   
2. 新建文件夹``D:\Personal Blog\hexo``，将旧电脑中保存的文件放入该文件夹内   
3. 在该文件夹内安装hexo   
   ```PowerShell
   npm install hexo-cli -g
   npm install
   ```   
4. 设置脚本执行策略
   ```PowerShell
   # 查看脚本执行策略
   # Restricted: 严格模式
   # Unrestricted: 下载未签名脚本时会询问
   # Bypass: 直接执行
   Get-ExecutionPolicy
   ```   
   当策略是Restricted时，将其设置成Unrestricted或Bypass模式   
   ```PowerShell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force
   ```   

---
