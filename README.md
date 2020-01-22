# 介绍
这是我修改自[hexo-theme-matery](https://github.com/blinkfox/hexo-theme-matery)的个性化hexo博客模板，主要修改了一些个性化配置，为了方便大家直接搭建使用。

# 我的博客演示
[https://godweiyang.com](https://godweiyang.com)

# 搭建教程
[https://godweiyang.com/2018/04/13/hexo-blog/](https://godweiyang.com/2018/04/13/hexo-blog/)

# 使用方法
为了减小源码的体积，我将插件目录`node_modules`进行了压缩，大家下载完后需要解压。另外添加水印需要的字体文件我也删除了，大家可以直接从电脑自带的字体库中拷贝。

* 首先运行`git clone git@github.com:godweiyang/hexo-matery-modified.git`将所有文件下载到本地。
* 解压`node_modules.zip`，然后删除`node_modules.zip`和`.git`文件夹。
* 还缺一个字体（为图片添加水印需要用到），去`C:\Windows\Fonts`下找到`STSong Regular`，复制到`hexo-matery-modified`文件夹下。

这样所有准备工作就做好啦，剩下的工作就直接去看我的教程[https://godweiyang.com/2018/04/13/hexo-blog/](https://godweiyang.com/2018/04/13/hexo-blog/)



# 我的记录

然后输入`hexo new post "article title"`，新建一篇文章 `hexo g`生成静态网页，然后输入`hexo s`可以本地预览效果，最后输入`hexo d`上传到github上 



## 备份博客源文件

有时候我们想换一台电脑继续写博客，这时候就可以将博客目录下的所有源文件都上传到github上面。

首先在github博客仓库下新建一个分支`hexo`，然后`git clone`到本地，把`.git`文件夹拿出来，放在博客根目录下。

然后`git checkout hexo`切换到`hexo`分支，然后`git add .`，然后`git commit -m "xxx"`，最后`git push origin hexo`提交就行了。



## 文章头设置

首先为了新建文章方便，建议将`/scaffolds/post.md`修改为如下代码：

```
---
title: {{ title }}
date: {{ date }}
top: false
cover: false
password:
toc: true
mathjax: true
summary:
tags:
categories:
---
```
## 修改首页音乐

E:\ThirtyZhang.github.io\source\_data\musics.json

E:\ThirtyZhang.github.io\themes\matery\source\medias\music