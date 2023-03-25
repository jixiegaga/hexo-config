---
title: RO上手流程梳理(1)
date: 2023-01-31 20:17:33
tags:
- RO
categories: "RO"
abstract: 不要看不要看!
message: RO的SVN密码
wrong_pass_message: 别看！
wrong_hash_message: 抱歉, 这个文章不能被校验, 不过您还是能看看解密后的内容.
---

---

# WIN_DEV环境下的流程 #
main场景中的SceneControlNode挂载着程序入口脚本GameEntry.cs。   
GameEntry.cs位于Assets/Runtime/Game/目录下   

## GameEntry.cs生命周期函数 ##

**Start()方法**
1. 执行``this.Start();``，初始化工作
   1. 执行``this.initAttr();``，通过Find()获取场景中重要节点的transform
   2. 执行``this.InitManager();``，初始化各种管理器，一部分管理器通过AddComponent()挂载，一部分直接当成员变量new()出来
   3. 执行``loadManager.loadVersion(scb, fcb);``，加载版本文件
      1. scb为加载成功的回调函数
      2. fcb为加载失败的回调函数
      3. 这里会直接调用scb
2. 在scb中执行``this.StartGame();``
   1. 执行``ResourcesManager.loadFile(path, scb, fcb);``
      1. 执行``this.editorModelLoadFunctionList.Add();``，将一个匿名的加载函数Add()到List中

**Update()方法**   
1. 执行加载函数``this._loadFunction();``
   1. 依次调用this.editorModelLoadFuncitionList链表中的函数，并清空List
2. 更新组件，遍历m_UpdateComponentList链表的元素(双向链表，非数组)，调用元素的``OnUpdate();``
3. 更新Socket，原理同上调用元素的``OnUpdate();``
4. 更新Lua，调用``loop.Update();``，loop为MyLuaLooper类型的变量

## 解析``this.StartGame()``中的``ResourcesManager.loadFile()`` ##
由上可知执行ResourcesManager.loadFile()实际就是把一个匿名函数交给了一个List，然后在Update()中调用匿名函数。
但其实在**WIN_DEV**环境下啥也没加载。   
接着会调用``LuaManager.StartLua();``,一套下去会走执行``require("src/updatePackage/updataMain")``，也就是Lua中的
```Lua
require('src/updatePackage/updataMain.lua')
```

## 解析``updataMain.lua`` ##
1. 执行updateMain.lua的``UpdateMain();``
2. 执行updateMain.lua的``startMainPackage();``
3. 执行LuaManager.cs的``StartMain();``
4. ``require('src/basePackage/mainGame.lua')``

## 解析``mainGame.lua`` ##
1. ``require("src/basePackage/init.lua")``，在该.lua中主要是使用``require("src/basePackage/xxx")``去加载初始化basePackage目录下的各种模块
2. 执行mainGame.lua的``Main();``，这里是回到C#层调用的，不太理解为什么不直接在Lua层调用
3. 执行mainGame.lua的``loadMainRes();``，在该函数内添加下载任务，好像是只下载了一些语言字符串。
4. 任务下载成功后回调，gameManager.lua的``startGame()``

## 解析gameManager.lua的``startGame()``方法 ##
1. 使用event.lua模拟mono生命周期的Update, FixedUpdate 和 LateUpdate函数
    1. event的UpdateBeat，可以看作成Update事件。然后``startGame()``方法会将其他``xxxManager:Update()``方法当成监听者来监听UpdateBeat()
    2. event的FixedUpdateBeat同上
    3. event的LateUpdateBeat同上
2. 执行ProcedureManager.lua的``start();``
   1. 执行procedureManager.lua的``createProcedureFsm();``，通过fsm.lua来创建 游戏流程状态机
   2. 执行procedureManager.lua的``changeState(初始状态)``->fsm.lua的``changeState(初始状态)``，设置初始状态