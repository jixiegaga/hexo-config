---
title: lua元表
date: 2023-02-01 21:29:31
tags: [元表, 原方法]
categories: [Lua语言]
---

---

# 元表 #

**元表**: 元表是一个与指定table相关联的table，它用于定义指定table的某些特定操作的行为。table默认的元表是nil。
**设置元表 setmetatable(table, metatable)**: 当table已经设置过元表，并且元表内定义了``__metatable``时，再次``setmetatable()``会报错。   
**获取元表 getmetatable(table)**: 当元表没有使用``setmetatable()``设置过时会返回nil。

# 元方法 #
**元方法**: 元表中的key表示**事件名**，value表示**元方法**，**元方法既可以是table也可以是function**

# 常用事件名 #
+ **__index**: 当读取t[key]时，key不存在或者t不是table，那么会出现两种情况
  1. 如果__index是table，那么会输出__index[key]
  2. 如果__index是function，那么会执行__index(t, key)
+ **__newindex**: 当赋值t[key]时，key不存在或者t不是table，那么会出现两种情况
  1. 如果__newindex是table，那么会赋值给__newindex[key]
  2. 如果__newindex是function，那么会执行__newindex[t, key, value]
+ **__metatable**: 当getmetatable(table)时，会返回__metatable而不是设置的元表本身
+ **__add**: 当t1 + t2时，会执行__add(t1, t2)   

其他事件名请按Lua版本参考   
5.1: <https://www.codingnow.com/2000/download/lua_manual.html>   
5.3: <https://www.runoob.com/manual/lua53doc/contents.html>
