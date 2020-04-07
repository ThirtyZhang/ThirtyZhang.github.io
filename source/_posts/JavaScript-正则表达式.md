---
title: JavaScript-正则表达式
top: false
cover: false
toc: true
mathjax: true
date: 2020-02-18 16:33:37
password:
summary:
tags:
- JavaScript
categories:
- 前端
---

# 正则表达式(RegExp)

## 创建

> ```js
> var reg = /abc/igm;  //字面量定义规则
> var str = "abcd";
> reg.test(str);  // true   //正则表达式的方法 , 参数为字符串 , 如果符合则返回true
> str.match(reg);  //["abc"]  // 字符串的方法,参数为正则表达式 , 返回找到的字符串
> var reg = new RegExp("abc" , "igm") // 构造函数定义规则
> ```
>
> > `i` 忽略大小写
> >
> > `g` 全局匹配
> >
> > `m` 多行匹配
> >
> > > ```js
> > > var reg = /^a/gm;  // ^a 以a开头  g 全局查找  m 换行匹配
> > > var str = "abc\na";  // `\n`表示换行 ,
> > > str.match(reg); //["a", "a"]  //有m则返回两个a , 去掉则返回一个a
> > > ```
> > >
> > > 
> >
> > `^`以什么打头 如果放到 []里面则表示非
> >
> > ```js
> > var reg = /[^a]/; //非a 查找不是a的单个字符
> > var str = /abc/;
> > str.match(reg); // ["b"]   如果加上 g 则返回["b" , "c"]
> > ```
> >
> > `()`优先计算     子表达式    会把括号中匹配的信息也返回
> >
> > ```js
> > var reg = /(abc|bcd)/;  //匹配abc或者bcd
> > ```
> >
> > `$` 以什么结尾
>
>  

## 表达式 和 元字符

> ```js
> var reg = /[能取到的范围]/; 
> \w ===[0-9A-z_] 
> \W ===\w
> \s //空白字符 空格 \n换行符  \f换页符  \r回车符  \t制表符 \v垂直制表符
> \S //非空白字符  
> \d  === [0-9]
> \D  //非数字
> \b  //单词边界
> \B  //非单词边界
> //存在字符\w和\W相邻,那么这两个字符之间就有单词边界 , 包括字符串首尾
>     var str6 = "abc_d,123中文_d3=efg汉字a";
>     var reg6 = /[\d\D]\b/g;
>     console.log(str6.match(reg6));  //["d", ",", "3", "文", "3", "=", "g", "字", "a"]  // 匹配的是 右边存在单词边界的字符
>  .  === [^\r\n]   //非回车换行符的任意字符
> ```
>
> 

## 量词

> `+ `  一次以上 `{1,}`
>
> `*` 任意次   `{0,}`
>
> `?`  0 个 或 1个 `{0,1}`
>
> 默认贪婪匹配 量词后边 用 `?`修饰表示非贪婪

## 方法

> `reg.exec();`
>
> ```js
> var reg = /ab/g;  // 不加 g lastIndex不会变 , 每次匹配的都是第一个ab
> var str = "abababab";
> console.log(reg.exec(str)); //[ab] //第一个ab  reg.lastIndex 变为2
> console.log(reg.exec(str)); //[ab] //从游标为2的地方匹配第二个ab   reg.lastIndex 变为4
> ```

> `str.split(reg)`    -- 按正则表达式拆分字符串
>
> `str.replace`
>
> ```js
> str.replace("a",  "b");  //把字符串中找到的第一个 a 替换成 b
> var reg = /a/g;
> str.replace(reg , "b");  //这样可以实现把所有的 a 替换成 b 如果把 g 去掉 也只能替换第一个 a
> ```
>
> `str.toUpperCase()`  //把字符串 str中的字母全变成大写
>
> `str.toLowerCase()` //字符串字母变小写

## 正向预查  或者  正向断言

> ```js
> var str = "abaaaa";
> var reg = /a(?=b)/g;  // (?=b)不参与选择 , 只参与限定 限定 a 的后边要跟着b 
> var reg = /a(?!b)/g;  // (?=b)不参与选择 , 只参与限定 限定 a 的后边不是 b 
> str.match(reg);// ["a"]
> ```

## 练习题

> 检验字符串首尾是否含有数字
>
> ```js
> var reg = /^\d | \d$/;
> ```
>
> 匹配四个重复值
>
> ```js
> var reg = /(\w)\1\1\1/g;  // \1 引用第一个表达式中匹配的值  \2 就是第二个 依次类推
> ```
>
> 把 `aabb` 这种形式的字符串反过来变成 `bbaa`
>
> ```js
> var str = "aabb";
> var reg  = /(\w)\1(\w)\2/g;
> str.replace(reg , "$2$2$1$1") //这里如果就是要替换成 $ 的话 要写 $$ ,类似于转义
> 
> //另外的方法
> var reg = /(\w)\1(\w)\2/g;
> str.replace(reg, function ($ , $1 , $2){ //三个参数一次接收 整个表达式返回结果 , 第一个子表达式结果 , 第二个子表达式结果
>     return $2 + $2 + $1 + $1
> });
> ```
>
> 把 // the-first-name 变成小驼峰命名式 // theFirstName
>
> ```js
> var str = "the-first-name";
> var reg = /-(\w)/g;
> str.replace(reg, function ($ , $1){
>     return $1.toUpperCase();
> })
> ```
>
> 字符串去重
>
> ```js
> var str = "aaaabbbccc";
> var reg = /(\w)\1*/g;
> str.replace(reg, "$1");
> ```
>
> 把 1000000 变成 1.000.000
>
> ```js
> var str = "1000000"
> var reg = /(?=(\B)(\d{3})+$)/g  //匹配后边跟的是一个非单词边界和3的倍数个数字的空白字符
> str.replace(reg, ".");
> ```
>
> 