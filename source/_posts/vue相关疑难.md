---
title: Vue部分相关的面试题
top: false
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

# Vue部分相关的面试题

## 如何在组件中监听Vuex的数据变化

> 分析:   此题考查Vuex的应用及 Vue内部的监听数据变化的机制  

>**`解答`**:  首先确定 Vuex是为了解决什么问题而出现的 ?  Vuex是为了解决组件间状态共享而出现的一个框架.
>
>其中有几个要素 是组成Vuex的关键,  state(状态)  mutations  actions  ,
>
>state 表示 需要共享的状态数据
>
>mutations  表示 更改 state的方法集合  只能是同步更新 不能写ajax等异步请求
>
>actions  如果需要做异步请求  可以在actions中发起 然后提交给 mutations mutation再做同步更新

也就是 state 负责管理状态 ,  mutation负责同步更新状态 action负责 异步获取数据 同提交给mutation

> 所以 组件监听Vuex数据变化 就是 监听 Vuex中state的变化, 

**`第一种方案`**  我们可以在组件中通过组件的 watch方法来做, 因为组件可以将state数据映射到 组件的计算属性上,

然后 监听 映射的计算属性即可 代码如下

```js
// vuex中的state数据
  state: {
    count: 0
  },
     
//  A组件中映射 state数据到计算属性
  computed: {
    ...mapState(['count'])
  }
// A组件监听 count计算属性的变化
   watch: {
    count () {
      // 用本身的数据进行一下计数
      this.changeCount++
    }
  }
```

![image-20200217103409496](image-20200217103409496.png)

**`第二种方案`**   vuex中store对象本身提供了**`watch`**函数 ,可以利用该函数进行监听

- **watch(fn: Function, callback: Function, options?: Object): Function**

响应式地侦听 `fn` 的返回值，当值改变时调用回调函数。`fn` 接收 store 的 state 作为第一个参数，其 getter 作为第二个参数。最后接收一个可选的对象参数表示 Vue 的 [`vm.$watch`](https://cn.vuejs.org/v2/api/#vm-watch) 方法的参数。

代码

```js
  created () {
    this.$store.watch((state, getters) => {
      return state.count
    }, () => {
      this.changeCount++
    })
  }
```

>以上代码 均在示例有体现



vue-cli项目 中router  

history模式  /地址  => 一定会引起向服务端发请求 ,需要服务器配合,需要服务器做配合, 无论地址怎么变化, 返回都是一个页面,这样页面就不会强制刷新, 开发时  用的脚手架本身支持, 如果上线, 需要ngix 服务器配置,单页应用 无论地址怎么变化 

hash模式    #/地址  => #的变化不会引起 页面的刷新





>  脚手架中 可能会频繁遇到环境变量

dev环境    测试环境   预发布环境  生产环境 

每个环境的地址 和域名可能不一样,如果你的项目需要上线,  不需要手动的 根据环境 来切换参数

把一些需要根据环境变化的参数 变成环境变量, 运维会在不同的环境中将 不同的环境变量写入, 此时你的代码 编译之后就是带当时的环境变量的了

## Vue单页面和多页面的混合使用

> 分析: 首先分析,单页面应用和 多页面应用的根本区别 
>
> **`解答`**:  单页面即所有的模块统统置于一个html文件之上,切换模块,不会重新对html文件和资源进行再次请求,服务器不会对我们**`换页面`**的动作 产生任何反应, 所以我们感觉不到任何的刷新动作,速度和体验很畅快
>
> 多页面应用 即多个html页面 共同的使用, 可以认为一个页面即一个模块,但是不排除 多个单页应用混合到一起的组合情况 ,  多页面切换一定会造成 页面资源的重新加载, 这也就意味着 如果 多页面之间切换,一定会造成很数据的**`重置`**
>
> ​	所以在 Vue的单页面 和多页面混合使用的时候,需要注意, 如果 不论是单页  跳到多页 ,还是多页跳到单页,都会造成页面内容的重置. 多页面我们不用关心,因为重置本就是多页面的特性,但是单页不一样, 很多变量或者数据 可能会因为 重置归零或者重置,所以我们应该 重点检查 单页每个页面的业务 在刷新页面之后, 能否保证业务的连贯性,  这些都可以通过**`导航守卫`**来进行处理, 也就是一进入单页的路由,就检查业务的连贯性.

## vuex怎么合理规范管理数据,及mutations和actions区别

> 解析: 此题考查 vuex中数据的管理和数据结构的设计,还有mutations 和actions的区别

> **`解答`** : 首先要明确一个特别重要的原则, 就是 不是所有的数据都要放在vuex中, 因为vuex有一句名言:假如你并不知道为什么要使用vuex,那就不要使用它 !
>
>  那么什么样式的数据需要放在vuex中呢 ? 首先这个数据肯定要被多个组件频繁用到, 如果只是被一个组件 用到, 那完全没有任何必要为了使用vuex和使用vuex

举例:  一个网站用户的昵称,账号,资料,像这种系统级别的信息 随时可能在业务中展示,使用, 如果在组件中存储, 那么要获取N次, 所以**`系统级别的数据`**是需要放置在vuex中的, 那么系统级别数据 也不能随意的放置,为了让数据看着更有层级结构感,可以按照像下面这样设计,  

```json
{
    // 系统消息
    system: {
        user: {},
        setting: {}
    }
}
```

> 上面这种结构,一看 便知道我们应该哪里获取系统数据即 设置数据

如果有些业务数据,也需要共享,最好按照模块的具体业务含义分类 , 比如下面

```json
{
    // 系统消息
    system: {
        user: {},
        setting: {}
    },
    product: {
        productList: [], // 商品信息列表
        productOrders: [] // 商品订单啊列表
    }
}
```

> 如上图代码所示,我们很清晰的能够分清楚 每个模块的数据,这样不会导致数据管理的混乱

### mutations和 actions 的区别

> 不同于redux只有一个action, vuex单独拎出了一个mutations,  它认为 更新数据必须是同步的, 也就是只要调用了 提交数据方法, 就会得到一个当前的**`状态快照`**,提交一个mutation就会得到一个**`快照`**
>
> 那么如果我们想做 异步请求,怎么做?  这里 vuex提供了专门做异步请求的模块,action, 当然action中也可以做同步操作, 只不过 分工更加明确, 所有的数据操作 不论是同步还是异步 都可以在action中完成, 
>
> mutation只负责接收状态, 同步完成 **`数据快照`**
>
> 所以可以认为 
>
> state => 负责存储状态 
>
> mutations => 负责同步更新状态
>
> actions => 负责获取 处理数据, 提交到mutation进行状态更新

## vuex模块化管理,使用的时候有注意事项

> 分析: 此题考查 当vuex维护的数据越来越复杂的时候, 模块化的解决方案
>
> **`解析`**:使用单一的状态树，应用的所有状态都会**`集中在一个比较大的对象`**上面，随着项目需求的不断增加，状态树也会变得越来越臃肿，增加了状态树维护的复杂度,而且代码变得沉长；因此我们需要**`modules(模块化)`**来为我们的状态树**`分隔`**成不同的模块，每个模块拥有自己的state，getters，mutations，actions；而且允许每个module里面嵌套子module；如下：
>
> ```
>  store
>     ├── index.js          # 我们组装模块并导出 store 的地方
>     ├── actions.js        # 根级别的 action
>     ├── mutations.js      # 根级别的 mutation
>     ├── state.js          # 根级别的 state
>     └── modules
>         ├── module1.js   # 模块1的state树
>         └── module2.js   # 模块2的state树
> 
> ```

上面的设计中, 每个vuex子模块都可以定义 state/mutations/actions

> 需要注意的是  我们原来使用**`vuex辅助函数`**  mapMutations/mapActions  引入的是 全局的的mutations 和actions , 并且我们vuex子模块  也就是module1,module2 ... 这些模块的aciton /mutation 也注册了全局, 
>
> 也就是如果 module1 中定义了 updateUser , module2中也定义了 updateUser, 此时, mutation就冲突了
>
> 如果重名,就报错了.....
>
> 如果不想冲突, 各个模块管理自己的action 和 mutation ,需要 给我们的子模块一个 属性 **`namespaced: true`**

那么 组件中怎么使用子模块的action 和 mutations

```js
// 你可以将模块的空间名称字符串作为第一个参数传递给上述函数，这样所有绑定都会自动将该模块作为上下文
methods : {
    ...mapMutations('A', ['updateUser'])  // 引用A模块的mptations方法 
}
```

> 此题具体考查 Vuex虽然是一个公共状态, 但是公共状态还可以切分成若干个子状态模块, 也就是moudels,
>
> 解决当我们的状态树过于庞大和复杂时的一种解决方案.  但是笔者认为, 一旦用了vuex, 几乎 就认定该项目是较为复杂的

[参考文档](https://vuex.vuejs.org/zh/guide/modules.html)

## 封装Vue组件的步骤

> 分析: 本题考查 对于Vue组件化开发的熟练程度
>
> **`解析`**: 首先明确 组件是本质是什么?  
>
> 组件就是一个单位的HTML结构 + 数据逻辑 + 样式的 操作单元 
>
> Vue的组件 继承自Vue对象, Vue对象中的所有的属性和方法,组件可自动继承. 
>
> 组件的要素  template  =>  作为页面的模板结构 
>
> script  => 作为数据及逻辑的部分
>
> style  => 作为该组件部分的样式部分

要封装一个组件,首先要明确该组件要做的具体业务和需求,  什么样的体验特征, 完成什么样的交互, 处理什么样的数据

> 明确上述要求之后, 着手模板的结构设计及搭建,也就是 常说的html结构部分,  先完成 静态的html结构
>
> 结构完成, 着手数据结构的设计及开发, 数据结构一般存储于组件的data属性 或者 vuex 状态共享的数据结构
>
> 数据设计完成/ 结构完成  接下来 完成数据和模块的结合 , 利用vuejs中指令和 插值表达式的特性 将静态结构 **`动态化`**
>
> 展现的部分完成, 接下来完成**`交互部分`**,即利用 组件的生命周期的钩子函数 和 事件驱动 来完成 逻辑及数据的处理与操作

最后组件完成,进行测试及使用

常用的组件属性 => data/ methods/filters/ components/watch/created/mounted/beforeDestroy/computed/props

常用组件指令: v-if/v-on/v-bind/v-model/v-text/v-once

## Vue中的data是以函数的形式还是对象的形式表示

> 分析: 此题考查 data的存在形式

> **`解析`**: 我们在初步学习Vue实例化的时候写的代码时这个样子
>
> ```js
> new Vue({
>     el: '#app',
>     data: {
>         name: 'hello world'
>     }
> })
> ```
>
> 上面代码中的data 是一个对象, 但是我们在开发组件的时候要求data必须是一个带返回值的函数

```js
export default {
    data () {
        return {
            name: '张三'
        }
    }
}
```

> 为什么组件要求必须是带返回值的函数?  因为 我们的组件在实例化的时候, 会直接将data数据作用在视图上, 
>
> 对组件实例化, 会导致我们组件的data数据进行共享, 好比  现在有两辆新车, 你一踩油门, 不光你的车往前走,另辆车也和你一样往前冲!   这显然不符合我们的程序设计要求, 我们希望组件内部的数据是相互独立的,且互不响应,所以 采用   **`return {}`**  每个组件实例都返回新对象实例的形式,保证每个组件实例的唯一性

## 使用Proxy代理跨域

>分析: 本题考查如何解决跨域问题
>
>解析: 解决跨域问题的方式有几种,一种是服务端设置 all-control-origin * , 但这种方式依赖服务端的设置,在前后分离的场景下 ,不太方便
>
>还有一种jsonp形式, 可以利用script标签 的特性解决同源策略带来的跨域问题,但这是这种方案对于请求的类型有限制,只能get/post
>
>还有一种就可以在开发环境(本地调试)期间,进行代理, 说白了 就是通过 在本地通过nodejs 启动一个微型服务, 
>
>然后我们先请求我们的微型服务, 微型服务是服务端, 服务端**`代我们`**去请求我们想要的跨域地址, 因为服务端是不受**`同源策略`**的限制的, 具体到开发中,打包工具webpack集成了代理的功能,可以采用配置webpack的方式进行解决, 但是这种仅限于 本地开发期间, 等项目上线时,还是需要另择代理 ngix

以下为webpack配置代理的配置 

```json
 // 代理设置 
proxy: {
    '/api': {
        target: 'http://www.baidu.com/',
        changeOrigin: true,
        pathRewrite: {
            '^/api': ''
        }
    }
}
```

**`target`**：接口域名；

 **`changeOrigin`**： 如果设置为`true`,那么本地会虚拟一个服务端接收你的请求并代你发送该请求；

 **`pathRewrite`**：如果接口中是没有api的，那就直接置空（如上）如果接口中有api，就需要写成{‘^/api’:‘/api’}



真实访问地址  http://www.baidu.com/test 

/api/test  =>  /api 就是 表示  http://www.baidu.com  =>webpack 后台 发出的请求(http://www.baidu.com/test )=>  返回结果  => 前端



反向代理  =>   前端   => 后台 不让你访问 (跨域)

   前端 => webpack后台 (代理)(仅限于本地开发模式)     =>后台

## Vue中的watch如何深度监听某个对象

> 分析: 此题考查Vue的选项watch的应用方式
>
> 解析:  watch最基本的用法是 
>
> ```js
> export default {
>     data () {
>         return {
>             name: '张三'
>         }
>     },
>     watch: {
>         name (newValue, oldValue) {
>             
>         }
>     }
> }
> ```
>
> 上面代码中: 有个原则监听谁,写谁的名字,然后是对应的执行函数, 第一个参数为最新的改变值,第二个值为上一次改变的值, 注意: 除了监听 data,也可以监听**`计算属性`** 或者一个 函数的计算结果
>
> 那怎么深度监听对象 ,两种方式
>
> 1. 字符串嵌套方式
>
> ```js
> export default {
>     data () {
>         return {
>            a: {
>                b: {
>                    c :'张三'
>                }
>            }
>         }
>     },
>     watch: {
>         "a.b.c": function (newValue, oldValue) {
>             
>         }
>     }
> }
> ```
>
> 2. 启用深度监听方式
>
>    ```js
>    export default {
>        data () {
>            return {
>               a: {
>                   b: {
>                       c :'张三'
>                   }
>               }
>            }
>        },
>        watch: {
>            a: {
>                deep: true // deep 为true  意味着开启了深度监听 a对象里面任何数据变化都会触发handler函数,
>                handler(){
>                   // handler是一个固定写法
>                }
>            }
>        }
>    }
>    ```

## Vue keep-alive使用

> 分析: 此题考查Vue中组件缓存的使用 
>
> 解析:  keep-alive是 Vue提供的一个全局组件, Vue的组件是有销毁机制的,比如条件渲染, 路由跳转时 组件都会经历**`销毁`**, 再次回到页面时,又会回到 **`重生`**, 这一过程保证了生命周期钩子函数各个过程都会在这一生命周期中执行.
>
> 但是,我们辛辛苦苦获取的数据 滑动的页面 会因为组件的销毁 重生 而 **`归零`**,这影响了交互的体验, 所以 keep-alvie出现了, 可以帮助我们缓存想要缓存的组件实例, 只用用keep-alive **`包裹`**你想要缓存的组件实例, 这个时候, 组件创建之后,就不会再进行 销毁, 组件数据和状态得以保存
>
> 但是,没有了销毁,也就失去了重生的环节, 我们失去了 原有的钩子函数, 所以keep-alive包裹的组件 都获取了另外两个事件 
>
> 唤醒 activited 重新唤醒休眠组件实例时 执行
>
> 休眠 unactiived  组件实例进入休眠状态时执行

但是我们不能缓存所有的组件实例, 如果是针对 组件容器 router-view 这个组件进行的缓存, 一般的策略是在路由的元信息 meta对象中设置是否缓存的标记,  然后根据标记决定是否进行缓存

```js
  <div id="app">
    <keep-alive>
      <!-- 里面是当需要缓存时 -->
      <router-view  v-if="$route.meta.isAlive" />
    </keep-alive>
     <!-- 外面是不需要缓存时 -->
    <router-view  v-if="!$route.meta.isAlive" />
  </div>
```

还有需要注意的问题是:  被缓存的组件中如果还有子组件, 那么子组件也会一并拥有 激活和唤醒事件,并且这些事件会在同时执行

## vue的双向数据绑定原理是什么

> 分析 :此题考查 Vue的MVVM原理
>
> **`解答`**:  Vue的双向绑定原理其实就是MVVM的实现原理, Vuejs官网已经说明, 实际就是通过 Object.defineProperty方法 完成了对于Vue实例中数据的 **`劫持`**, 通过对于 data中数据 set的监听,
>
> 然后通过**`观察者模式`**, 通知 对应的绑定节点 进行节点数据更新, 完成数据驱动视图的更新

我们实现的MVVM是一个简易版本

我们并没有做虚拟DOM, 虚拟DOM的问题

虚拟DOM,并不是真正的DOM, 数据驱动视图, 数据变化  =>  数据 切换成 虚拟DOM, 

新的虚拟DOM 会和 旧的虚拟DOM 进行 diff比较算法, 比较 得出 需要更新的结果, 反映到dom上

diff比较 =>  其实就是 用一种时间时间复杂度比较低的方式去更新

新节点    和 旧节点 完成 比较 ,时间复杂度 O(n^n^n), 

diff 比较算法 时间复杂度 是 O(n)  =>   diff 比较算法 只比较同级的节点, 如果同级节点不一致, 就不再比较子级了,

性能比较高的算法.

> [虚拟dom和diff比较](https://www.jianshu.com/p/af0b398602bc)    此问题 仅仅存于面试

Vue/React  不推荐 移动节点, 不推荐改变节点的名称, 

旧节点

> 同理, 通过对于节点的表单值改变事件的监听,  执行对于数据的修改

简单概述 : 通过Object.defineProperty 完成对于数据的劫持, 通过观察者模式, 完成对于节点的数据更新



## 页面刷新了之后vuex中的数据消失怎么解决

>分析:此题考查 如果将vuex数据进行本地持久化
>
>**`解析`**: vuex数据位于内存, 页面的刷新重置会导致数据的**`归零`**,也就是所谓的消失,  本地持久化可以解决这个问题.本地持久化用到的技术也就是 本次存储 sesstionStorage 或者 localStorage ,  
>
>如果需要保持的更长久 ,浏览器关掉 再打开依然存有数据,需要使用后者 
>
>实施方案:  state的持久化 也就是分别需要在 state数据初始化 /更新 的时候 进行读取和设置本地存储操作
>
>代码如下 
>
>```js
>export default new Vuex.store({
>    state: {
>        user: localStorge.getItem('user')  // 初始化时读取 本地存储
>    },
>    mutations: {
>        updateUser (state, payload) {
>            state.user = payload.user
>            localStoregae.setItem('user',payload.user) // 数据更新时 设置本地存储
>        }
>    }
>})
>```
>
>

## vue做服务端渲染

> 分析: 为什么要做服务端渲染, 首先要明白 服务端渲染解决什么问题
>
> **`解析`**: vuejs 官网说的很明白, 要做服务端渲染首先必须是有对应的需求,即对 实时到达时间(页面访问时间)的绝对需求.  如果只是简单的一个管理系统, 区区几百毫秒的优化 显得十分小题大做.
>
> 服务端渲染这里 有一个成熟优秀的框架 nuxt.js , 正如next.js对于react,nuxt是vue服务端渲染的优秀解决方案

我们几乎可以像原来一样的去开发组件,页面, nuxt帮我们集成了原有项目的插件,模块, 提供了预加载数据事件

asyncData, 在客户端实现对于服务端内容的**`完美接管`**

只不过 这里我们的路由开发方式,需要遵循nuxt.js制定的特殊规范,比如,动态 路由需要 **`下划线前缀`**, 嵌套路由需要

同名组件的文件下下建立组件,并在 同名组件中 加入 nuxt-child 作为 容器  ....

> nuxt的出现可以让渲染内容完全服务端化,解决seo不够友好, 首屏渲染速度不够迅速的问题,
>
> 但是这里需要注意: 并不是所有页面都需要服务端渲染, 因为服务端渲染比重多大 对于服务器的访问处理能力 要求也会急剧增大

[nuxt.js官网](https://zh.nuxtjs.org/)

## 双向数据绑定和vuex冲突解决方案

> 分析: 此题考查 当Vuex数据想要进行逆向操作,也就是 双向数据流向的解决方案
>
> **`解析`**:   vuex的数据对于组件来说,默认是不可改的, 但是如果我们就是想改, 可以利用 computed计算属性的另一个方法 , 我们知道计算属性 默认是数据的getter实现, 但是我们可以采用 对于 计算属性 同时get/set的实现,
>
> 双向数据流 中 当对 计算属性设置时 ,就可以通过 store对象进行再次的mutations提交 
>
> 具体代码如下
>
> ```js
> import Vue from 'vue'
> import Vuex from 'vuex'
> 
> Vue.use(Vuex)
> 
> export default new Vuex.Store({
> state: {
>  count: 0,
>  value: '' // 定义value数据 作为vuex状态数据
> },
> mutations: {
>  addCount (state) {
>    state.count++
>  },
>    // 定义mutations方法 作为 提交mutations的方法
>  updateValue (state, payload) {
>    state.value = payload.value
>  }
> },
> actions: {
> },
> modules: {
> }
> })
> 
> ```
>
> ```vue
> <template>
> <div>
>    <div>vuex的双向数据流</div>
>    <input type="text" v-model="value">
>    <div>Vuex数据属性: {{value }}</div>
> </div>
> </template>
> 
> <script>
> import { mapMutations } from 'vuex'
> export default {
> methods: {
>  ...mapMutations(['updateValue'])
> },
>     // 计算属性的get/set
> computed: {
>  value: {
>    get () {
>        // 获取state公共数据
>      return this.$store.state.value
>    },
>     // 通过对 计算属性的set监听 将 数据提交mutations
>      // 当input中数据变化时 就会调用set中的方法  value就是最新值
>    set (value) {
>      this.updateValue({ value: value })  // 在set中提交mutations
>    }
>  }
> }
> }
> </script>
> 
> <style>
> 
> </style>
> 
> ```

 

## vue-router传参

> 分析:考查vue-router的传值方式
>
> **`解析`**  vue-router 传值 可以通过 地址传值
>
> 最简单的就是url传值, url传值又两种, params 和 query参数传值
>
> params传值 是指的动态路由传值 
>
> ```vue
> {  path: '/user/:id' }  // 定义一个路由参数
> <router-link to="/user/123"></router-link>  // 传值
> this.$route.params.id   // 取值
> 
> ```
>
> query传值,指通过?后面的拼接参数传值
>
> ```vue
> 
> <router-link to="/user?id=123"></router-link>  // 传值
> this.$route.query.id   // 取值
> ```

## 前端鉴权一般思路

>分析: 考查前后分离的鉴权思路

**`解析`**: 首先要明白 为什么要在前端鉴权? 因为传统项目都是在后端鉴权, 然后通过进行拦截 跳转 对应操作

因为 我们做的并不是传统的项目,而是前后分离项目,也就是前端项目和后端服务进行了**`剥离`**, 后端没有办法用session来存储你任意一个前端项目域名下的身份信息, 所以jwt 鉴权模式应运而生. 

​    也就是后端不再提供会话的身份存储,而是通过一个鉴权接口将用户的身份,登录时间,请求端口,协议头..等等信息 组装成一个加密的串 返给前端请求,  前端拿到了这个串,就可以认为自己登录成功

那么这个**`加密串`**就成了 前端用户是否登录的成功标志, 这就是我们的token , 那么在接下来的接口请求中,我们几乎都要携带这个加密串,因为它是**`唯一`**能**`证明我们身份`**的信息.

为了方便,我们会一般在请求工具 axios(举例)的拦截器中**`统一注入token`**, 减少代码的重复

token 同时具有时效性,我们也需要在此时对token过期进行处理,一旦出现过期的请求码, 就需要进行 换取新token 或者重新登录的解决方案

除此之外,我们还需要依据**`有无加密串`** 在前端对于某些页面的访问进行限制, 这个会用到我们的Vue-Router中的导航守卫.