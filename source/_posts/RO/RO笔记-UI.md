---
title: RO笔记-UI
date: 2023-03-30 14:30:47
tags:
- RO
categories: "RO"
# abstract: 不要看不要看!
# message: RO的中文拼音缩写
# wrong_pass_message: 别看！
# wrong_hash_message: 抱歉, 这个文章不能被校验, 不过您还是能看看解密后的内容.
---

# UI #
## 底层基类(不算是UI) BaseGameNode类 ##

最底层基类, 谁也没继承, 单纯的class()

### 比较疑惑的字段 ###
```Lua
--[[
    都是局部变量, 但是偶尔会出现bug, 所以时常使用RectTransform.anchoredPosition
    来替代.
]]
self._position
self._scale
self._rotation

--[[
    这个名字可以自己定的, 有set和get方法.
]]
self.__name
```

### 初始化 ###
```Lua
--[[
    直接在Scene上创建一个Prefab (同步加载)
    然后调用initGameObject()将这个GameObject绑定
    -@param path string "res/view/prefab/xxx/xxx.prefab"
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
    -@desc 移除所有逻辑子节点, 并直接执行cleanup()销毁
]]
BaseGameNode:removeAllChildren()


--[[
    -@param cleanup boolean 是否调用self:cleanup()销毁
    -@param child BaseGameNode对象 移除的子节点

    -@desc 移除某个指定的逻辑子节点(当cleanup为false时, 子节点的GameObject位置保持不对).
]]
BaseGameNode:removeChild(child, cleanup)


--[[
    -@param cleanup boolean 是否调用self:cleanup()销毁

    -@desc 从逻辑父节点移除自身(包括自身下面的子逻辑节点)

    !! 当self.parent为nil时, 也会执行cleanup()销毁.
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


## 二级派生类(不算UI) BaseViewItem ##

继承自BaseGameNode, BaseViewItem: BaseGameNode.

### 状态 ###
```Lua
--[[
    简单调用BaseGameNode的setActive().
]]
BaseViewItem:show()
BaseViewItem:hide()
```

### 资源下载/网络 ###
```Lua
--[[
    返回UI的prefab路径, 会在BaseViewItem:loadRes中使用, 一定要重写!!
    -@return string | table 如下:
        return "res/view/prefab/xxx/xxxLayer.prefab"
        return { "res/view/prefab/xxx/xxxLayer.prefab" }
]]
BaseViewItem:getAssetPath()

--[[
    通过DownLoadManager进行异步加载BaseViewItem:getAssetPath()的路径
    -@param scb fun():nil 加载成功的回调
    -@param fcb fun():nil 加载失败的回调
    -@param silience boolean 是否进行静默下载(不显示加载界面进度)
]]
BaseViewItem:loadRes(scb, fcb, silience)
```

## 三级派生类(UI的底层节点基类) BaseUINode ##

继承自 BaseViewItem, BaseUINode: BaseViewItem.

### 初始化(同BaseGameNode基本一样) ###
```Lua
--[[
    重写了BaseGameNode:initEmptyGameObject()

    在场景上创建一个空的GameObject, 
    然后调用BaseGameNode:initGameObject()绑定pTransform和pGameObject.
    -@param name string 创建GameObject的游戏对象名
    -@param comp nil | Component 创建时附带要添加的组件, 为nil时自动添加RectTransform
    -@return nil
]]
BaseUINode:initEmptyGameObject(name, comp)


--[[
    重写了BaseGameNode:initGameObject()

    绑定obj给pGameObject和pTransform, 
    并调用BaseUINode:autoMatchingText(), 并不知道作用...
    -@param obj GameObject
]]
BaseUINode:initGameObject(obj)


--[[
    重写了BaseGameNode:initPrefabGameObject()

    在场景上创建该prefab的GameObject (通过同步加载),
    然后调用BaseGameNode:initGameObject()绑定pTransform和pGameObject, 
    并调用BaseUINode:autoMatchingText(), 并不知道作用...
    -@param path string "res/view/prefab/xxx/xxx.prefab"
    -@return GameObject
]]
BaseUINode:initPrefabGameObject(path)
```

### 特殊方法(添加maskLayer) ###
```Lua
--[[
    添加maskLayer, 就是UI后面盖了一层黑色透明布的感觉.
    添加的位置在pTransform的子节点下的第一个节点(所以要在其他GameObject生成完再调用).
    -@param cb fun():nil 点击maskLayer区域的回调函数(通常是关闭UI, BaseGameNode:removeFromParent())
    -@param alpha number 0~1, maskLayer的黑色程度, 通常填nil
    -@param isPassEvent boolean 不懂, 通常填false
    -@return Transform 该maskLayer的Transform.
]]
BaseUINode:addMaskLayer(cb, alpha, isPassEvent)


--[[
    添加高斯模糊背景图 (没用过)
]]
BaseUINode.addBlurTexture(color)
```

## 四级派生类(UI节点类) BaseUI ##

继承自BaseUINode, BaseUI: BaseUINode

### 初始化 ###
> 注意遗弃的方法:   
> ``BaseUINode:initPrefabGameObject()`` 改用 ``BaseUI:initPanel()``.   

```Lua
--[[
    重写了BaseUINode:initEmptyGameObject()

    在场景上创建一个空的GameObject,
    并添加RectTransform组件,
    并绑定pGameObject和pTransform.
]]
BaseUI:initEmptyGameObject(name)


--[[
    创建一个空的游戏对象uiRoot, 并将pTransform和pGameObject绑定到它上面(pGameObject是nil才有这一步),
    然后创建一个self.panel = BaseUINode:new(), 
    并调用self.panel的initPrefabGameObject()进行初始化, 
    并通过self.addChild()将self.panel作为子节点.
    -@param path string panel的预制体地址 "res/view/prefab/xxx/xxxLayer.prefab"
    -@return GameObject panel的游戏对象
]]
BaseUI:initPanel(path)


--[[
    创建一个空的游戏对象uiRoot, 并将pTransform和pGameObject绑定到它上面(pGameObject是nil才有这一步), 
    然后创建一个self.panel = BaseUINode:new(),
    并调用self.panel的initGameObject(go)进行初始化,
    并通过self.addChild()将self.panel作为子节点.
    -@pram go GameObject 作为self.panel.pGameObject的游戏对象
    -@return GameObject self.panel.pGameObject
]]
BaseUI:initPanelGameObject(go)
```

### 子父节点 ###

> 当添加子节点是node是BaseGameNode及派生类时, 使用BaseUI:addSubLayer().   

```Lua
--[[
    同BaseGameNode:addChild()一样.
]]
BaseUI:addSubLayer(layer)
```

### 销毁 ###
```Lua

--[[
    重写了BaseGameNode:cleanup().

    只是在原本的基础上加入self.panel的DOKill().
]]
BaseUI:cleanup()


--[[
    不建议使用该接口, 应改用BaseUI:defaultClose()
    实际上是调用 BaseGameNode:removeFromParent().
]]
BaseUI:removeSelf()


--[[
    可重写 !!

    实际上要销毁时应该调用该接口, 因为该接口会被android的返回键调用, 
    有特殊处理时可以直接重写该接口.
    
    调用该接口会出现两种情况:
    1. 当该BaseUI作为系统的主界面时, 也就是绑定了id和Control时, 实际上调用的是
        Control里的removeView(), 同样会调用BaseUI:removeSelf().
    2. 当该BaseUI只是作为一个普通一级界面时, 只会调用BaseIO:remvoeSelf().
]]
BaseUI:defaultClose()


--[[
    快速设置关闭按钮, 调用的是BaseUI:defaultClose().
    -@param btnTransform Transform 含有button组件的Transform
]]
BaseUI:addClickDefaultClose(btnTransform)
```   

> 总结: 有关闭按钮就调用``BaseUI:addClickDefaultClose()``,   
> 需要调用关闭接口就调用``BaseUI.defaultClose()``, 不要调用removeSelf().

### 特殊方法(UI浮入DOTween) ###
```Lua
--[[
    self.panel.pTransform播放浮入动画, 使用DOTween实现, 
    当动画还在播放时self.isAnimation == true.
    并且为了播放该动画会在self.panel.pTransform上添加CanvasGroup组件,
    用于控制透明度动画.
    -@param time number 动画时间
]]
BaseUI:floatIn(time)
```

### 特殊方法(ui放大进入DOTween) ###
```Lua
--[[
    self.panel.pTransform播放放大动画, 使用DOTween实现,
    当动画还在播放时self.isAnimation == true.
    -@param time number 动画时间
]]
BaseUI:scaleIn(time)
```

## 五级派生类(UI节点类) BaseSubUI ##

### 销毁 ###
```Lua
--[[
    重写了BaseUI:removeSelf().

    不建议使用该接口, 应改用BaseUI:defaultClose().
    实际调用了BaseGameNode:removeFromParent().
]]
BaseSubUI:removeSelf()
```

## 不同类的使用规律总结 ##

以下说明了什么情况用什么, 怎么用.

### 当创建的是类似于玩家头像节点这样的UI时 ###  

+ 继承自BaseUINode, 命名为nodeXXX.
+ 节点创建完需要在外部设置父节点
+ 基础定义框架:
  + A: 公共节点框架(单独一个prefab文件):
    ```Lua
    --[[
          注意注意是异步的 !!!

        外部通过该接口创建Node.
        不用重写getAssetPath().
        -@param param1 any 初始化参数1
        -@param param2 any 初始化参数2
    ]]
    function NodeXXX:create(param1, param2)
        local node = NodeXXX:new(param1, param2)
        return node
    end


    function NodeXXX:ctor(param1, param2)
        BaseUINode.ctor(self)

        -- 在此进行变量初始化
        self._a = param1
        self._b = param2
        self._nodeGameObject = nil
        self._nodeTransform = nil

        self:init()
    end


    --[[
        在此处进行Node预制体的异步加载, 并通过回调函数进行其他初始化工作.
    ]]
    function NodeXXX:init()
        self:initEmptyGameObject("node_XXX") -- 绑定pTransform, pGameObject.

        ---@param prefabGameObject GameObject 异步加载成功的预制体GameObject.
        local function onDownloadSucc(prefabGameObject)
            self._nodeGameObject = prefabGameObject
            self._nodeTransform = prefabGameObject.transform
            self:addChild(nil, self._nodeTransform)
            self:initComponents()
            self:initXXX()
            self:setXXX()
        end

        local function onDownloadFail()
            logError("NodeXXX load failed, path:" + NodeXXX.PrefabPath)
        end

        -- 异步加载并回调, 最后一个参数必填self.pGameObject.
        ResTool:getPrefabGameObjectAsyn(NodeXXX.prefabPath,
            onDownloadSucc,
            onDownloadFail,
            self.pGameObject
        )
    end
    ```
  + B: 某一层的私有节点框架(节点的prefab直接放某一层的prefab里):
    ```Lua
    --[[
        外部通过该接口创建Node.
        不用重写getAssetPath().
        -@param parentNode BaseGameNode 父节点
        -@param prefabGameObject GameObject Node预制体()
        -@param param1 any 初始化参数1
        -@param param2 any 初始化参数2
    ]]
    function NodeXXX:create(parentNode, prefabGameObject, param1, param2)
        local node = NodeXXX:new(parentNode, prefabGameObject, param1, param2)
        return node
    end


    function NodeXXX:ctor(parentNode, prefabGameObject, param1, param2)
        BaseUINode.ctor(self)

        -- 在此进行变量初始化
        self._parentNode = parentNode
        self._prefabGameObject = prefabGameObject
        self._a = param1
        self._b = param2

        self:init()
    end


    function NodeXXX:init()
        if self._prefabGameObject == nil then
            return
        end

        self:initEmptyGameObject("node_XXX") -- 绑定pGameObject, pTransform.

        -- 实例化游戏对象
        self._nodeGameObject = UnityEngine.GameObject.Instantiate(self._prefabGameObject)
        self._nodeTransform = self._nodeGameObject.transform
        self._nodeGameObject:SetActive(true)
        self:addChild(nil, self._nodeTransform)

        self:initComponents()
        self:initXXX()
        self:SetXXX()
    end
    ```

### 当创建是的Dialog弹窗时 ###

+ 继承子BaseSubUI, 命名为XXXDialog
  + A: 当Dialog是某个系统私有时框架:
    ```Lua
        --[[
            外部通过对应系统的Control创建Dialog.
            需要重写getAssetPath().
            -@param param1 初始化参数1
            -@param param2 初始化参数2
            -@return nil
        ]]
        function XXXControl:loadAndShow(param1, param1)
            local function onLoadSucc()
                -- 只允许显示1个(根据需要添加)
                --[[ 
                    local inst = XXXControl.getDialogLayer(self):getChildByName(XXXDialog.DialogName)
                    if inst ~= nil then
                        inst:defaultClose()
                    end
                ]]

                local dialog = XXXDialog:new(param1, param1)
                XXXControl.addDialog(self, dialog)
            end

            local function onLoadFail()
                logError(XXXDialog.DialogName + " load failed, path:" + XXXDialog.PrefabPath)
            end

            -- 加载
            XXXDialog:loadRes(onLoadSucc, onLoadFail, true)
        end

        XXXDialog.DialogName = "XXXDialog"

        function XXXDialog:ctor(param1, param2)
            BaseSubUI.ctor(self)

            -- 在此进行变量初始化
            self._a = param1
            self._b = param2
            self:_setName(XXXDialog.DialogName)

            self:init()
        end
    
        function XXXDialog:init()
            self:initEmptyGameObject("dialog_XXX")   -- 绑定pTransform, pGameObject
            self:initPanel(XXXDialog.PrefabPath)    -- 绑定panel
            self:initComponents()
            self:setXXX()
            self:refreshXXX()
        end
    ```
  + B: 当Dialog是公共时框架:
    ```Lua
    --[[
        外部通过该接口创建Dialog.
        需要重写getAssetPath.
        -@param param1 any 初始化参数1
        -@param param2 any 初始化参数2
    ]]
    function XXXDialog:loadAndShow(param1, param2)
        local function onLoadSucc()
            -- 只允许显示1个(根据需要添加)
            --[[
                local inst = ViewManager:getDialogByName(XXXDialog.DialogName)
                if inst ~= nil then
                    inst:defaultClose()
                end
            ]]

            local dialog = XXXDialog:new(param1, param2)
            ViewManager:addDialog(dialog)
        end

        local function onLoadFail()
            logError(XXXDialog.DialogName + " load failed, path:" + XXXDialog.PrefabPath)
        end

        XXXDialog:loadRes(onLoadSucc, onLoadFail, true)
    end

    XXXDialog.DialogName = "XXXDialog"

    function XXXDialog.ctor(param1, param2)
        BaseSubUI.ctor(self)

        -- 在此进行变量初始化
        self._a = param1
        self._b = param2
        self._setName(XXXDialog.DialogName)

        self:init()
    end

    function XXXDialog:init()
        self:initEmptyGameObject("dialog_XXX")   -- 绑定pTransform, pGameObject
        self:initPanel(XXXDialog.PrefabPath)    -- 绑定panel
        self:initComponents()
        self:setXXX()
        self:refreshXXX()
    end
    ```

### 当创建的是Tips提示时 ###

+ 继承自BaseSubUI, 命名为XXXTips
  + 不论哪种情况都使用该框架:
    ```Lua
    --[[
        外部通过该接口创建Tips.
        需要重写getAssetPath()
        -@param param1 any 初始化参数1
    ]]
    function XXXTips:loadAndShow(param1)
        -- 只允许显示1个(根据需要添加)
        local inst = ViewManager:getTipsByName(XXXTips.TipsName)
        if inst ~= nil then
            return
        end

        local function onLoadSucc()
            local tips = XXXTips:new(param1)
            ViewManager:addTips(tips)
        end

        local function onLoadFail()
            logError(XXXTips.TipsName + " load failed, path: " + XXXTips.PrefabPath)
        end

        XXXTips:loadRes(onLoadSucc, onLoadFail, true)
    end

    XXXTips.TipsName = "XXXTips"

    function XXXTips:ctor(param1)
        BaseSubUI:ctor(self)

        -- 进行变量初始化
        self._a = param1
        self:_setName(XXXTips.TipsName)

        self:init()
    end

    function XXXTips:init()
        self:initEmptyGameObject("tips_XXX")   -- 绑定pTransform, pGameObject
        self:initPanel(XXXTips.PrefabPath)      -- 绑定panel
        self:initComponents()
        self:setXXX()
        self:refreshXXX()
    end

    ```

### 当创建的是二级页面UI ###

+ 继承自BaseSubUI
+ 命名 XXXUI
+ 外部接口create(), 常规initPanel(XXXUI.PrefabPath)