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

> !!注意以下文件目录不可变更, 如需变更则要更改所有脚本的内的文件路径   

## 旧电脑操作 ##   
   执行``一键部署并同步.bat``脚本

## 新电脑操作 ##   
1. 安装Node.js环境:<https://nodejs.org/en/download/>   
2. 在``D:\Personal Blog``目录, clone Github的``hexo-config``仓库    
3. 执行``迁移脚本.bat``脚本   
4. 在``D:\Personal Blog\hexo``安装hexo   
   ```PowerShell
   npm install hexo-cli -g
   npm install
   ```   
5. 设置脚本执行策略
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
