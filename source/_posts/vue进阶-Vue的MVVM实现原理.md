---
title: MVVM
top: true
cover: false
toc: true
mathjax: true
date: 2020-04-7 12:01:56
password:
summary: 
tags:
- Vue
categories:
- 前端
---

## MVVM-介绍和演示

![MVVM](./assets/mvvm-3510948.png)

>面试过程中,面试官一定会问你 描述一下 你所知道的MVVM?
>
>MVVM 在Vue中是用什么来实现的?
>
>OK,我们来攻克这个题目

* 首先第一个M,指的是 Model, 也就是**`数据模型`**,其实就是数据, 换到Vue里面,其实指的就是 Vue组件实例中的**`data`**, 但是这个data 我们从一开始就定义了 它叫 **`响应式数据`**

* 第二个V,指的是View, 也就是**`页面视图`**, 换到Vue中也就是 我们的**`template`**转化成的**`DOM对象`**

* 第三个 VM, 指的是**`ViewModel`**,  也就是 视图和数据的管理者, 它管理着我们的数据 到 视图变化的工作,换到Vue中 ,它指的就是我们的当前的**`Vue实例`**,  Model数据 和 View 视图通信的一个**`桥梁`**

- 简单一句话：**`数据驱动视图`**, 数据变化 =>视图更新

  Vue是双向数据流,React是单向数据流

  > Vue 数据变化  => 视图变化  视图变化  => 数据变化
  >
  > React  数据变化  => 视图变化  (自身框架只支持数据驱动视图)    (手动实现)  视图变化  => 数据变化

```js
<!-- 视图 -->
<template>
  <div>{{ message }}</div>
</template>
<script>
// Model 普通数据对象
export default {
  data () {
    return {
      message: 'Hello World'
    }
  }
}
</script>

<style>

</style>

```



## MVVM-响应式原理-Object.defineProperty()-基本使用

> 接下里,我们来重点研究MVVM的原理及实现方式,Vuejs官网给出了MVVM的原理方式

[Vue文档说明](https://cn.vuejs.org/v2/guide/reactivity.html) 

>通过上面的文档我们可以发现, Vue的响应式原理(MVVM)实际上就是下面这段话:
>
>当你把一个普通的 JavaScript 对象传入 Vue 实例作为 `data` 选项，Vue 将遍历此对象所有的属性，并使用 [`Object.defineProperty`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty) 把这些属性全部转为 [getter/setter](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Working_with_Objects#定义_getters_与_setters)。`Object.defineProperty` 是 ES5 中一个无法 shim 的特性，这也就是 Vue 不支持 IE8 以及更低版本浏览器的原因。

从上面的表述中,我们发现了几个关键词, **`Object.defineProperty`**   **`getter/setter`**

> 什么是 Object.defineProperty? 

定义:`Object.defineProperty()` 方法会直接在一个对象上定义一个新属性，或者修改一个对象的现有属性， 并返回这个对象。

>语法:  Object.defineProperty(obj, prop, descriptor)

参数:  **obj**  =>  要在其上定义属性的对象。

​           **prop**  =>  要新增或者修改的属性名

​           **descriptor**  =>  将被定义或修改的属性描述符。

返回值 :    被传递给函数的对象。 也就是 传入的obj对象

>通过上面的笔记 我们来看下 有哪些参数 需要学习
>
>obj  就是一个对象  可以 new Object()  也可以  {}
>
>prop  就是属性名 也就是一个字符串
>
>descriptor 描述符是什么 ?  有哪些属性

对象里目前存在的属性描述符有两种主要形式：**`数据描述符`**和**`存取描述符`**。**`数据描述符`**是一个具有值的属性，该值可能是可写的，也可能不是可写的。**`存取描述符`**是由getter-setter函数对描述的属性。描述符必须是这两种形式之一；**`不能同时是两者`**。

>上面是官方描述 ,它告诉我们 defineProterty设计上有**`两种模式`**存在,一种**`数据描述`**, 一种**`存取描述`**
>
>描述符必须是这两个中的一个 ,不能同时是两者, 也就是 **`一山不容二虎`**, 也不能 **`一山两虎都无`**

我们写一个最简单的 **`数据描述符`**的例子

```js
        // Object.defineProperty(obj, prop, descriptor)
        // obj  对象  prop属性名 descriptor 描述符 (数据描述 / 存取描述)
        var obj = {
            msg: '愚人节,真不快乐'
        }
        // 新增一个属性
        var o = Object.defineProperty(obj, "name", {
            // 描述符对象
            value: '泰森' // 指的就是新增属性的值  value是固定写法
        })
        Object.defineProperty(obj, 'msg', {
            value: '希望找到工作'
        })
        // 返回值 o 就是 新增过属性的obj
        console.log(o)
```

>接下来进行详细分析

## Object.defineProperty()-`数据描述符`模式

> 数据描述符有哪些属性?

* **`value`** =>该属性对应的值。可以是任何有效的 JavaScript 值（数值，对象，函数等）。默认为 unfined
* **`writable`** => 当且仅当该属性的writable为true时，value才能被赋值运算符改变。默认为 false。

> 就这两个 ? 还有吗 ?

* **`configurable`**  =>  当且仅当该属性的 configurable 为 true 时，该属性`描述符`才能够被改变，同时该属性也能从对应的对象上被删除。**默认为 false**。
* **`enumerable`**  => 当且仅当该属性的`enumerable`为`true`时，该属性才能够出现在对象的枚举属性中。**默认为 false**。

>为什么  **`configurable`**  和 **`enumerable`**  不同时 和 value  还有 writable一起写呢 ?

因为这两个属性不但可以在数据描述符里出现 还可以在 存取描述符里出现

>我们通过writeable 和 value属性来写一个 可写的属性 和不写的属性  

```js
   var obj = {
          name: '曹扬'
      }
     Object.defineProperty(obj, 'money', {
         value: "10k" // 薪水 此时薪水是不可改的
     })
     Object.defineProperty(obj, 'weight', {
         value: '150斤', // 给一万根头发
         writable: true
     })
     obj.money = '20k'
     obj.weight = '200斤'
     console.log(obj)  // 此时 薪水还是 10k  但是体重变成 200斤
```

> 接下来 ,我们希望 去让一个不可变的属性变成可变的

```js
    var obj = {
          name: '曹扬'
      }
     Object.defineProperty(obj, 'money', {
         value: '10k', // 薪水 此时薪水是不可改的
         configurable: true  // 只有这里为true时 才能去改writeable属性
     })
     Object.defineProperty(obj, 'weight', {
         value: '150斤', // 给一万根头发
         writable: true
     })
     obj.money = "20k"
     obj.weight = '200斤'
     console.log(obj)
     Object.defineProperty(obj, 'money', {
         writable: true  // 只有前面配置了configurable: true 后面的属性才可以修改 
     })
     obj.money = '20k'
     console.log(obj)  // 此时薪水才可以改变
```

> 接下来,我们希望可以在遍历的时候 遍历到新添加的两个属性

```js
      var obj = {
          name: '曹扬'
      }
     Object.defineProperty(obj, 'money', {
         value: '10k', // 薪水 此时薪水是不可改的
         configurable: true,
         enumerable: true  // 此属性用来 表示该属性 可以遍历循环得到
     })
     Object.defineProperty(obj, 'weight', {
         value: '150斤', // 给一万根头发
         writable: true,
         enumerable: true

     })
     obj.money = "20k"
     obj.weight = '200斤'
     console.log(obj)
     Object.defineProperty(obj, 'money', {
         writable: true 
     })
     obj.money = '20k'
     console.log(obj)
     for(var item in obj) {
         console.log(item)
     }
```

## Object.defineProperty()-`存取描述符`模式

> 上一小节中,数据描述符 独有的属性 是 value  和 writable , 这也就意味着, 在存取描述模式中
>
> value 和 writable属性不能出现
>
> 那么 存储描述符有啥属性 ?

* **`get`**  一个给属性提供 getter 的方法，如果没有 getter 则为 `undefined`。当访问该属性时，该方法会被执行，方法执行时没有参数传入，但是会传入`this`对象（由于继承关系，这里的`this`并不一定是定义该属性的对象）。
* **`set`**  一个给属性提供 setter 的方法，如果没有 setter 则为 `undefined`。当属性值修改时，触发执行该方法。该方法将接受唯一参数，即该属性新的参数值。

>get/set  其实就是我们最常见的 读取值 和设置值得方法   this.name 读取值 this.name = '张三'
>
>读取值得时候 调用 get方法 
>
>设置值得时候调用 set方法

我们做一个 可以 通过 get 和 set 读取设置的方法

```js
        var person = {
            name: '曹操'
        }
        var name = ''
        Object.defineProperty(person, 'wife', {
            //   存取描述符  不需要 设置可写 和不可写
            //  writable: false, // 是错误的 数据描述符  不能和存取描述符一起写
            get() {
                // 获取值
                return name
            },
            set(value) {
                // 设置值
                name = value
            }
        })
        console.log(person.wife)
        person.wife = "大乔"
        console.log(person.wife)
```

>但是,我们想要遍历怎么办 ? 注意哦 , 存储描述符的时候 依然拥有 **configurable** 和 **enumerable**属性,
>
>依然可以配置哦

```js
  var person = {
            name: '曹操'
        }
        var name = ''
        Object.defineProperty(person, 'wife', {
            //   存取描述符  不需要 设置可写 和不可写
            //  writable: false, // 是错误的 数据描述符  不能和存取描述符一起写
            enumerable: true, // 表示该属性可以被遍历到
            get() {
                // 获取值
                return name
            },
            set(value) {
                // 设置值
                name = value
            }
        })
        console.log(person.wife)
        person.wife = "大乔"
        console.log(person.wife)
        console.log(Object.keys(person))
```

数据描述符 wriable 只对 数据描述的时候 value进行控制,不能和存取描述符一起写

## Object.defineProperty()-模拟vm对象

>通过两个小节,学习了 defineProperty的基本使用, 接下里我们要通过defineProperty模拟 Vue实例化的效果

Vue实例化的时候, 我们明明给data赋值了数据,但是却可以通过 **`vm实例.属性`**进行访问和设置

怎么做的 ?

```js
var vm = new Vue({ 
  data: {
      name: '张三'
  }
})
vm.name = '李四'
```





>实际上这就是 通过 Object.defineProperty实现的

```js
   var data = {
            name: '庚子初年,天下大乱,疫情危机'
        }
        var vm = {} // vm对象  vm代理data中的数据
        Object.defineProperty(vm, "name", {
            // 存取描述符
            get() {
                return data.name  // 返回data中的数据
            },
            set(value) {
                // 设置值的时候 要去修改data中的值
                data.name = value
            }
        })
        console.log(vm.name)
        vm.name = '春暖花开,一切如常'
        console.log(vm.name)
```

>上面代码中,我们实现了 vm中的数据代理了 data中的name 直接改vm就是改data

**`总结`**: 我们在 set和get的存取描述符中 代理了 data中的数据, 

MVVM => 数据代理  => Object.defineProperty =>存取描述符get/set => 代理数据

MVVM不但要获取这些数据,并且将这些数据 进行 响应式的更新到DOM中, 也就是 数据变化时,我们要把数据**`反映`**到视图上

> 通过调试我们发现,我们是可以在set函数里面监听到数据的变化的,只需要在数据变化的时候, 通知对应的视图来更新就可以了

那么 怎么通知 ? 用什么技术来做 ? 下一小节中我们将带来发布订阅模式

## 发布订阅模式的介绍

> 发布订阅模式为何物?

其实我们早已用过很多遍,  发布 /订阅 即 有人**`发布消息`**, 有人 **`订阅消息`**,到了 数据层面 就是 多  => 多

即   A程序 可以触发多个消息  也可以订阅 多个消息

> 在黑马头条项目1 和项目2 中我们 曾经 用过一个**`eventBus`** 就是发布订阅模式的体现

这个模式我们拿来做什么?

> 上个小节,我们已经能够捕捉数据的变化,接下来,我们就要尝试在数据变化的时候通过 发布订阅这个模式 来改变我们的视图

我们先写出这个发布订阅核心代码的几个要素 

> 首先,我们希望 可以通过实例化 得到 发布订阅对象  
>
> 发布消息 $emit
>
> 订阅消息 $on

根据上述思想,我们得到如下代码

```js
      //  创建一个构造函数
      function Events () {}
    //    订阅消息 监听消息
      Events.prototype.$on = function() {}
    //   发布消息
      Events.prototype.$emit = function (){}
```

## 发布订阅模式的实现

```js
   //    希望通过实例化 得到 发布订阅 管理器
        // 创建一个构造函数
        function Events() {
            //  构造函数
            // 需要监听事件 需要去触发事件
            // 需要一个 对象来存储 事件名称 和事件参数
            // { (事件名1): [回调函数1, 回调函数2,回调函数3...]    }
            // { (发工资事件): [A回调函数, B回调函数, C ,D ,E ...], (扣工资事件), (涨工资事件)  }
            this.subs = {} // this指的是当前实例 subs里面存储的就是当前对象中放置的所有的事件 和回调函数
        }
        // 原型方法 $emit(触发事件)  $on(监听事件)
        // 触发一个事件
        // $emit("selectChange", 若干参数) ...params 就表示从第二个参数后面的所有的参数
        Events.prototype.$emit = function (eventName, ...params) {
            //  去执行对应的回调函数
            this.subs[eventName] && this.subs[eventName].forEach(fn => {
                // fn(...params) // 直接执行fn函数  调用fn的对象 window
                //  如果改变函数中的this指向 
                // call  apply bind 
                // fn.call(this, ...params)  // n个参数
                // fn.apply(this, [...params]) // apply第二个参数是个数组
                fn.bind(this, ...params)() // 此时只是返回一个 改变了this指向函数 并不会执行
            });
        }
        // 监听事件触发
        // eventName (监听事件名) fn(该事件触发时 调用的回调函数)
        Events.prototype.$on = function (eventName, fn) {
            // if (this.subs[eventName]) {
            //     this.subs[eventName].push(fn) // 将函数加到数组中
            // } else {
            //     // this.subs[eventName] = []
            //     // this.subs[eventName].push(fn)
            //     this.subs[eventName] = [fn]
            //     //this.subs[eventName].push(fn)
            // }
            this.subs[eventName] = this.subs[eventName] || []
            this.subs[eventName].push(fn)
        }
        var event = new Events()  // 实例化 事件管理器
        event.$on("change", function (a, b, c) {
            // 希望 执行function函数时  里面的this 指向的是 事件管理器
            console.log(this)
            alert(a + '-' + b + '-' + c)
        })  // 先开启监听 才能 去触发事件 否则监听不到
        // console.log(event)
        function change() {
            // 触发change事件
            event.$emit("change", 1, 2, 3)
        }
```

> 这里用到了call/apply/bind方法修改函数内部的this指向

> 利用发布订阅模式可以实现当事件触发时会通知到很多人去做事情,Vue中做的事情是更新DOM

## MVVM实现-DOM复习

> 我们学习了 Object.defineProperty  和  发布订阅模式,  几乎拥有了手写一个MVVM的能力, 
>
> 但是在实现MVVM之前,我们还是复习一下 View中也就是 Dom中的含义及结构

DOM是什么?

> 文档对象模型 document

Dom的作用是什么?

>可以通过**`对象`**去操作页面元素

Dom中的对象节点都有什么类型

> 可以通过下面的一个小例子检查

```html
  <div id="app">
        <h1>众志成城,共抗疫情</h1>
        <div>
            <span style='color:red;font-weight: bold;'>老高:</span>
            <span>祝所有同学前程似锦</span>
        </div>
    </div>
    <script>
       var app = document.getElementById("app")
       console.dir(app)
    </script>
```

>通过上面的输出查看, 我们可以发现

元素类型的节点类型 nodeType 为1 文本类型为 3, document对象里面的每个内容都是**`节点`**

childNodes  是所有的节点  children指的 是所有的元素 => nodeType =1 的节点

所有的子节点都放在 childNodes 这个属性下,childNodes是伪数组 => 伪数组不具有数组方法. 有length属性

>所有标签的属性集合是什么?

attributes  => 放置了所有的属性

>分析DOM对象做什么呢? 我们前面准备的数据捕获和 发布订阅就是为了来更新DOM的

接下来我们开始手写一个MVVM示例

手写一个vuejs 的简易版  Object.defineProperty => 新增属性 .修改属性  数据代理 

发布订阅 => 发布事件  订阅事件 

Dom => 更新视图

## MVVM实现-实现Vue的构造函数和数据代理

>挑战来了,我们要手写 一个简易的**`vuejs`**, 提升我们自身的技术实力.

> 我们要实现mvvm的构造函数
>
> 构造函数 模仿vuejs 分别有 data /el 
>
> data最终被代理给当前的vm实例, 即可以通过 vm访问,也可以通过 this.$data访问

```js
 // 实现Vue的构造函数
        // options 表示构造参数的选项
        function Vue(options) {
            // 如果是字符串 就用 选择器选择 如果不是 就认为是 dom对象
            // vue中所有的属性 都以$开头
            this.$el = typeof options.el === 'string' ? document.querySelector(options.el) : options.el
            // 原来在vue中 this.$data获取数据
            this.$data = options.data || {}  // 将选项中data赋值给 this.$data
            // 下一步 要代理$data中的数据
            // this.name  等价于 this.$data.name
            // this 代理 this.$data中所有的属性  用  Object.defineProperty
            this.$proxyData() // 代理数据 把 $data中数据 用 this 代理
        }
        // 代理数据方法  目的是 this 代理所有的this.$data中的属性
        // 数据代理
        Vue.prototype.$proxyData = function () {
            // this 就是当前的vm实例
            Object.keys(this.$data).forEach(key => {
                // key 就是当掐你data中的每个属性
                Object.defineProperty(this, key, {
                    // 数据描述符 存取描述符
                    get() {
                        // 返回这个key的值
                        return this.$data[key] // 返回$data中的数据
                    },
                    set(value) {
                        // 如果 设置的值 和原来的值 一样的话  就没有 必要设置了
                        if (this.$data[key] === value) return
                        this.$data[key] = value  // 设置值给$data中的数据
                    }
                })
            })
        }
```

## MVVM实现-数据劫持Observer

> OK,接下来这一步非常关键,我们要做**`数据劫持`**, 劫持谁? 为什么要劫持?

上小节代码中, 我们可以通过 vm.name= '值' 也可以通过 vm.$data.name = '值', 那么在哪里捕捉数据的变化呢?

> 不论是 this.data 还是 this.$data 改的都是$data的数据,所以我们需要对 $data的数据进行**`劫持`**, 也就是监听它的set

数据劫持意味着 :   我们要监控MVVM中的 Model的数据层的变化

```js
  // 数据劫持   要劫持 $data的数据变化 因为需要在数据变化时  => 视图更新
        // 此方法的目的是 劫持数据的更新  在更新的时候 通知视图
        Vue.prototype.$observer = function () {
            Object.keys(this.$data).forEach(key => {
                // 先要获取每个属性的初始值 
                let value = this.$data[key] // 此时value是 初始值
                Object.defineProperty(this.$data, key, {
                    get() {
                        return value // 返回值 
                    },
                    set(newValue) {
                        if (newValue === value) return
                        value = newValue  // 设置新值
                        // 一旦进入到这个位置 表示 数据变化  => 视图变化 数据变化了 => 视图 渲染  =>发布订阅模式 来通知视图

                    }
                })
            })
        }
```

> 在构造函数中完成对数据的劫持

```js
   // 实现Vue的构造函数
        // options 表示构造参数的选项
        function Vue(options) {
            // 如果是字符串 就用 选择器选择 如果不是 就认为是 dom对象
            // vue中所有的属性 都以$开头
            this.$el = typeof options.el === 'string' ? document.querySelector(options.el) : options.el
            // 原来在vue中 this.$data获取数据
            this.$data = options.data || {}  // 将选项中data赋值给 this.$data
            // 下一步 要代理$data中的数据
            // this.name  等价于 this.$data.name
            // this 代理 this.$data中所有的属性  用  Object.defineProperty
            this.$proxyData() // 代理数据 把 $data中数据 用 this 代理
            this.$observer() // 完成数据劫持
        }
```

## MVVM实现-编译模板Compiler-设计结构

代理 :  $data中的所有数据都代理给了 this

劫持 : $data中的数据变化

> 现在我们基本实现了 实例化数据,并且完成了对数据的代理和劫持,接下来我们需要实现几个方法 
>
> 数据变化时 => 根据最新数据把模板转化成最新的对象
>
> 判断节点是否是文本节点
>
> 判断节点是否是 元素节点
>
> 判断是否是指令  v-model / v-text
>
> 处理元素节点  
>
> 处理文本节点
>
> 所以我们定义下面几个方法

```js
        // 编辑模板的总方法 需要在 构造函数时执行
        Vue.prototype.$complie = function () { }
        // 处理文本类型的节点
        Vue.prototype.$complieTextNode = function () { }
        // 处理元素类型的节点
        Vue.prototype.$complieElementNode = function () { }
        // 判断 一个节点是否是 文本节点
        Vue.prototype.$isTextNode = function () { }
        // 是否是元素节点
        Vue.prototype.$isElementNode = function () { }
        // 判断是一个属性是否是指令 判断的依据是 以v-开头
        Vue.prototype.$isDirective = function () { }
```



## MVVM实现-编译模板Compiler实现基本的框架逻辑

> 我们已经通过构造函数拿到了$el,也就是页面的dom元素,接下来我们可以实现 一下编译的基本逻辑

注意:  **`文本节点就不再有子节点了 因为文本就是最终的体现`**

   **`元素节点 一定还有子节点`**

```js
  // 编辑模板的总方法 需要在 构造函数时执行
        // 这个方法 要处理 所有的节点  递归  递归就是自身调用自身 但是请切记 递归的方法体 一定要有条件限制 否则 死循环
        // rootnode 是本地递归调用的一个起点
        Vue.prototype.$complie = function (rootnode) {
            // 拿到rootnode 先要获取rootnode的子节点
            let nodes = Array.from(rootnode.childNodes)    // 伪数组 => 真正数组
            nodes.forEach(node => {
                // 判断 当前节点类型 如果是文本节点  就不再有 子节点了
                if (this.$isTextNode(node)) {
                    //    如果当前的node是文本节点  就不需要再对此node 下的子节点进行处理了
                    // 只需要处理该节点即可
                    this.$complieTextNode(node) // 处理文本类型节点
                }
                else if (this.$isElementNode(node)) {
                    // 如果是节点是一个元素节点 表示它肯定还有下一个节点 
                    // 先处理 当前元素的内容
                    this.$complieElementNode(node) // 处理元素类型的节点
                    // 此时就要调用自身的方法 递归
                    this.$complie(node) // 调用自身的方法 传入当前node 作为下一个找寻的起点 自身调用自身 知道 所有的childNodes的长度为0
                }
            })
        }
        // 处理文本类型的节点
        Vue.prototype.$complieTextNode = function () { }
        // 处理元素类型的节点
        Vue.prototype.$complieElementNode = function () { }
        // 判断 一个节点是否是 文本节点  用nodeType === 3 
        Vue.prototype.$isTextNode = function (node) {
            return node.nodeType === 3 // true 文本节点 false 不是文本节点
        }
        // 是否是元素节点 nodeType ===1 元素节点
        Vue.prototype.$isElementNode = function (node) {
            return node.nodeType === 1 // true 元素节点 false 不是元素节点

        }
        // 判断是一个属性是否是指令 判断的依据是 以v-开头
        Vue.prototype.$isDirective = function () { }
```

>上述代码的基本逻辑就是 碰到 文本节点就用文本节点的方法处理  碰到元素节点 用元素节点的方法处理 
>
>如果碰到元素节点,就表示**`还没完`**  还需要调用下一级的查找

## MVVM实现-编译模板Compiler-处理文本节点

```js
        // 处理文本类型的节点
        Vue.prototype.$complieTextNode = function (node) {
            // 处理文本节点  把文本中的插值表达式 中的变量   替换成 $data中的值 也就是this中的值
            const text = node.textContent // 文本内容
            const reg = /\{\{(.+?)\}\}/g  // 匹配所有的 {{ 内容  }}  ? 非贪婪模式  {{ name }}  {{  age }}
            if (reg.test(text)) {
                //  如果此时能够匹配正则表达式
                // 
                const key = RegExp.$1.trim() // key是要替换的变量名
                // console.log(RegExp.$1.trim())    // 获取第一个匹配的内容
                node.textContent = text.replace(reg, this[key]) // 直接将 this中的name替换 视图中的 {{ name }}
            }
        }
```

> 提示: 实际开发时正则不需要记 但是要能看懂 

## MVVM实现-编译模板Compiler-处理元素节点

```js
        // 处理元素类型的节点
        Vue.prototype.$complieElementNode = function (node) {
            // 当处理的节点是元素标签时 此时 处理指令
            // 所有的标签的属性在 attributes
            // 解析 判断 属性是否是指令 如果是指令 处理指令  v-text v-model
            let attrs = Array.from(node.attributes)    // 伪数组 =>真数组 所有的属性
            attrs.forEach(attr => {
                // 判断当前的属性是否是指令
                if (this.$isDirective(attr.name)) {
                    // v-text  v-model
                    if (attr.name === 'v-text') {
                        //  
                        node.textContent = this[attr.value.trim()]  // 获取v-text的属性名 // 将 变量的值赋值给 div的属性
                    }
                    else if (attr.name === 'v-model') {
                        // v-model是双向绑定 绑定的是元素的value值 表单的value
                        node.value = this[attr.value.trim()]  // 此时node表示就是input
                    }
                }
            })

        }
```

## MVVM实现-数据驱动视图-发布订阅管理器

> 目前响应式数据有了, 编译模板也有了, 我们需要在数据变化的时候编译模板
>
> 之前讲了, 这一步需要 通过发布订阅来做 ,所以我们在Vue的基础上实现发布订阅

```js
        // 手写一个mvvm 简易版的vuejs
        // options就是选项 所有vue属性都带$
        function Vue (options) {
            this.subs = {} // 事件管理器
            this.$options = options  // 放置选项
           this.$el = typeof options.el === 'string' ? document.querySelector(options.el) : options.el
           // 将dom对象赋值给$el 和官方vuejs保持一致
         this.$data = options.data || {}
         //  数据代理 希望 vm能够代理 $data的数据 
         // 希望 vm.name 就是$data.name
         this.$proxyData() // 代理数据  把$data中数据 代理给vm实例
         this.$observer()  // 数据劫持  劫持 $data中的数据变化
         this.$compile(this.$el) // 模板第一次编译渲染 递归的要求 这里必须传入参数 
         // 递归是一种简单的算法 => 一般用在处理树形数据,嵌套数据 中国/北京/海淀/中关村/知春路/海淀桥/982/人
         // 递归其实就是函数自身调用自身 => 传入下一次递归的条件 => 两次递归条件一样 => 死循环了
        }
   // Vue的发布订阅管理器 $on $emit 
      //  监听事件
      Vue.prototype.$on = function (eventName, fn) {
                  //   事件名 => 回调函数  => 触发某个事件的时候 找到这个事件对应的回调函数 并且执行
        //  if(this.subs[eventName]) {
        //      this.subs[eventName].push(fn)
        //  }else {
        //      this.subs[eventName] = [fn]
        //  }
        this.subs[eventName] = this.subs[eventName] || []
        this.subs[eventName].push(fn)
      }
      // 触发事件
  Vue.prototype.$emit = function (eventName, ...params) {
       //  拿到了事件名 应该去我们的开辟的空间里面 找有没有回调函数
       if(this.subs[eventName]) {
            //   有人监听你的事件
            // 调用别人的回调函数
            this.subs[eventName].forEach(fn => {
                // 改变this指向
               //  fn(...params) // 调用该回调函数 并且传递参数
                 // 三种方式 改变回调函数里的this指向
               //   fn.apply(this, [...params]) // apply 参数 [参数列表]
              //  fn.call(this, ...params) // 若干参数
               fn.bind(this, ...params)() // bind用法 bind并不会执行函数 而是直接将函数this改变
            });
          }
      }
```

## MVVM实现-数据变化时 驱动视图变化

>现在万事俱备,只欠东风
>
>我们的数据代理,数据劫持,模板编译, 事件发布订阅统统搞定 现在只需要在数据变化时 ,通过事件发布,然后
>
>通知 数据进行编译即可

```js
        // 数据劫持
        Vue.prototype.$observer = function () {
            // 要劫持谁 ? $data
            // 遍历 $data中的所有key
            Object.keys(this.$data).forEach(key => {
               // 劫持 =>劫持数据的变化 -> 监听 data中的数据的变化 => set方法
               // obj / prop / desciptor
               let value = this.$data[key] // 重新开辟一个空间  value的空间
               Object.defineProperty(this.$data, key, {
                   // 描述 => 描述符有几种 ? 数据描述符(value,writable) 存取描述符 (get/set)
                   get () {
                       return value
                   },
                   set: (newValue) => {
                      if(newValue === value) return 
                      value = newValue
                    //   一旦进入set方法 表示 MVVM中的 M 发生了变化  data变化了
                    // MVVVM => Model =>  发布订阅模式  => 更新Dom视图
                      // 整体编译只执行一次 通过发布订阅模式来做 触发一个事件 视图层监听一个事件
                     // 触发一个事件
                     this.$emit(key) // 把属性当成事件名 触发一个事件
                   }
               }) 
            })
        }
```

>监听数据改变

```js
    // 编译模板 数据发生变化  => 模板数据更新到最新
        
       // 编译模板的一个总方法 构造函数执行时执行
        // rootnode是传入本次循环的根节点 => 找rootnode下所有的子节点 => 子节点 => 子节点=> 子节点 > 子节点 ...  找到没有子节点为止
       Vue.prototype.$compile = function (rootnode) {
         let nodes = Array.from(rootnode.childNodes)  // 是一个伪数组 将伪数组转成真数组
         nodes.forEach(node => {
            //  循环每个节点 判断节点类型 如果你是文本节点 就要用文本节点的处理方式 如果元素节点就要元素节点的处理方式
            if(this.$isTextNode(node)) {
                // 如果是文本节点
                this.$compileTextNode(node) // 处理文本节点 当前的node不再有 子节点 没有必要继续找了
            }
            if(this.$isElementNode(node)) {
                // 如果是元素节点
                this.$compileElementNode(node) // 处理元素节点
                // 如果是元素节点 下面一定还有子节点 只有文本节点才是终点
                // 递归了 => 自身调用自身
                this.$compile(node) // 传参数 保证一层一层找下去 找到 node.chidNodes的长度为0的时候 自动停止
                // 可以保证 把 $el下的所有节点都遍历一遍
            } 
         })
       }
       // 处理文本节点 nodeType =3
       Vue.prototype.$compileTextNode = function (node) {
            // console.log(node.textContent)
            // 拿到文本节点内容之后 要做什么事情 {{ name }}  => 真实的值 
            // 正则表达式 
            const text = node.textContent // 拿到文本节点的内容 要看一看 有没有插值表达式
             const reg = /\{\{(.+?)\}\}/g  // 将匹配所有的 {{ 未知内容 }}
            if (reg.test(text)) {
                // 如果能匹配 说明 此时这个文本里有插值表达式
                 // 表示 上一个匹配的正则表达式的值
                const key = RegExp.$1.trim() // name属性 => 取name的值 $1取的是第一个的key
                 node.textContent = text.replace(reg,  this[key] ) 
                  // 获取属性的值 并且替换 文本节点中的插值表达式
                this.$on(key, () => {
                    // 如果 key这个属性所代表的值发生了变化 回调函数里更新视图
                    node.textContent = text.replace(reg, this[key] )    // 把原来的带大括号的内容替换成最新值 赋值给textContent
                })
            }
       }
    
       // 处理元素节点 nodeType = 1的时候是元素节点
       Vue.prototype.$compileElementNode = function (node) {
           // 指令 v-text  v-model  => 数据变化  => 视图更新 更新数据变化 
           // v-text = '值' => innerText上  textContent
           // 拿到该node所有的属性 
          let attrs = Array.from(node.attributes) // 把所有的属性转化成数组
        // 循环每个属性  属性是否带 v- 如果带 v- 表示指令
            attrs.forEach(attr => {
               if (this.$isDirective( attr.name)) {
                //   判断指令类型
                    if(attr.name === 'v-text') {
                        // v-text的指令的含义是 v-text后面的表达的值 作用在 元素的innerText或者textContent上
                      node.textContent = this[attr.value]   // 赋值 attr.value => v-text="name"
                      this.$on(attr.value, () => {
                        node.textContent = this[attr.value]   //此时数据已经更新
                      })
                    }
                    if(attr.name === 'v-model') {
                        // 表示我要对当前节点进行双向绑定
                      node.value =  this[attr.value]   // v-model要给value赋值 并不是textContent
                      this.$on(attr.value, () => {
                        node.value = this[attr.value]   //此时数据已经更新
                      })
                    }

               } // 如果以 v-开头表示 就是指令
            })
       }
```

>然后我们写个例子来测试一把



## MVVM实现-视图变化更新数据

> 最后我们希望实现双向绑定,即视图改变时 数据同时变化

```js
       // 处理元素节点 nodeType = 1的时候是元素节点
       Vue.prototype.$compileElementNode = function (node) {
           // 指令 v-text  v-model  => 数据变化  => 视图更新 更新数据变化 
           // v-text = '值' => innerText上  textContent
           // 拿到该node所有的属性 
          let attrs = Array.from(node.attributes) // 把所有的属性转化成数组
        // 循环每个属性  属性是否带 v- 如果带 v- 表示指令
            attrs.forEach(attr => {
               if (this.$isDirective( attr.name)) {
                //   判断指令类型
                    if(attr.name === 'v-text') {
                        // v-text的指令的含义是 v-text后面的表达的值 作用在 元素的innerText或者textContent上
                      node.textContent = this[attr.value]   // 赋值 attr.value => v-text="name"
                      this.$on(attr.value, () => {
                        node.textContent = this[attr.value]   //此时数据已经更新
                      })
                    }
                    if(attr.name === 'v-model') {
                        // 表示我要对当前节点进行双向绑定
                      node.value =  this[attr.value]   // v-model要给value赋值 并不是textContent
                      this.$on(attr.value, () => {
                        node.value = this[attr.value]   //此时数据已经更新
                      })
                      node.oninput = () => {
                        //   需要把当前最新的节点的值 赋值给 本身的数据
                        this[attr.value] =  node.value  // 视图 发生 => 数据发生变化
                      }  // 如果一个元素绑定了v-model指令 应该监听这个元素的值改变事件
                    }

               } // 如果以 v-开头表示 就是指令
            })
       }
```

## 总结

介绍MVVM

数据  =>  视图

视图  =>  视图

Object.defineProperty   代理数据  劫持数据

this.$data  =>  this

劫持数据 劫持  this.$data数据的修改 =>  因为要在数据变化时 实现 视图的更新

Vue的响应式数据是怎么实现的? 

Object.defineProperty  => 劫持了数据的set  => 发布订阅模式  => 通知对应的视图进行更新

Diff 算法 虚拟DOM   => 面试中 十有八九会问倒

