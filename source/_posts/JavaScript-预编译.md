---
title: JavaScript-预编译
top: false
cover: false
toc: true
mathjax: true
date: 2020-02-22 02:07:06
password:
summary:
tags:
- JavaScript
categories:
- 前端
---

# 预编译

## 前奏

> `imply globle` 暗示全局变量 :  未声明直接赋值的的变量归`window`所有 

> 一切声明的全局变量 , 全是`window`的属性.

> `window`就是全局的域
>
> ```js
> var a = 123;
> //window  {
> //       a :123
> //}
> 
> console.log(a)  === console.log(window.a);
> 
> ```
>
> 

## 例子

> 预编译发生在函数执行的前一刻
>
> 四部曲:
>
> > 1. 创建AO 对象 Activation Object (执行期上下文)
> >
> > 2. 找形参和变量声明 , 将变量和形参名作为AO属性名,值为`undefined`
> > 3. 将实参和形参统一
> > 4. 在函数体里面找函数声明, 值赋予函数体 
>
> ```js
> function fn (a) {
>     console.log(a); //function
>     var a = 123;
>     console.log(a); //123
>     function a () {}
>     console.log(a); //123 
>     var b = function (){}
>     console.log(b); //function
>     function d () {} 
> }
> fn(1);
> ```

> 预编译发生在全局执行的前一刻
>
> 三部曲
>
> 全局预编译    GO === window
>
> 1. 创建GO
> 2. 变量名作为AO的属性名, 值为`undefined`
> 3. 在函数体里面找函数声明, 值赋予函数体 

```js
global = 100;
function fn() {
    console.log(global); //undefined
    global = 200;
    console.log(global);  //200
    var global = 300;
}
fn();
var global;
```

