---
title: RO上手流程梳理(2)
date: 2023-02-01 17:42:45
tags:
- RO
categories: "RO"
password: xjcs
abstract: 不要看不要看!
message: RO的中文拼音缩写
wrong_pass_message: 别看！
wrong_hash_message: 抱歉, 这个文章不能被校验, 不过您还是能看看解密后的内容.
---

---

# RO中的Lua面向对象 #
目录位置 ``src\basePackage\core\luaCore.lua``

## _baseClass ##
```Lua
local _baseClass = {}
_bassClass.__index = _baseClass

function _bassClass:new(...)
    local t = {}
    setmetatable(t, self)

    -- 构造函数会在class定义的时候就执行
    if t.ctor then
        t:ctor(...)
    end

    return t
end

-- 跟 new(...) 完全相同
function _baseClass:create(...) 
    ...
end
```

## class(...) ##
```Lua
-- 定义一个class, 参数表示基类
function class(...)
    local t = {}    -- 用于返回这个 class
    t.__index = t
    local supers = {...}    -- 将 ... 参数构造成索引从1开始的表, 表示基类数组

    -- 将 ...表示的基类, 放进 t.__supers表里
    -- 并将 ...里第一个类作为 t的基类
    for _, super in ipairs(supers) do
        t.__supers = t.__supers or {} -- 如果t.__supers是 nil, 则让他为 {}, 否则不变
        t.__supers[#t.__supers + 1] = super -- 将基类添加到 __supers里

        -- 将 ...中第一个类作为 t的基类
        if not t.super then
            t.super = super
        end
    end

    -- 第一个条件: 如果 ...没有东西
    -- 第二个条件: 无法理解为什么还要判断
    -- 总得来说就是这个 class 没有基类的话
    if not t.__supers or #t.__supers == 0 then
        setmetatable(t, _baseClass)
    else
    -- 这个 class 有基类的话
    -- 这里元表的__index的元方法是，从第一个基类开始，遍历所有基类去看有无这个key
        setmetatable(t,{
            __index = function(_, key)
                local supers = t.__supers   -- 拿出t的全部基类
                for i = 1, #supers do
                    local super = supers[i]
                    if super[key] then
                        return super[key]
                    end
                end
            end
        })

        -- 是否t以及t的基类是否有new()函数，没有则定义一个，同_bassClass中的new()一样
        if t.new == nil then
            t.new = function(myself, ...)
                local ins = {}
                setmetatable(ins, t)
                if ins.ctor then
                    ins:ctor(...)
                end
                return ins
            end
        end
    end
    return t
end
```
class(...)中的t的结构    
t.__index = 自己  
t.__supers = {表示全部的基类}   
{__index = 从基类中拿一个 }当有继承时的元表