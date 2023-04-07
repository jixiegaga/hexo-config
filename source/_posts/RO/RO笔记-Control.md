---
title: RO笔记-Control
date: 2023-04-06 19:20:24
tags:
- RO
categories: "RO"
---

# BaseViewControl #

## 字段 ##

```Lua
self.id             ---@type ViewManager.view_xxx 枚举
self.uiLayer        ---@type ViewManager.UI_LAYER_XXX 枚举
self.uiClass        ---@type BaseUI | BaseSubUI | nil 类
self.sceneClass     ---@type any 类
self.pUI            ---@type BaseUI | BaseSubUI | nil 对象
self.pScene         ---@type any 对象
self.pDialogLayer   ---@type any 对象
self._assetPath     ---@type table | string | nil 加载时首先加载的资源路径
self._subAssetPath  ---@type table | string | nil 加载完assetPath后加载的路径
```

---

## 初始化 ##

```Lua
--[[
    -@param id ViewManager.view_xxx 在ViewManager定义的id
    -@param uiClass BaseUI | BaseSubUI | nil 界面对应的主UI的类(不是对象)
    -@param sceneClass any | nil
    -@param uiLayer ViewManager.UI_LAYER_XXX | nil 在ViewManager定义的id

    -@desc 保存id, uiLayer, uiClass, sceneClass.
            根据id注册control, ViewManager.viewControlTab[id] = self .
            根据uiLayer注册id到不同的字典, ViewManager.viewXxxControlTab[id] = true . 

    !! uiLayer只能为 UI_LAYER_BACK | UI_LAYER_UI01 | UI_LAYER_UI02, nil时为UI_LAYER_BACK.
    !! 1个control只对应1个id, 并且只存在在一个uiLayer. 
]]
BaseViewControl:init(id, uiClass, sceneClass, uiLayer)
```

---

# 资源加载 #

```Lua
--[[
    -@desc 返回基础资源路径, 对应self._assetPath的路径, 但不会为它赋值.
    -@return table | string | nil

    !! 路径为 "res/view/prefab/xxx/xxxUI.prefab" .
]]
BaseViewControl:getAssetPath()


--[[
    -@desc 返回次级资源路径, 对应self._subAssetPath的路径, 但不会为它赋值.
    -@return table | string | nil

    !! 路径为 "res/view/prefab/xxx/xxxUI.prefab" .
]]
BaseViewControl:getSubAssetPath()


--[[
    -@param sucCb fun():nil     加载成功回调
    -@param failCb fun():nil    加载失败回调
    -@param processCB fun():nil 加载进度回调

    -@desc 赋值self._assetPath = self:getAssetPath().
            然后调用self:loadAndCall(self_assetPath, ... )进行异步加载.          
]]
BaseViewControl:loadRes(sucCb, failCb, processCB)


--[[
    -@param assets table | string | nil 资源加载的路径
    -@param scb fun():nil       加载成功回调
    -@param fcb fun():nil       加载失败回调
    -@param processCB fun():nil 加载进度回调

    -@desc 通过DownLoadMission异步加载assets路径

    !! 注意当assets为nil时, 会直接调用scb表示成功加载资源.
]]
BaseViewControl:loadAndCall(assets, scb, fcb, processCB)
```

---

# 显示 #

```Lua
--[[
    -@param sucCb fun():nil
    -@param failCb fun():nil
    -@param processCB fun():nil

    -@desc 1. 通过self:loadRes()异步加载self:getAssetPath()中的资源.
            2. 通过

]]
BaseViewControl:openView(sucCb, failCb, processCB)
```