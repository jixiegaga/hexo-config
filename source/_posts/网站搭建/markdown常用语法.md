---
title: "Markdown常用语法"
date: 2023-01-29 15:07:22
tags: ["Markdown"]
categories: ["博客搭建"]
---

---

# 标题 #

语法如下:
```Markdown
# 一级 #

## 二级 ##

### 三级 ###

#### 四级 ####

##### 五级 #####

###### 六级 ######
```

效果如下:
# 一级 #

## 二级 ##

### 三级 ###

#### 四级 ####

##### 五级 #####

###### 六级 ######

---

# 注释 #

语法如下:
```Markdown
<!-- 看不到看不到 -->
```

效果如下:
<!-- 看不到看不到 -->

---

# 分割线 #

语法如下:
``` Markdown
---
```

效果如下:
___

---

# 换行 #

语法如下:
``` Markdown
输入三个空格，一个回车
Hello   
World   

或者

输入<br />
Hello<br />World
```

效果如下:   
Hello   
World   
Hello<br />World

---

# 代码和代码块 #

语法如下:
```Markdown
``int a = 1;``

或者

```C++
int b = 2;
```             。(这个句号不用写)

```

效果如下:   
``int a = 1;``   
```C++
int b = 2;
```

---

# 超链接 #

语法如下:
```Markdown
双引号中的内容为鼠标悬停时显示的描述
[个人网站](https://wokaibai.top "我的个人网站")

或者

<https://wokaibai.top>
```

效果如下:   
[个人网站](https://wokaibai.top "我的个人网站")   
<https://wokaibai.top>

---

# 引用形式的超链接 #

语法如下:
```Markdown
[个人网站][个人网站索引]   
[个人网站][1]

[个人网站索引]: https://wokaibai.top
[1]: https://wokaibai.top
```

效果如下:   
[个人网站][个人网站索引]   
[个人网站][1]

[个人网站索引]: https://wokaibai.top
[1]: https://wokaibai.top

---

# 数学公式 #

语法如下:
```Markdown
使用LaTeX公式
$$\frac{a}{b}$$ 表示块公式
$\frac{a}{b}$   表示行公式
```

效果如下:   
(显示异常就是不支持)   
$$\frac{a}{b}$$   
$\frac{a}{b}$   

注意事项：LaTeX公式需要解析工具的支持。LaTeX公式可以通过以下在线网站获取   
[数学公式->LaTeX表达式或图片](https://www.2weima.com/gongshi.html)   
[图片->LaTeX表达式(需要登录)](https://www.latexlive.com)

---

# 列表 #

语法如下:
```Markdown
+ 无序列表1
+ 无序列表2
+ 无序列表3
1. 有序列表1
2. 有序列表2
   1. 子列表
   2. 子列表
3. 有序列表3
```

效果如下:   
+ 无序列表1
+ 无序列表2
+ 无序列表3
1. 有序列表1
2. 有序列表2
   1. 子列表
   2. 子列表
3. 有序列表3

---

# 块引用 #

语法如下:
```Markdown
> 第一行   
> 第二行
>
> 第三行
>> 嵌套块引用
```

效果如下:   
> 第一行   
> 第二行
>
> 第三行
>> 嵌套块引用

---

# 斜体、粗体、粗斜体、删除线 #

语法如下:
```Markdown
*斜体*   
**粗体**   
***粗斜体***   
~~删除线~~
```

效果如下:   
*斜体*   
**粗体**   
***粗斜体***   
~~删除线~~

---

# 图片 #

语法如下:
```Markdown
通过上传至仓库加载(需要梯子)
![刻晴，图裂了就是没挂梯子](https://raw.githubusercontent.com/jixiegaga/jixiegaga.github.io/master/images/keqing1.webp "刻晴")

图床加载
![背景图片](https://s2.loli.net/2023/01/19/Jj2HgaZkGq5nAI3.jpg)

html标签图床加载
<img src="https://s2.loli.net/2023/01/19/Jj2HgaZkGq5nAI3.jpg" width=300 height=120 />
```

效果如下:
![刻晴，图裂了就是没挂梯子](https://raw.githubusercontent.com/jixiegaga/jixiegaga.github.io/master/images/keqing1.webp "刻晴")
![背景图片](https://s2.loli.net/2023/01/19/Jj2HgaZkGq5nAI3.jpg)
<img src="https://s2.loli.net/2023/01/19/Jj2HgaZkGq5nAI3.jpg" width=300 height=120 />

---

# 表格 #

语法如下:
```Markdown
|左对齐  |居中    |右对齐  |
|:---    |---     |---:   |
|单元格  |单元格  |单元格  |
|单元格  |单元格  |单元格  |

:--- 表示左对齐
---  表示居中
---: 表示右对齐
```

效果如下:   
|左对齐  |居中    |右对齐  |
|:---    |---     |---:   |
|单元格  |单元格  |单元格  |
|单元格  |单元格  |单元格  |


---

其他Markdown语法的参考:   
<http://www.zhaowenyu.com/markdown-doc/> 语法较全，质量较高   
<https://butterfly.js.org/posts/89757140/> Butterfly主题官方出品


---
