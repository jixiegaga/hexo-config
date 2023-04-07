---
title: lua异常处理
date: 2023-04-07 10:51:15
tags:
categories: Lua语言
---

# assert(v, message) #

+ 参数:
  + v: any 需要断言的值.
  + message: string 当v为nil或false时抛出的异常消息.
+ 作用：当v为nil或false时, 会调用``error(message, 1)``抛出异常消息并快速判断错误位置.   

---

# error(message [, level] ) #

+ 参数:
  + message: string 抛出的异常消息.
  + level: 整数 抛出异常的位置详细等级, 从0开始.
    + 当level = 1(默认), 调用error位置(文件+行号).
    + 当level = 2, 指出调用error的函数的函数.
    + 当level = 0, 不添加错误位置信息.
+ 作用: 根据level等级, 将异常的位置信息添加到message, 并抛出message异常消息.

---
