---
title: RO笔记
date: 2023-03-30 14:30:47
tags:
- RO
categories: "RO"
abstract: 不要看不要看!
message: RO的中文拼音缩写
wrong_pass_message: 别看！
wrong_hash_message: 抱歉, 这个文章不能被校验, 不过您还是能看看解密后的内容.
---

# UI #
## BaseGameNode类 底层基类 ##

### 初始化 ###
```Lua
--[[
    直接在Scene上创建一个Prefab(WIN_DEV下直接同步加载原始资源)
    然后调用initGameObject()将这个GameObject绑定
    -@return GameObject
]]
BaseGameNode:initPrefabGameObject(path)


--[[
    直接在Scene上创建一个空的GameObject
    然后调用initGameObject()将这个GameObject绑定
]]
BaseGameNode:initEmptyGameObject(name)


--[[
    绑定transform和gameObject到
    self.pTrasnform和self.pGameObject上
    -@param obj GameObject
]]
BaseGameNode:initGameObject(obj)
```

### 子父节点 ###  
```Lua
--[[
    第1种情况:
        -@param nodeChild nil
        -@param transformChild Transform
        作用: self.pTransform当作transformChild的父节点,
                子节点的世界坐标保持不变.
    第2种情况:
        -@param nodeChild BaseGameNode
        -@param transformChild nil
        作用: self.pTransform当做nodeChild.pTransform的父节点,
                子节点的世界坐标保持不变,
                并且self.children会加入nodeChild,
                nodeChild.parent设置成self
]]
BaseGameNode:addChild(nodeChild, transformChild)


--[[
    第1种情况:
        -@param nodeParent nil
        -@param transformParent Transform
        作用: transformParent当做self.pTransform的父节点,
                自身的世界坐标保持不变.
    第2种情况:
        -@param nodeParent BaseGameNode
        -@param transformParent Transform | nil
        作用: transformParent当做self.pTransform的父节点,
                自身的世界坐标保持不变,
                并且self.parent = nodeParent,
                nodeParent.children会加入self.
                注意当transformParent为nil时,
                nodeParent.pTransform会作为self.pTransform的父节点.
]]
BaseGameNode.setParent(nodeParent, transformParent)


--[[
    通过cleanup()销毁self.children中所有的BaseGameNode
]]
BaseGameNode:removeAllChildren()


--[[
    通过cleanup()销毁self.children中的某个BaseGameNode
    -@param cleanup boolean 当cleanup为false时,
        不会使用cleanup()销毁该节点, 只会将该节点从self.children中移除.
]]
BaseGameNode:removeChild(child, cleanup)


--[[
    第1种情况:
        -@param cleanup true
        作用: 通过cleanup()销毁自己
    第2中情况:
        -@param cleanup false
        作用: 不会是用cleanup()销毁自己, 但会置空self.parent = nil
]]
BaseGameNode:removeFromParent(cleanup)
```

### 销毁 ###
```Lua
--[[
    销毁self.pGameObject  
    流程:
        调用回调onCleanUp()
        移除update事件,
        移除Action事件,
        移除监听message事件(只能移除通过self的on监听的事件, 通过messageManager的on监听的事件不行),
        杀死DOTween动画,
        销毁GameObject(DestroyImmediate()方法销毁),
        将所有属性 = nil置空
]]
BaseGameNode:cleanup()
BaseGameNode:onCleanUp()    -- 默认空, 自行重写
```

### 状态 ###
```Lua
--[[
    设置self.pGameObject的active
    执行完毕后回调onActiveChange()
]]
BaseGameNode:setActive(ac)
BaseGameNode:onActiveChange(bValue) -- 默认空, 自行重写
```

### Update功能 ###
```Lua
--[[
    通过EventManager开启Update事件, 每帧调用update()
]]
BaseGameNode:triggerUpdate()
BaseGameNode:update()   -- 默认空(声明都没声明), 自行重写


--[[
    同上
]]
BaseGameNode:triggerLateUpdate()
BaseGameNode:lateUpdate()


--[[
    同上
]]
BaseGameNode:triggerFixedUpdate()
BaseGameNode:fixedUpdate()


-- 关闭update 需使用EventManager:removeXXX()
```

### Action功能 ###
```Lua
--[[
    -@param action Action
    通过EventManager执行action(其实就是调用action的逻辑函数)
]]
BaseGameNode:runAction(action)


--[[
    -@param action Action
    通过EventManager停止action
]]
BaseGameNode:stopAction(action)


--[[
    通过EventManager听说该节点的所有action
]]
BaseGameNode:stopAllAction()
```

### 监听 消息/事件 功能 ###
```Lua
--[[
    添加事件监听, 使用此方法添加的监听不用在节点销毁前手动移除
    -@param key number 需要在MessageManager定义消息id
    -@param fun fun(...):nil 回调函数
    -@param obj BaseGameNode 参数fun的self调用者
]]
BaseGameNode:addMessageListener(key, fun, obj)


--[[
    移除事件监听, 参数同上
]]
BaseGameNode:removeMessageListener(key, fun, obj)


--[[
    移除所有事件监听, 即使监听obj参数不是自己
]]
BaseGameNode:removeAllMessageListener()


--[[
    添加自身事件监听, 使用此方法添加的监听不用在节点销毁前手动移除,
    但是事件只适用于与在自己类内部使用, 也就是说事件id应该定义在自己类的文件里
    -@param key number 需要在self内定义消息id
    -@param fun fun():nil 回调函数
    -@param BaseGameNode 参数fun的self调用者
]]
BaseGameNode:on(key, fun, obj)


--[[
    移除通过BaseGameNode:on()注册的事件, 参数同,
    如果fun为nil但obj不为nil的话, 则移除所有该key的事件.
]]
BaseGameNode:off(key, fun, obj)


--[[
    触发通过BaseGameNode:on()注册的key事件
    -@param ... any 回调函数的参数
]]
BaseGameNode:send(key, ...)

--两种事件形式的区别是: 第一种的事件是所有类都可以监听的, 并且又MessageManager触发.
--  第二种事件是只有self自己可以监听的, 并且由自身self触发.
```


## BaseUbiUI ##
dsad

# 网络 #
asdasd