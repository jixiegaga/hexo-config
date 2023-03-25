---
title: "git网络代理配置"
date: 2023-01-30 09:57:08
tags: ["git", "网络代理", "GitHub"]
categories: ["git"]
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

# 解决在Github上的仓库Push或Clone网络错误的问题 #

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
    set portValue=7890

    :start
    echo 请输入数字
    echo 1.显示git全部配置
    echo 2.设置git对Github代理
    echo 3.取消git对Github代理
    echo 4.设置代理服务器端口号(默认%portValue%)
    echo 5.查看代理服务器端口号
    echo 6.退出
    CHOICE /C 123456 /N
    if errorlevel 6 goto exit
    if errorlevel 5 goto showProxyPort
    if errorlevel 4 goto setProxyPort
    if errorlevel 3 goto unsetProxy
    if errorlevel 2 goto setProxy
    if errorlevel 1 goto showProxy

    :showProxy
    git config --global -l
    goto start

    :setProxy
    :: 在两条git语句末尾 填入自己的代理端口号
    git config --global http.https://github.com.proxy socks5://127.0.0.1:%portValue%
    git config --global https.http://github.com.proxy socks5://127.0.0.1:%portValue%
    goto start

    :unsetProxy
    git config --global --unset http.https://github.com.proxy 
    git config --global --unset https.http://github.com.proxy 
    goto start

    :setProxyPort
    set /p portValue=请输入端口号:
    goto start

    :showProxyPort
    echo %portValue%
    goto start

    :exit
    Pause
    ```
3. 运行.bat文件，根据提示输入。   

---   

# 解决在Github上的用户验证问题 #   
1. 进入Github中生成生成token令牌，``Setting-> Developer settings-> Personal access tokens-> Tokens(classic)-> Generate new token-> Generate new token(classic)``
2. 保存该token令牌，不保存就找不到了!!
3. 在仓库地址上添加该令牌的值和一个@符号，``https://在这里添加令牌@github.com/jixiegaga/jixiegaga.github.io.git``   

> 第二种使用SSH的方式，参考<https://blog.csdn.net/qq_45491549/article/details/128825216>   

---