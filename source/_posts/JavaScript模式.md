---
title: JavaScript模式
top: false
cover: false
toc: true
mathjax: true
date: 2020-02-05 23:09:46
password:
summary: 个人JavaScript学习笔记
tags:
- JavaScript
categories:
- 前端
---

#  JavaScript模式

## for循环优化

> 每次访问数组的长度是非常耗时的 , 所以我们将已经遍历过的数组或容器的长度缓存起来,如以下代码//

```js
for(var i = 0,max = arr.length;i < max ; i++){
	//对arr进行处理    
}
```

> 第二种 : 使用最少的变量 , 逐步减至0

```js
var i , arr = [];
for(i = arr.length ; i-- ;){//省略第三个参数,通过用 i-- 至 0 来终止循环
    //处理arr
}

//while循环实现
var arr = [],
    i = arr.length;
while(i--){
      //梳理arr[i]
}
```

> 我们提倡用正常的for循环来处理数组 , 用for - in 循环来处理对象

## hasOwnProperty

> Object的`hasOwnProperty()`方法返回一个布尔值，判断对象是否包含特定的自身（非继承）属性。 

```js
console.log(person.hasOwnProperty('name')); //查看person对象是否包含自身(非继承)属性 : name;
```

## 圣杯模式

```js
function inherit(Target,Origin){
	function F() {};  //定义一个空方法
    F.prototype = Origin.prototype;  //让空方法的原型等于父亲的原型
    Target.prototype = new F();      //需要实现继承的方法的原型指向 new F();  -- 这样就实现了对象值传递
    Target.prototype.constuctor = Target;  //如果不更改构造器的话,Target的构造器会指向Origin , 所以手动更改指向为自身
    Target.prototype.uber = Origin.prototype;  //添加 uber 属性指明真实继承自哪里
}
```

> 利用闭包实现变量私有化

```js
var inherit = (function(){
    var F = function () {};  //利用闭包特性隐藏此方法
    return function (Target , Origin){  //在立即执行函数中 return 此方法形成闭包
        F.prototype = Origin.prototype;
        Target.prototype = new F();
        Target.prototype.constuctor = Target;
        Target.prototype.uber = Origin.prototype;
    }
});
```

## instanceof

> `instanceof` A 对象 是不是 B 构造函数构造出来的

```js
A instanceof B
// 看A对象的原型链上 有没有 B 的原型
```

## 区分数组还是对象

> 通过`constructor` 构造器来区分

```js
var arr = [];
arr.constructor;  // function Array(){};
var obj = {};
obj.constructor;  // function Object(){};
```

> `instanceof`

```js
arr instanceof Array; //true
obj instanceof Object; //true
```

> `toString`

```js
Object.prototype.toString.call(arr); // "[object Array]"
Object.prototype.toString.call(obj); // "[object Object]"
```

> ES 5 新增 `Array.isArray([]); //true`  参数为数组时返回 `true`



## 命名模式

> 构造函数首字母大写
>
> 函数名是多个单词的时候 , 构造函数使用大驼峰命名法 , 普通函数使用小驼峰命名法
>
> 变量是多个单词 , 使用小写用`_`隔开 ,  或者也使用小驼峰命名法
>
> 使用全部大写的方式表示一个常量 , 来表示不要进行修改 , 或者通过全部大写来表示全局变量
>
> 使用下划线前缀声明私有函数[方法] 和 属性.

## new

> 当以`new`操作符调用构造函数时 , 函数内部将会发生以下情况 : 
>
> 1. 创建一个空对象并且`this`变量引用了该对象 , 同时还继承了该函数的原型.
> 2. 属性和方法被加入到`this`引用的对象中.
> 3. 新创建的对象由`this`所引用 , 并且最后隐式地返回`this` (如果没有显式的返回其他对象).
>
> ```js
> //以上情况看起来就像是在后台发生了如下事情: 
> var Person = function (name) {
>     var this = {}; // 使用对象字面量模式创建一个新对象
>     this.name = name; // 向this添加属性和方法
>     return this;
> }
> ```

## arguments.callee

> 指向函数自身的引用

```js
function test () {
    console.log(argument.callee); //test 这个函数本身
}
```

## caller

> 被调用环境的引用

```js
function test (){
    demo();
}
function demo (){
    console.log(demo.caller); // test这个函数自身
}
test();
```

## clone - 复制-浅拷贝-深拷贝

> clone - 浅拷贝

```js
   var obj = {
       name : "zhanglei",
       age : 18
   };
   var obj1 = {};
   function clone(origin , target){
       var target = target || {}; //如果传入了target则使用target,否则使用{}
       for(key in origin) {
            target[key] = origin[key];
       }
       return target;
   }
   clone(obj, obj1);
   console.log(obj1);
```

> clone - 深拷贝

```js
var obj = {
    name: "zhanglei",
    age: 18,
    hobby: [1, 2, 3]
};
var obj2 = {}; //空对象
// 通过函数实现 , 把对象 a 中的所有的数据深拷贝到 b 中
function extend (a, b) {
    for (var key in a) {
        //先获取 a 对象中每个属性的值
        var item = a[key];
        //判断这个属性的值是不是数组
        if (item instenceof Array){
            //如果是数组 , 那么在 b 对象中添加一个新的属性,并且这个属性值也是数组
            b[key] = [];
            //调用这个方法, 把 a 对象中这个数组的属性一个一个的复制到 b 对象的这个数组属性中
            extend(item,b[key]);
        } else if(item instenceof Object){
            b[key] = {};
            extend(item, b[key]);
        }else{
            //如果是普通的数据 , 直接复制到 b 对象的这个属性中
            b[key] = item;
        }
    }
};
extend(obj,obj2);
```

## 数组中的常用方法

### 改变原数组

> `push` 从后边添加,并返回添加后的数组长度,可以添加多个,用`,`隔开
>
> ```js
> var arr = [];
> arr.push(1);
> arr.push(2,3);
> arr; //[1,2,3]
> //手写push方法
> Array.prototype.push = function () {
>     for (var i = 0 ; i < arguments.length ; i++){
>         this[this.length] = arguments[i];
>     }
>     return this.length;
> }
> ```
>
> `pop`把数组的最后一位剪切出来.返回剪切的值,和`push`相对应
>
> `shift`从前边减
>
> `unshift` 从前边加
>
> `sort`排序 , 默认按照 ASCII码排序  视频第27个 ,时间50分钟
>
> ```js
> //1. 必须写俩形参
> //2. 看返回值
> 	//1.当返回值为负数时,那么前面的数放在前面
> 	//2.为正数 , 那么后面的数在前
> 	//3.为0 . 不动
> var arr = [1,3,5,4,10];
> arr.sort(function (a,b){
>     //return a - b; 升序
>     //return b - a; 降序
>     //return Math.random() - 0.5; 打乱顺序
>     return a - b;
> });
> arr; //[1,3,4,5,10];
> 
> ```
>
> 
>
> 
>
> `reverse` 翻转顺序
>
> ```js
> var arr = [1,2,3];
> arr.reverse(); 
> arr; // [3,2,1]
> ```
>
> `splice` 切片
>
> > 参数: 从第几位开始 , 截取多少长度 , 在切口处添加数据
>
> ```js
> var arr = [1,2,3,5];
> arr.splice(3,0,4);
> arr; //[1,2,3,4,5]
> ```

### 不改变原数组

> `concat` 连接两个数组
>
> ```js
> var arr = [1,2];
> var arr2 = [3,4];
> arr.concat(arr2); //[1,2,3,4]
> ```
>
> `join`数组转换成字符串
>
> ```js
> var arr = [1,2,3]
> var str = arr.join("-");
> str;//"1-2-3";
> ```
>
> `split`字符串的方法,把字符串按照参数拆分成数组,与`join`互逆
>
> ```js
> var str = "1-2-3";
> var arr = str.split("-");
> arr; //["1","2","3"]
> ```
>
> `toString`
>
> `slice`
>
> > 参数1  从该位开始截取
> >
> > 参数2  截取到该位
> >
> > > 不写第二个参数 , 则截取到最后
> > >
> > > 不写参数,则整个截取
>
> ```js
> var arr = [1,2,3,4,5];
> var newArr = arr.slice(1,3);
> newArr; //[2,3]
> ```
>
> 

## charCodeAt

> 作用：返回指定位置的字符的Unicode编码。这个返回值在0~65535之间的整数。
>
> 可以判断返回值是否大于255,来判断时候是中文 

```js
var str = "zl张磊";
function retBytes(str){
    var mun = str.length;
    for(var i = 0; i < str.length; i++){
        if(str.chatCodeAt(i) > 255){
           num++;
        }
    }
    return num;
}
reBytes(str);//6
```

## 类数组 

> 看起来像数组 , 但是不具有数组操作的一些方法  视频第28个 
>
> DOM元素全是类数组

##  数组去重

> 利用对象 , 让数组的值为对象的属性名循环添加属性,最后取出对象名就可以

```js
var arr = [1,2,1,1,1,2,2,2];
var obj = {};
for (var i = 0 ,max = arr.length; i<max; i++){
    obj[arr[i]] = arr[i];
}
console.log(obj);
arr = [];
for(key in obj){
    arr.push(key);
};
console.log(arr);

// 添加到数组的原型方法中
Array.prototype.unique = function () {
    var obj =  {}, //声明一个空对象用来存放
        arr = [];  //声明一个空数组
    for(var i = this.length;i--;){
        if(!obj[this[i]]){
           obj[this[i]] = this[i];
           arr.push(this[i]);
        }
    }
    return arr;
}
```

## 包装类

> 把原始值包装成对象
>
> 原始值本身没有属性 , 但是原始值调用属性时会 根据原始值类型 

```js
var str = "abc";
console.log(str.length);  // 实际执行是: `new String('abc').length` 执行完之后就会进行删除
console.log(new String('abc').length);  
```

## Object.create() - 创建对象

> Object.create(prototype, definedProperty);

```js
var demo = {
    name = "张磊";
};
var obj = Objgect.create(demo);  // 创建一个空对象 , 对象的原型就是`demo` , 并返回
```

> 一旦经历了`var `的操作 , 所得出的属性 , window ,这种属性叫做不可配置的属性(不能delete)
>
> 形参也相当于是`var`声明的变量

```js
var mun = 123;
delete mun; //false
window.num = 123;
delete num; //true
```

## this  

视频第30个 , 15分

> 1. 预编译 `this`指向`window`
> 2. 谁调用的 `this`就指向谁
> 3. `call` `apply ` 改变`this`指向
> 4. 全局 中  `this` 指向 `window`

```js
function Person (name, age) {
    this.name = name;
    this.age = age;
}

function Student (name, age, sex){
    //隐式把函数的原型赋值给this
    //var this = Object.create(Student.prototype);
    Person.call(this   , name, age); // 改变Person的this指向调用Person
    this.sex = sex
}

```

## 闭包

> a 函数中包含 b 函数 , 只要 b 函数被返回到 a 函数的外边 , 就会形成闭包 , b 就会拿到 a 的执行上下文

## 预编译

> 1. 变量和形参声明提升
> 2. 形参和实参相统一
> 3. 函数声明提升 - 函数名作为属性名,函数体作为属性值
> 4. 函数执行 - 预编译过得语句将会跳过执行 

## try {} catch {} finally {}

### 错误类型

> 1. EvalError : eval() 的使用与定义不一致
> 2. RangeError :数值越界
> 3. ReferenceError :非法或不能识别的引用数值
> 4. SyntaxError : 发生语法解析错误
> 5. TypeError : 操作数类型错误
> 6. URLError : URL 处理函数使用不当

## es 5 严格模式

> 如果使用`es5`严格模式, name`es3` 和 	`es5` 产生的冲突部分就用`es5` , 否则会用`es3`

> 启用方式 : 
>
> `"use strict"`
>
> > 变量必须声明
> >
> > 局部方法预编译的时候里面的`this`不再指向`window` , 必须被赋值` new ` 或者`.call`
> >
> > 拒绝重复的属性和参数
>
> > 为什么使用字符串, 而不是用方法调用呢?
> >
> > > 为了兼容老版本浏览器, 因为直接写`es5` 的方法会报错 , 而字符串老版本不能识别的情况下也不会报错

### with(){} 

> 改变作用域链最顶端 , 找变量最先往这里找, 简化代码

```ja
document.write("a");
with(document){
    write("a"); // 在with里边就可以直接写write了.
}
```

> 修改原型链如果原型链很长会整个修改, 影响效率 `es5`不能使用 ,
>
> `arguments` 的一些属性和方法 :  `caller` `callee` 也不可以在`es 5` 严格模式下使用

### eval()

> 能把字符串当成代码执行

```js
eval('console.log(a));
```

