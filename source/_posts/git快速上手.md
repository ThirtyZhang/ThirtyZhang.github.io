---
title: Git快速上手
top: false
cover: false
toc: true
mathjax: true
date: 2020-01-21 17:42:53
password:
summary: Git是目前世界上最先进的分布式版本控制系统
tags:
- 工具
categories:
- 效率
---



# Git教程

> 如果之前了解过想复习一下,直接看总结就可以了

## 安装

## 设置Name和Email地址

安装完成后，还需要最后一步设置，在命令行输入：

```powershell
$ git config --global user.name "Your Name"
$ git config --global user.email "email@example.com"
```

> 因为Git是分布式版本控制系统，所以，每个机器都必须自报家门：你的名字和Email地址。你也许会担心，如果有人故意冒充别人怎么办？这个不必担心，首先我们相信大家都是善良无知的群众，其次，真的有冒充的也是有办法可查的。
>
> 注意`git config`命令的`--global`参数，用了这个参数，表示你这台机器上所有的Git仓库都会使用这个配置，当然也可以对某个仓库指定不同的用户名和Email地址。

# 本地版本库

选择一个合适的地方，创建一个空目录：

```powershell
$ mkdir learngit
$ cd learngit
$ pwd
/Users/michael/learngit
```

> `pwd`命令用于显示当前目录。在我的Mac上，这个仓库位于`/Users/michael/learngit`。
>
>  **如果你使用Windows系统，为了避免遇到各种莫名其妙的问题，请确保目录名（包括父目录）不包含中文。** 

通过`git init`命令把这个目录变成Git可以管理的仓库：

```powershell
$ git init
Initialized empty Git repository in /Users/michael/learngit/.git/
```

> 瞬间Git就把仓库建好了，而且告诉你是一个空的仓库（empty Git repository），细心的读者可以发现当前目录下多了一个`.git`的目录，这个目录是Git来跟踪管理版本库的，没事千万不要手动修改这个目录里面的文件，不然改乱了，就把Git仓库给破坏了。
>
> 如果你没有看到`.git`目录，那是因为这个目录默认是隐藏的，用`ls -ah`命令就可以看见。
>
> **也不一定必须在空目录下创建Git仓库，选择一个已经有东西的目录也是可以的。不过，不建议你使用自己正在开发的公司项目来学习Git，否则造成的一切后果概不负责。** 

## 把文件添加到版本库

> 首先这里再明确一下，所有的版本控制系统，其实只能跟踪文本文件的改动，比如TXT文件，网页，所有的程序代码等等，Git也不例外。版本控制系统可以告诉你每次的改动，比如在第5行加了一个单词“Linux”，在第8行删了一个单词“Windows”。而图片、视频这些二进制文件，虽然也能由版本控制系统管理，但没法跟踪文件的变化，只能把二进制文件每次改动串起来，也就是只知道图片从100KB改成了120KB，但到底改了啥，版本控制系统不知道，也没法知道。
>
> 不幸的是，Microsoft的Word格式是二进制格式，因此，版本控制系统是没法跟踪Word文件的改动的，前面我们举的例子只是为了演示，如果要真正使用版本控制系统，就要以纯文本方式编写文件。
>
> 因为文本是有编码的，比如中文有常用的GBK编码，日文有Shift_JIS编码，如果没有历史遗留问题，强烈建议使用标准的UTF-8编码，所有语言使用同一种编码，既没有冲突，又被所有平台所支持。
>
> 使用Windows的童鞋要特别注意：
>
> 千万不要使用Windows自带的**记事本**编辑任何文本文件。原因是Microsoft开发记事本的团队使用了一个非常弱智的行为来保存UTF-8编码的文件，他们自作聪明地在每个文件开头添加了0xefbbbf（十六进制）的字符，你会遇到很多不可思议的问题，比如，网页第一行可能会显示一个“?”，明明正确的程序一编译就报语法错误，等等，都是由记事本的弱智行为带来的。建议你下载[Notepad++](http://notepad-plus-plus.org/)代替记事本，不但功能强大，而且免费！记得把Notepad++的默认编码设置为UTF-8 without BOM即可：

先添加:

```powershell
# 单个文件
$ git add readme.txt 
# 多个文件
$ git add readme.txt readmeCN.txt
# 全部添加
$ git add .
```

## 把文件提交到本地版本库

再提交:

```powershell
$ git commit -m "wrote a readme file"
```

> 简单解释一下`git commit`命令，`-m`后面输入的是本次提交的说明，可以输入任意内容，当然最好是有意义的，这样你就能从历史记录里方便地找到改动记录。
>
> 嫌麻烦不想输入`-m "xxx"`行不行？确实有办法可以这么干，但是强烈不建议你这么干，因为输入说明对自己对别人阅读都很重要。实在不想输入说明的童鞋请自行Google，我不告诉你这个参数。

> 为什么Git添加文件需要`add`，`commit`一共两步呢？因为`commit`可以一次提交很多文件，所以你可以多次`add`不同的文件，比如：
>
> ```powershell
> $ git add file1.txt
> $ git add file2.txt file3.txt
> $ git commit -m "add 3 files."
> ```

## 撤销操作



```powershell
# 查看本地库文件状态
$ git status
# 文件当前文件改了什么,查看一下再提交就比较放心
$ git diff readme.txt 
```

> - 要随时掌握工作区的状态，使用`git status`命令。
> - 如果`git status`告诉你有文件被修改过，用`git diff`可以查看修改内容。

## 版本回退

```powershell
# 回退到上一版
$ git reset --hard HEAD^
# 回退到上上一版
$ git reset --hard HEAD^^
# 回退到指定版
$ git reset --hard commit_id
```

> - `HEAD`指向的版本就是当前版本，因此，Git允许我们在版本的历史之间穿梭，使用命令`git reset --hard commit_id`。
> - 穿梭前，用`git log`可以查看提交历史，以便确定要回退到哪个版本。
> - 要重返未来，用`git reflog`查看命令历史，以便确定要回到未来的哪个版本。
> - 用`HEAD`表示当前版本，也就是最新的提交`1094adb...`（注意我的提交ID和你的肯定不一样），上一个版本就是`HEAD^`，上上一个版本就是`HEAD^^`，当然往上100个版本写100个`^`比较容易数不过来，所以写成`HEAD~100`。 

## 工作区和暂存区

> 前面讲了我们把文件往Git版本库里添加的时候，是分两步执行的：
>
> 第一步是用`git add`把文件添加进去，实际上就是把文件修改添加到暂存区；
>
> 第二步是用`git commit`提交更改，实际上就是把暂存区的所有内容提交到当前分支。
>
> 因为我们创建Git版本库时，Git自动为我们创建了唯一一个`master`分支，所以，现在，`git commit`就是往`master`分支上提交更改。
>
> 你可以简单理解为，需要提交的文件修改通通放到暂存区，然后，一次性提交暂存区的所有修改。

## 撤销修改

```powershell
$ git checkout -- readme.txt
```

> 命令`git checkout -- readme.txt`意思就是，把`readme.txt`文件在工作区的修改全部撤销，这里有两种情况：
>
> 一种是`readme.txt`自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
>
> 一种是`readme.txt`已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。
>
> 总之，就是让这个文件回到最近一次`git commit`或`git add`时的状态。

```powershell
$ git reset HEAD readme.txt
```

> 场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令`git checkout -- file`。
>
> 场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令`git reset HEAD <file>`，就回到了场景1，第二步按场景1操作。
>
> 场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考[版本回退](https://www.liaoxuefeng.com/wiki/896043488029600/897013573512192)一节，不过前提是没有推送到远程库。



## 删除

```powershell
$ rm file
# 删除工作区 , 可以直接用用git checkout -- <file> 恢复
$ git rm file
# 不仅删除了工作区文件，而且还添加到了暂存区，需要先git reset HEAD <file>，然后再git checkout -- <file>
& git rm file
& git commit -m "说明注释"
# 彻底删除 , 先删除工作区和暂存区,再提交到master分支(仓库)
```

> 
>
> 如果你用的rm删除文件，那就相当于只删除了工作区的文件，如果想要恢复，直接用git checkout -- <file>就可以 2.如果你用的是git rm删除文件，那就相当于不仅删除了文件，而且还添加到了暂存区，需要先git reset HEAD <file>，然后再git checkout -- <file> 3.如果你想彻底把版本库的删除掉，先git rm，再git commit 就ok了 

# 本地仓库总结

> Git管理的文件分为：工作区，版本库，版本库又分为暂存区stage和暂存区分支master(仓库)
>
> 工作区>>>>暂存区>>>>仓库
>
> git add把文件从工作区>>>>暂存区，git commit把文件从暂存区>>>>仓库，
>
> git diff查看工作区和暂存区差异，
>
> git diff --cached查看暂存区和仓库差异，
>
> git diff HEAD 查看工作区和仓库的差异，
>
> git add的反向命令git checkout，撤销工作区修改，即把暂存区最新版本转移到工作区，
>
> git commit的反向命令git reset HEAD，就是把仓库最新版本转移到暂存区。

> **新建git本地仓库：**
>
> `git init` 
>
> 新建一个.git文件，有这个文件就是一个git仓库
>
> **git本地仓库分三个区来区别操作（这个思路太重要了）：** 
>
> **工作区：** 就是一个多了.git文件的文件夹，不要想太多，就按Linux操作文件夹的方法正常操作 
>
> **暂存区：** 暂时讲了两种操作暂存区的方法：
>
>  1.存入暂存区:
>
> `git add filename`  //添加文件
>
> `git rm filename`   //删除文件
>
>  这两条都是修改暂存区 
>
> 2.递交暂存区
>
>  `git commit -m "log说明一般写改动是什么"` 
>
> 别忘了正常来说一般对暂存区修改以后一定要commit一下
> **版本库：**`git commit`以后的最终版本存入地方，git最重要的一个地方，因为只有版本库的修改才可以跟踪
>
> 另外有几个命令查看状态也很重要： 
>
> `git status`
>
> 查看当前git仓库与上一次commit之后的版本库的一切修改，包括工作区的修改和暂存区的修改（这种信息是不详细的） 很人性化的是，`git status`会提示你下一步可能会做的事，比如你对工作区做了修改，他可能会提示下一步要git add或者
>
> `git checkout  filename `
>
> ， 你刚执行完git add以后，git status跟踪的暂存区的修改，他又会提示你下一步可能要提交git commit或者
>
> `git reset HEAD < filename >` 
>
> `git diff filename`
>
> 这个命令返回的是你对工作区的修改，别想太多，和什么对比并不重要，你只要知道什么时候他会有信息返回，返回什么信息！什么时候有返回呢！你对工作区已经存在的文件修改<!--（但是没有存入暂存区，也就是说没有git add或者git rm，所以一定要纠结的话，他比较的的确是暂存区和工作区的区别）-->的话有返回**（新建文件git diff看不到）**，返回什么，返回修改的详细信息，+是新添的行-是删去的行
>
>  `git diff --cached filename`
>
> 这个命令是查看你对暂存区的修改，也就是你`git add`或者`git rm`以后，`git diff`的返回信息就用`git diff --cached`来用了（这也是为什么这两个命令一样，只有参数不一样的原因，因为其实干的都是一件事，只是`git diff`针对的对象是工作区，`git diff --cached`针对的对象是暂存区） 
>
> `git log`
>
> **当前版本之前**的commit日志记录，也就是说当前版本是回退回来的版本的话，当前版本之后的提交与回退都看不到（有个很重要的commit ID）
>
> `git reflog`
>
> 包括版本回退、版本提交的日志，信息相较于`git log`会比较简单 
>
> **这样把命令的针对对象分为三个区来理解，现在看撤销操作就很容易了：**
>
>  1.针对工作区的撤销（必须保证没有git add/git rm之前）： 
>
> `git checkout -- filename` 
>
> 2.针对暂存区的撤销（必须是git add/git rm以后才行） 
>
> `git reset HEAD filename` 
>
> 顺便想起git reset的另一种用法，参数不一样啦，那肯定也是撤销操作，当然就是撤销提交，回退版本啦
>
> `git reset --hard （HEAD^^^^）/commit id`

# 远程仓库

> Git是分布式版本控制系统，同一个Git仓库，可以分布到不同的机器上。怎么分布呢？最早，肯定只有一台机器有一个原始版本库，此后，别的机器可以“克隆”这个原始版本库，而且每台机器的版本库其实都是一样的，并没有主次之分。 

[GitHub](https://github.com/) 提供Git仓库托管服务 , 注册一个GitHub账号，就可以免费获得Git远程仓库 ,自行点击链接注册

> 本地Git仓库和GitHub仓库之间的传输是通过SSH加密的 ,所以需要设置下SSH Key

> 第1步：**创建SSH Key**。在用户主目录下`C:\Users\zl`<!--用户主目录在windows中就是 C:\Users\Administrator\，或者你新建了一个用户，那就是 C:\Users\用户名\--> ，看看有没有.ssh目录，如果有，再看看这个目录下有没有`id_rsa`和`id_rsa.pub`这两个文件，如果已经有了，可直接跳到下一步。如果没有，打开Shell（Windows下打开Git Bash），创建SSH Key：

```powershell
$ ssh-keygen -t rsa -C "youremail@example.com"
```

> 你需要把邮件地址换成你自己的邮件地址，然后一路回车，使用默认值即可，由于这个Key也不是用于军事目的，所以也无需设置密码。
>
> 如果一切顺利的话，可以在用户主目录里找到`.ssh`目录，里面有`id_rsa`和`id_rsa.pub`两个文件，这两个就是SSH Key的秘钥对，`id_rsa`是私钥，不能泄露出去，`id_rsa.pub`是公钥，可以放心地告诉任何人。
>
> 第2步：登陆GitHub，打开“Account settings”，“SSH Keys”页面：
>
> 然后，点“**Add SSH Key”**，填上任意Title，在Key文本框里粘贴`id_rsa.pub`文件的内容：

## 本地文件添加到远程仓库

* 找到“Create a new repo”按钮，创建一个新的仓库： 
* 在Repository name填入名称
* 其他保持默认设置，点击“Create repository”按钮，就成功地创建了一个新的Git仓库 

在本地的`learngit`仓库下运行命令：

```powershell
$ git remote add origin git@github.com:michaelliao/learngit.git
```

> 请千万注意，把上面的`michaelliao`替换成你自己的GitHub账户名，否则，你在本地关联的就是我的远程库，关联没有问题，但是你以后推送是推不上去的，因为你的SSH Key公钥不在我的账户列表中。
>
> 添加后，远程库的名字就是`origin`，这是Git默认的叫法，也可以改成别的，但是`origin`这个名字一看就知道是远程库。
>
> 下一步，就可以把本地库的所有内容推送到远程库上：

```powershell
$ git push -u origin master
```

> 把本地库的内容推送到远程，用`git push`命令，实际上是把当前分支`master`推送到远程。
>
> 由于远程库是空的，我们第一次推送`master`分支时，加上了`-u`参数，Git不但会把本地的`master`分支内容推送的远程新的`master`分支，还会把本地的`master`分支和远程的`master`分支关联起来，在以后的推送或者拉取时就可以简化命令。
>
> 推送成功后，可以立刻在GitHub页面中看到远程库的内容已经和本地一模一样 

> 从现在起，只要本地作了提交，就可以通过命令：

```powershell
$ git push origin master
```

## 克隆别人的Git远程仓库到自己的仓库

* 在本地新建文件夹克隆下来
* 删除`.git`文件
* 然后在自己的GitHub上新建一个仓库
* 在本地仓库执行

```powershell
$ git init
$ git remote add origin 新建的仓库地址
$ git add .
$ git commit -m "提交全部"
$ git push -u origin master
```

## SSH警告

> 当你第一次使用Git的`clone`或者`push`命令连接GitHub时，会得到一个警告：
>
> ```
> The authenticity of host 'github.com (xx.xx.xx.xx)' can't be established.
> RSA key fingerprint is xx.xx.xx.xx.xx.
> Are you sure you want to continue connecting (yes/no)?
> ```
>
> 这是因为Git使用SSH连接，而SSH连接在第一次验证GitHub服务器的Key时，需要你确认GitHub的Key的指纹信息是否真的来自GitHub的服务器，输入`yes`回车即可。
>
> Git会输出一个警告，告诉你已经把GitHub的Key添加到本机的一个信任列表里了：
>
> ```
> Warning: Permanently added 'github.com' (RSA) to the list of known hosts.
> ```
>
> 这个警告只会出现一次，后面的操作就不会有任何警告了。
>
> 如果你实在担心有人冒充GitHub服务器，输入`yes`前可以对照[GitHub的RSA Key的指纹信息](https://help.github.com/articles/what-are-github-s-ssh-key-fingerprints/)是否与SSH连接给出的一致。

> 要关联一个远程库，使用命令`git remote add origin git@server-name:path/repo-name.git`；
>
> 关联后，使用命令`git push -u origin master`第一次推送master分支的所有内容；
>
> 此后，每次本地提交后，只要有必要，就可以使用命令`git push origin master`推送最新修改；
>
> 分布式版本系统的最大好处之一是在本地工作完全不需要考虑远程库的存在，也就是有没有联网都可以正常工作，而SVN在没有联网的时候是拒绝干活的！当有网络的时候，再把本地提交推送一下就完成了同步，真是太方便了！

## 从远程库克隆到本地

* 第一步
  * 新建一个仓库,勾选`Initialize this repository with a README`，这样GitHub会自动为我们创建一个`README.md`文件。创建完毕后，可以看到`README.md`文件： 
* 第二步
  * `$ git clone 仓库的URL`

> URL我们一般选取SSH 相较于 http 而言 方便不用每次都输入用户名密码,而且传输速度快
>
> 除非公司只支持 http 才会选用