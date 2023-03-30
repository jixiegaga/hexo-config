---
title: git缓存设置
date: 2023-03-10 10:09:17
tags: ["Git"]
categories: ["Git"]

---
# 修改git缓存 #
默认git的http post缓存为1MB，使用命令将git的缓存设为500MB   
```CMD
# 设置缓存为500MB
git config --global http.postBuffer 524288000

# 查看当前缓存
git config --global http.postBuffer
```