---
title: JS定时器
top: false
cover: false
toc: true
mathjax: true
date: 2020-02-13 00:03:06
password:
summary:
tags:
- JavaScripe
categories:
- 前端
---

# 定时器

> 都是全局对象window上的方法 , 内部函数this指向window
>
> 注意:
>
> ```js
> setInterval("console.log('a');", 1000);//每隔1000毫秒会打印一次字符串a
> ```

> 设置循环定时器
>
> `setInterval`
>
> ```js
> setInterval(function(){
>     
> },1000); // 定时器时间不准
> ```
>
> 
>
> 清除循环定时器
>
> `clearInterval`
>
> ```js
> var timer = setInterval(function(){
>     
> },1000);
> clearInterval(timer);
> ```
>
> 设置单次执行定时器
>
> `setTimeout`
>
> ```js
> setTimeout(function(){
> 
> },1000);   //延时1000毫秒执行,只执行一次
> ```
>
> 清除单次执行定时器
>
> `clearTimeout`
>
> ```js
> var timer = setTimeout(function(){
>     
> },1000);
> clearTimeout(timer);
> ```
>
> 