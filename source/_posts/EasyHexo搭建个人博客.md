---
title: EasyHexo搭建个人博客
top: true
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

# 安装

## 添加国内镜像源

如果没有梯子的话，可以使用阿里的国内镜像进行加速,不使用的话可能会有下载过慢或下载失败的问题

```powershell
$ npm config set registry https://registry.npm.taobao.org
```

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
输入`npm install`安装必备的组件 

# 配置

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

**网站建立好后还需要做一些个性化配置,如:修改网站默认内容改为自己的内容**

此部分内容可能过期，请见 [Hexo 官方文档](https://hexo.io/zh-cn/docs/configuration)。

在 Hexo 根目录 `_config.yml` 这个文件里配置！

警告

在 YAML 语法中，冒号后面必须要有一个空格才能继续写下去。

### 网站

```
# Site
title:            
subtitle: 
description: 
keywords:
author: 
language: 
timezone: 
```

| 参数          | 描述                                                         |
| ------------- | ------------------------------------------------------------ |
| `title`       | 网站标题                                                     |
| `subtitle`    | 网站副标题                                                   |
| `description` | 网站描述                                                     |
| `keywords`    | 网站关键词                                                   |
| `author`      | 作者名字                                                     |
| `language`    | 网站使用的语言                                               |
| `timezone`    | 网站时区：详见[时区列表](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) |

### URL

```
# URL
## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
url: 
root: 
permalink: :year/:month/:day/:title/
permalink_defaults:
pretty_urls:
  trailiing_index: true
```

| 参数                         | 描述                                                    |
| ---------------------------- | ------------------------------------------------------- |
| `url`                        | 网址                                                    |
| `root`                       | 网站根目录                                              |
| `permalink`                  | 文章的永久链接格式                                      |
| `permalink_defaults`         | 永久链接中各部分的默认值                                |
| `pretty_urls`                | 改写 `permalink` 的值来美化 URL                         |
| `pretty_urls.trailing_index` | 是否在永久链接中保留尾部的 `index.html`，`false` 时去除 |

提醒

如果你的网站在子目录中，如：`https://yoursite.com/blog` ，就把你的 `url` 设为 `http://yoursite.com/blog` 并把 `root` 设为 `/blog/`。

例如：

```
# 比如，一个页面的永久链接是 http://example.com/foo/bar/index.html
pretty_urls:
  trailing_index: false
# 此时页面的永久链接会变为 http://example.com/foo/bar/
```

### 目录

```
# Directory
source_dir: source
public_dir: public
tag_dir: tags
archive_dir: archives
category_dir: categories
code_dir: downloads/code
i18n_dir: :lang
skip_render: README.md
```

| 参数           | 描述                                                         |
| -------------- | ------------------------------------------------------------ |
| `source_dir`   | 资源文件夹                                                   |
| `public_dir`   | 公共文件夹                                                   |
| `tag_dir`      | 标签文件夹                                                   |
| `archive_dir`  | 归档文件夹                                                   |
| `category_dir` | 分类文件夹                                                   |
| `code_dir`     | Include code 文件夹                                          |
| `i18n_dir`     | 国际化文件夹                                                 |
| `skip_render`  | 跳过文件的渲染。匹配到的文件将直接复制到 `public` 目录中。您可使用 [glob](https://github.com/micromatch/micromatch#extended-globbing) 表达式来匹配路径。 |

提醒

一般情况下，这部分是不需要修改的。

例如：

```
skip_render: "mypage/**/*"
# 将会直接将 `source/mypage/index.html` 和 `source/mypage/code.js` 不做改动地输出到 'public' 目录
# 你也可以用这种方法来跳过对指定文章文件的渲染
skip_render: "_posts/test-post.md"
# 这将会忽略对 'test-post.md' 的渲染
```

### 文章

```
# Writing
new_post_name: :title.md # File name of new posts
default_layout: post
auto_spacing: false
titlecase: false # Transform title into titlecase
external_link: true # Open external links in new tab
  enable: true
  field: site
  exclude: []
filename_case: 0
render_drafts: false
post_asset_folder: true
relative_link: false
future: true
highlight:
  enable: true
  line_number: true
  auto_detect: false
  tab_replace:
```

| 参数                    | 描述                                                         |
| ----------------------- | ------------------------------------------------------------ |
| `new_post_name`         | 新文章的文件名称                                             |
| `default_layout`        | 预设布局                                                     |
| `auto_spacing`          | 在中文和英文之间加入空格                                     |
| `titlecase`             | 把标题转换为 title case                                      |
| `external_link`         | 在新标签中打开链接                                           |
| `external_link.enable`  | 在新标签中打开链接                                           |
| `external_link.field`   | 适用于整个网站或仅文章                                       |
| `external_link.exclude` | 排除主机名。在适用时指定子域，包括 `www`                     |
| `filename_case`         | 把文件名称转换为 (1) 小写或 (2) 大写                         |
| `render_drafts`         | 显示草稿                                                     |
| `post_asset_folder`     | 启动 [Asset 文件夹](https://hexo.io/zh-cn/docs/asset-folders) |
| `relative_link`         | 把链接改为与根目录的相对位址                                 |
| `future`                | 显示未来的文章                                               |
| `highlight`             | 代码块的设置                                                 |
| `highlight.enable`      | 开启语法高亮                                                 |
| `highlight.auto_detect` | 如果未指定语言，则启用自动检测                               |
| `highlight.line_number` | 显示行数                                                     |
| `highlight.tab_replace` | 用 n 个空格替换 tabs；如果值为空，则不会替换 tabs            |

### 分类 & 标签

```
# Category & Tag
default_category: uncategorized
category_map:
tag_map:
```

| 参数               | 描述     |
| ------------------ | -------- |
| `default_category` | 默认分类 |
| `category_map`     | 分类别名 |
| `tag_map`          | 标签别名 |

### 日期 / 时间格式

```
# Date / Time format
## Hexo uses Moment.js to parse and display date
## You can customize the date format as defined in
## http://momentjs.com/docs/#/displaying/format/
date_format: YYYY-MM-DD
time_format: HH:mm:ss
use_date_for_updated: true
```

| 参数                   | 描述                                                         |
| ---------------------- | ------------------------------------------------------------ |
| `date_format`          | 日期格式                                                     |
| `time_format`          | 时间格式                                                     |
| `use_date_for_updated` | 如果前面没有提供更新日期，则使用 `post.updated` 中的发布日期。通常与 Git 工作流一起使用。 |

提醒

Hexo 使用 [Moment.js](http://momentjs.com/) 来解析和显示时间。

## 分页

```
# Pagination
## Set per_page to 0 to disable pagination
per_page: 10
pagination_dir: page
```

| 参数             | 描述                                |
| ---------------- | ----------------------------------- |
| `per_page`       | 每页显示的文章量 (0 = 关闭分页功能) |
| `pagination_dir` | 分页目录                            |

## 扩展

```
# Extensions
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
theme: 
theme_config: 
deploy:
meta_generator:
```

| 参数             | 描述                                                         |
| ---------------- | ------------------------------------------------------------ |
| `theme`          | 当前主题名称。值为 `false` 时禁用主题                        |
| `theme_config`   | 主题的配置文件。在这里放置的配置会覆盖主题目录下的 `_config.yml` 中的配置。 |
| `deploy`         | 部署的设置                                                   |
| `meta_generator` | [Meta generator](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/meta#%E5%B1%9E%E6%80%A7) 标签。 值为 `false` 时 Hexo 不会在头部插入该标签。 |

提醒

下一篇文章将会提到 部署。



# Hexo 命令详解

下面介绍一些 Hexo 的基本命令。

### `hexo init [folder]`

这个命令是 Hexo 初始化命令。`[folder]` 表示你要初始化的文件夹。如果你要初始化本地，直接 `hexo init .` 。

### `hexo new [layout] <title>`

这个命令是新建文章或页面用的命令。其中 `[layout]` 表示他的模板（即页面或者文章），`<title>` 表示标题。

用法：

1. `hexo new post 001` ，表示新建了一个标题为 `001` 的文章。
2. `hexo new page 001` ，表示新建了一个标题为 `001` 的页面。

如果你不想在终端中新建文章或页面，可以直接在 `博客根目录/source/_post/` 目录下创建 Markdown 文件写**文章**。或者在 `博客根目录/source/` 目录下创建一个文件夹，然后在新文件夹里创建 `index.md` 写**页面**即可。

提醒

当你新建页面后，页面的链接就是你页面所在的文件夹的名字。

例如：我在 `博客根目录/source/` 下新建了一个名为 `test` 的文件夹，然后在 `test` 文件夹下写 Markdown 文件，那么这个页面的链接就是 `网址/test`。

### `hexo server`

当你要在本地查看网站的时候，就可以用这个命令。

默认在 `http://localhost:8080/` 这里，可能会不同，注意提示信息即可。

提醒

如果你想要换端口号（上面的 `8080` 就是端口号），可以在终端里输入 `hexo s -p 端口号`。

### `hexo generate`

这个命令是生成网站静态文件的时候用的，生成后网页将会放在根目录下面的 `public` 文件夹里。

### `hexo deploy`

这个命令用来部署网站，使用此命令将会把生成好的页面（即 `public` 文件夹里的内容）部署到指定的地方上。

### `hexo clean`

这个命令用来清空 `public` 文件夹。

### `hexo version`

这个命令用来输出你所使用的 Hexo 目前的版本号

# 部署到 GitHub

### 准备工作

1. 如果没有账号，请点此前往 [GitHub](https://github.com/) 注册一个 GitHub 账号。
2. 新建一个公开仓库，仓库名格式为 `your_username.github.io` 例如你的 GitHub 用户名是 `easyhexo`，那么你的仓库地址名称就应该是 `easyhexo.github.io`
3. 创建完成后记下该仓库的 HTTPS/SSH 地址 一般格式为 `https://github.com/your_username/your_reponame.git` 在下一步会用到。

### 安装[部署插件](https://github.com/hexojs/hexo-deployer-git)

```
$ npm install hexo-deployer-git --save
$ npm install hexo-server --save
```

### 配置 Git

如果你只是安装好了 Git 但没有配置过你的 Git ，那么现在需要做的第一件事情就是设置你的 Git 用户名和邮箱。 在 Git Bash 中执行以下两条命令配置你的用户名和邮箱，这里建议用户名和邮箱与你的 GitHub 用户名和邮箱保持一致。

```
$ git config --global user.name "Your_user_name"
$ git config --global user.email "Your_email@example.com"
```

提醒

每次 Git 提交时都会附带这两条信息，用于记录是谁提交的更新，并且会随更新内容一起被记录到历史记录中。简单说，是用来标记的你的身份的~

用户名和邮箱根据你注册github的信息自行修改。

### 然后生成密钥SSH key：

```
ssh-keygen -t rsa -C "Your_email@example.com"
```

打开[github](https://github.com/)，在头像下面点击`settings`，再点击`SSH and GPG keys`，新建一个SSH，名字随便。

git bash中输入

```
cat ~/.ssh/id_rsa.pub
```

将输出的内容复制到框中，点击确定保存。

输入`ssh -T git@github.com`，出现你的用户名，那就成功了。



### 配置站点 `_config.yml` 文件

```
deploy:
  type: git   # 类型填git
  repo: <repository url> # 你的Github仓库地址
  branch: master  # 分支名称。默认填写 master 如果您使用的是 GitHub ，程序会尝试自动检测。
  message:  # 提交信息可以自定义，不填的则默认为提交时间
```

```
deploy:
  type: git
  repository: git@github.com:ThirtyZhang/ThirtyZhang.github.io.git
  branch: master
```

repository修改为你自己的github项目地址。**(最好使用SSH的地址,因为使用Http更换电脑后可能找不到该git地址)**

### 发布到 GitHub

在本地的 Hexo 站点根目录下，执行如下命令即可部署到 GitHub Pages 上。

```
$ hexo clean && hexo d -g
```

# 写文章、发布文章

首先在博客根目录下右键打开git bash

输入`hexo new post "article title"`，新建一篇文章。

然后打开`博客根目录\source\_posts`的目录，可以发现下面多了一个文件夹和一个`.md`文件，一个用来存放你的图片等数据，另一个就是你的文章文件啦。

编写完markdown文件后，根目录下输入`hexo g`生成静态网页，然后输入`hexo s`可以本地预览效果，最后输入`hexo d`上传到github上。这时打开你的github.io主页就能看到发布的文章啦

## 创建文章命令详细介绍

> `hexo new [layout]`
>
> 这个命令是新建文章或页面用的命令。其中 `[layout]` 表示他的模板（即页面或者文章），`<title>` 表示标题。
>
> 用法：
>
> 1. `hexo new post 001` ，表示新建了一个标题为 `001` 的文章。
> 2. `hexo new page 001` ，表示新建了一个标题为 `001` 的页面。
>
> 如果你不想在终端中新建文章或页面，可以直接在 `博客根目录/source/_post/` 目录下创建 Markdown 文件写**文章**。或者在 `博客根目录/source/` 目录下创建一个文件夹，然后在新文件夹里创建 `index.md` 写**页面**即可。
>
> 提醒
>
> 当你新建页面后，页面的链接就是你页面所在的文件夹的名字。
>
> 例如：我在 `博客根目录/source/` 下新建了一个名为 `test` 的文件夹，然后在 `test` 文件夹下写 Markdown 文件，那么这个页面的链接就是 `网址/test`。



# 推荐使用的主题链接

推荐一个好用的主题地址

[自己克隆的](https://github.com/ThirtyZhang/hexo-theme-matery)

[原版的](https://github.com/blinkfox/hexo-theme-matery )

下载后将 `hexo-theme-matery` 的文件夹复制到你 Hexo 的 `themes` 文件夹中即可

然后参照其中的`DEADME-CN.md`文件进行配置

# 最后我搭建好的成品效果图

我个人的博客地址 : [点击访问](https://thirtyzhang.github.io/)

![MyBlog](1579682303863.png)

# 收藏博客

**[milyyy](https://milyyy.github.io/)**

[闪烁之狐](https://blinkfox.github.io/)

[韦阳的博客](https://godweiyang.com/)

# 备份博客源文件

有时候我们想换一台电脑继续写博客，这时候就可以将博客目录下的所有源文件都上传到github上面。

首先在github博客仓库下新建一个分支`hexo`，然后`git clone`到本地，把`.git`文件夹拿出来，放在博客根目录下。

然后`git checkout hexo`切换到`hexo`分支，然后`git add .`，然后

，最后`git push origin hexo`提交就行了。

# 推荐另一个教程作参考

## Hexo+Github博客搭建 完整小白教程

<https://godweiyang.com/2018/04/13/hexo-blog/#toc-heading-10> 



**更多细节可查看官方文档** : [hexo](https://hexo.io/zh-cn/docs/configuration)



# 遇到的问题解决办法

## 端口占用

- 提示“FATAL Port 4000 has been used. Try other port instead.”
   在使用了$ hexo s命令预览博客效果后使用Control+C关闭
   解决办法：

还不行就重新手动制定端口号

```
$ hexo s -p 5000
```

##   未安装git部署插件

- 提示“ERROR Deployer not found: git”
  解决办法：

```
$ npm install hexo-deployer-git --save
```

 

##  每次hexo d 提交到GitHub 都会发送警告邮件

总结写在前面,如果你没有绑定域名,而是克隆的别人的文件,直接删除掉就可以了

路径 : `博客根目录/source`

![CNAME](1579706750493.png)

Page build warning：Cannot use CNAMEs ending with github.io or github.com

​       在设计自己blog的时候，大家都会先借鉴一下[jkell模板](http://jekyllthemes.org/)吧。我的这个blog也先clone了别人的架构，接下来慢慢修改填充自己的想法。

​       在我每次向github的远程仓库提交更新的时候，总会收到一封邮件：

>  The page build completed successfully, but returned the following warning for the `master` branch:You cannot use CNAMEs ending with github.io or github.com. Instead, create a repository named ThirtyZhang.github.io. See https://help.github.com/articles/setting-up-your-pages-site-repository/
>
>  For information on troubleshooting Jekyll see:
>
>  https://help.github.com/articles/troubleshooting-jekyll-builds
>
>  If you have any questions you can contact us by replying to this email.

大概就是表示您不能使用以`github.io` 或者 `github.com` 结尾的CNAMEs文件 ,创建一个名为ThirtyZhang.github.io的存储库代替

刚接触[jekyll](http://jekyll.bootcss.com/)不久，对它的构建结构和语法都不是特别熟悉。访问了邮件中的链接，我发现这并不能解决我的问题。虽然有warning但是无伤大雅，毕竟程序员不怎么care warning。But 每次更新代码，都要收到github的邮件，我是不能忍受的！！！(*>﹏<*)

​       于是乎好好研究了下jekyll的目录结构以及CNAME，原来CNAME是用来绑定域名的。

## 绑定到一级域名

1. 首先在项目根目录下创建一个叫CNAME文件，里面写上自己的以及一级域名(www.youdomain.com)
2. 在你的域名管理页或者是DNS解析的地方，增加一个记录，记录类别为CNAME(Alias)类型。i.e.在DNS中为自己的域名增加一条A记录，指向207.97.227.245（github服务器）。
3. 将项目提交到github上, wait a minute
4. baseurl应该为”/”
5. 访问自己的域名,check一下

## 绑定到二级域名

​       需要额外在DNS中增加一条CNAME，指向(github用户名).github.io，然后再CNAME文件中修改为自己的二级域名即可

​       有关这个问题的[github官方帮助文档](https://help.github.com/articles/using-a-custom-domain-with-github-pages/)

​       之前clone jekyll模板的时候在项目中有个CNAME文件，刚开始不知道它的而作用就保留了。我还没有申请域名，现在看来这个文件不仅unnecessary而且是trouble maker。删除这个文件就没有警告了。O(∩_∩)O