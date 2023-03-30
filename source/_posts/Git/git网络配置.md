---
title: "Git网络代理配置"
date: 2023-01-30 09:57:08
tags: ["Git", "网络代理", "Github"]
categories: ["Git"]
---

# Git网络配置语句 #

```CMD
# 查看全部配置
git config --global -l

# 查看全局代理
git config --global http.proxy
git config --global https.proxy 

# 设置全局代理
git config --global http.proxy "http://127.0.0.1:端口号"
git config --global https.proxy "https://127.0.0.1:端口号"

# 取消全局代理
git config --global --unset http.proxy
git config --global --unset https.proxy
```

---

# 解决使用Git，对在Github上的仓库Push或Clone网络错误的问题 #

```CMD
# 对Github单独设置代理
git config --global http.https://github.com.proxy socks5://127.0.0.1:端口号
git config --global https.http://github.com.proxy socks5://127.0.0.1:端口号

# 取消代理
git config --global --unset http.https://github.com.proxy 
git config --global --unset https.http://github.com.proxy 
```

由于需要反复设置对Github的代理，所以可以创建.bat程序减少重复命令输入 。  
1. 创建.bat文件,使用UTF-8编码保存。
2. 复制以下命令，并在更改自己的端口号
    ```CMD
    @ echo off
    :start
    echo 输入A显示全部配置
    echo 输入B设置git对Github代理
    echo 输入C取消git对Github代理
    echo 输入D退出
    CHOICE /C ABC
    if errorlevel 4 goto exit
    if errorlevel 3 goto unsetConfig
    if errorlevel 2 goto setConfig
    if errorlevel 1 goto showConfig

    :showConfig
    git config --global -l
    goto start

    :setConfig
    :: 在两条git语句末尾 填入自己的代理端口号
    git config --global http.https://github.com.proxy socks5://127.0.0.1:端口号
    git config --global https.http://github.com.proxy socks5://127.0.0.1:端口号
    goto start

    :unsetConfig
    git config --global --unset http.https://github.com.proxy 
    git config --global --unset https.http://github.com.proxy 
    goto start

    :exit
    Pause
    ```
3. 运行.bat文件，根据提示输入。