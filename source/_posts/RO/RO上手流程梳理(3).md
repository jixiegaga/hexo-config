---
title: RO上手流程梳理(3)
date: 2023-02-01 19:40:38
tags:
- RO
categories: "RO"
abstract: 不要看不要看!
message: RO的中文拼音缩写
wrong_pass_message: 别看！
wrong_hash_message: 抱歉, 这个文章不能被校验, 不过您还是能看看解密后的内容.
---

---

# WIN_DEV环境下的流程 #
以下内容为梳理**fsm**、**procedureManager**和**procedureXXX**的关系，这三者构建成了一个类似有限状态机的模式.   
**fsm**的目录为 **src\basePackage\core\fsm**   
**procedureManager**的目录为 **src\basePackage\manager**   
**procedureXXX**的目录为 **src\basePackage\procedure**

## FsmBaseState 和 ProcedureXXX ##
``FsmBaseState``可以当做成状态基类   
``ProcedureXXX``则是具体的状态类   
1. ``FsmBaseState``状态基类的方法和变量
   1. 变量
      1. ``stateType``表示状态类型
      2. ``fsm``表示状态机
   2. 方法
      1. ``ctor()``构造函数，会在new()的时候执行
      2. ``init(stateType, fsm)``初始化函数，然后执行onInit()
      3. ``canChageFrom(lastState)``判断能否转换状态，相同状态不能转换
      4. ``onInit()``会在init()函数中调用
      5. ``onEnter(lastState)``进入该状态时调用
      6. ``onLeave(lastState)``退出该状态时调用
      7. ``onUpdate(dt, unScaledDt)``每帧调用
      8. ``onDestroy()``销毁该状态时调用
2. ``ProcedureXXX``具体状态类,不难理解

## Fsm ##


