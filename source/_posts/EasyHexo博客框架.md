---
title: EasyHexo博客框架
top: false
cover: true
toc: true
mathjax: true
date: 2020-01-21 16:58:04
password:
summary: Hexo 是一个快速、简洁且高效的博客框架
tags: 
- 框架
categories:
- 效率
---



<div  align = "center"><iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="//music.163.com/outchain/player?type=2&id=864622002&auto=1&height=66"></iframe></div>

# 安装与配置

## 认识 Hexo

> Hexo 是一个快速、简洁且高效的博客框架，可以让你快速建立一个博客。

> Hexo 使用 Node.js 编写。得益于 Node.js，使得 Hexo 生成上百个页面游刃有余。

> Hexo 支持 GFM (GitHub Flavored Markdown) 的大部分功能。如果你不喜欢 Markdown ，你还可以换一个 Hexo 渲染插件。

> Hexo 有许多插件，可以进行各种操作。

## 学习 Hexo 之前，你需要有：

- Node.js 基本知识
- Git 基本知识
- Markdown 基本知识
- Html、css、JavaScript 基本知识
- ······

当然了，你可别被吓跑了。除了 Markdown ，其他都不用熟练掌握（事实上如果你不注意排版连 Markdown 都不用掌握，但最好还是学学吧 : **[Markdown语法 ](https://thirtyzhang.github.io/2020/01/21/markdown-yu-fa/)**）。如果你完全不会以上划线部分的知识，也没关系。只是简单地建个可以发文章的博客就好了。如果你要更上一层楼，那么以上被划掉的知识就是必备的啦~

## 安装 Hexo

在安装 Hexo 之前，你需要安装以下两个工具：

- **[Git](https://git-scm.com/)**
- **[Node.js](https://nodejs.org/)**

## 安装 Git

- Windows：下载并安装 [git](https://git-scm.com/download/win).
- Mac：使用 [Homebrew](http://mxcl.github.com/homebrew/), [MacPorts](http://www.macports.org/) ：`brew install git`;或下载 [安装程序](http://sourceforge.net/projects/git-osx-installer/) 安装。
- Linux (Ubuntu, Debian)：`sudo apt-get install git-core`
- Linux (Fedora, Red Hat, CentOS)：`sudo yum install git-core`
- Linux (Arch 系列)：`sudo pacman -S git`

提醒

由于墙的原因，从上面的链接下载 git for windows 最好挂上一个代理，否则下载速度十分缓慢。也可以参考[这个页面](https://github.com/waylau/git-for-win)，收录了存储于百度云的下载地址。

提醒

如果你是 CentOS 服务器上的，可以直接使用 [HexoOneClickInstallation](https://github.com/PasserByJia/HexoOneClickInstallation) 这个脚本快速安装 Hexo。

## 安装 Node.js

安装 Node.js 的最佳方式是使用 [nvm](https://github.com/creationix/nvm)。

cURL:

```powershell
$ curl https://raw.github.com/creationix/nvm/v0.33.11/install.sh | sh
```

Wget:

```powershell
$ wget -qO- https://raw.github.com/creationix/nvm/v0.33.11/install.sh | sh
```

安装完成后，重启终端并执行下列命令即可安装 Node.js。

```powershell
$ nvm install stable
```

或者您也可以下载 [安装程序](http://nodejs.org/) 来安装。

## 安装 Hexo

安装好后，即可使用 npm 完成 Hexo 的安装。

```powershell
# 下面这两个命令好像是一样的效果,任选一个就可以了
$ npm install -g hexo-cli
$ npm install hexo-cli -g
```
## 建立网站

安装好 Hexo 后即可建立你的网站。

首先建立一个文件夹。

```powershell
mkdir <your_blog_name>  # 建立你的网站根目录，名字可以自己修改
```

然后往这个文件夹里安装 Hexo。

```powershell
hexo init <your_blog_name>
```

再执行

```powershell
hexo s
```

浏览器输入

```powershell
http://localhost:4000/
```

就可以本地访问了

这样就建立好网站了！

[easyhexo](https://easyhexo.com/1-Hexo-install-and-config/1-3-config-hexo.html#%E9%85%8D%E7%BD%AE-hexo-2)



# 主题链接

[自己克隆的](https://github.com/ThirtyZhang/hexo-theme-matery)

[原版的](https://github.com/blinkfox/hexo-theme-matery )

下载后将 `hexo-theme-matery` 的文件夹复制到你 Hexo 的 `themes` 文件夹中即可

# 收藏博客

[闪烁之狐](https://blinkfox.github.io/)

[韦阳的博客](https://godweiyang.com/)

# 备份博客源文件

有时候我们想换一台电脑继续写博客，这时候就可以将博客目录下的所有源文件都上传到github上面。

首先在github博客仓库下新建一个分支`hexo`，然后`git clone`到本地，把`.git`文件夹拿出来，放在博客根目录下。

然后`git checkout hexo`切换到`hexo`分支，然后`git add .`，然后

，最后`git push origin hexo`提交就行了。

来源: 韦阳的博客

作者: 韦阳

链接: 

https://godweiyang.com/2018/04/13/hexo-blog/#toc-heading-12

<https://godweiyang.com/2018/04/13/hexo-blog/#toc-heading-10> 