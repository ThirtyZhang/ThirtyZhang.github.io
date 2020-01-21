---
title: GitHub国内访问加速
top: false
cover: true
toc: true
mathjax: true
date: 2020-01-21 10:46:53
password:
summary: 解决GitHub有时会连接超时,或者下载速度慢
tags:
- 工具
categories:
- 效率
---

# Github加速

## 原理

修改系统hosts文件的办法，绕过国内dns解析，直接访问GitHub的CDN节点

访问网址时先搜索hosts文件，如果由网址对应的ip则不需要dns域名解析，因此可以将网址的ip配成静态ip，减少解析过程，提高访问速度。 

## 操作

**修改hosts**

> hosts文件最下面增加（win10的位置为C:\Windows\System32\drivers\etc，先拷到其他地方修改后再覆盖该文件夹hosts文件）：

```powershell
# Github加速
192.30.253.113     github.com
185.199.108.153    github.github.io
151.101.72.133     assets-cdn.github.com
151.101.185.194    github.global.ssl.fastly.net
# Github加速结束
```

刷新系统DNS缓存 ****

> 打开`cmd console:`
>
> > `Windows+X` 打开系统命令行（管理员身份）或 PowerShell 

> 执行：`ipconfig /flushdns`

到这里就完成了,下面介绍下获取最新地址方法

##  获取GitHub官方CDN地址 

**打开:**[<https://www.ipaddress.com/> ](https://www.ipaddress.com/)

```powershell
# Github加速
192.30.253.113     github.com
185.199.108.153    github.github.io
151.101.72.133     assets-cdn.github.com
151.101.185.194    github.global.ssl.fastly.net
# Github加速结束
```

查询上述IP后面的网址,更新前面的IP地址,并重新修改`hosts`文件