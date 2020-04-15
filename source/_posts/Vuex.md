---
title: Vuex
top: false
cover: false
toc: true
mathjax: true
date: 2020-04-7 01:01:56
password:
summary: 
tags:
- Vue
categories:
- 前端
---

# Vuex

## 安装

`npm install vues --save`

## 导入

`import Vuex from 'vuex'`

`Vue.use(Vuex)`

## 创建store对象

```js
const store = new Vuex.store({
	// state 中存放的就是全局共享的数0据
    state: {
    	count: 0
    }
}
```

## 将store对象挂载到 vue 实例中

```js
new Veu({
	el: '#app',
    render: h => h(app),
    router,
    //将创建的共享数据对象, 挂载到 Vue 实例中
    //所有的组件, 就可以直接从 store 中获取全局的数据了
    store
})
```

## 创建项目

> 命令行输入 `vue ui`
>
> 选择路径
>
> 点击创建 
>
> project folder 输入项目名称
>
> package manageer 选择包管理工具 `npm`
>
> git repository 输入首次提交git的信息
>
> 点击下一步
>
> 选择手动选择依赖包 `Manual`
>
> 点击下一步
>
> 选择 `babel -- router -- linter/formatter --use config files`
>
> 点击下一步
>
> 选择lint on save , 右侧下拉选择standard config
>
> 点击 create
>
> 是否存为预设

## 组件中访问 State 中数据的方式

第一种方式

> `this.$store.state.数据名称`

第二种方式

> ```js
> // 1. 从 vuex 中按需导入 mapState 函数
> import { mapState } from 'vuex'
> ```
>
> 通过导入的 mapState 函数, 将当前组件需要的全局数据, 映射为当前组件的computed 计算属性
>
> ```js
> // 2. 将全局数据, 映射为当前组件的计算属性
> computed: {
> 	...mapState(['count'])
> }
> ```
>
> 

## 组件中变更 store 中的数据

> 只能通过mutation 变更 store 数据 , 不可以直接操作 store 中的数据
>
> 通过这种方式虽然操作起来稍微繁琐一些, 但是可以集中监控所有的数据变化
>
> ```
> // 定义 Mutation
> const store = new Veux.Store({
> 	state: {
> 		count: 0
> 	},
> 	mutations: {
> 		add(state) {
> 			// 变更状态
> 			state.count++
> 		}
> 	}
> })
> ```
>
> ```js
> // 触发 mutation
> methods: {
> 	handle () {
>     	// 触发 mutations 的第一种方式
>         this.$store.commit('add')
>     }
> }
> ```
> 
> 



## 调用 mutation 时传递参数

> ```js
> // 定义 mutation
> const store = new Vuex.Store({
> state: {
>   	count: 0
>   },
>   mutations: {
>   	addN(state, step) {
>       	// 变更状态
>           state.count += step
>       }
>   }
> })
> ```
> ```js
> 
> // 触发 mutation
> methods: {
> handle2() {
>   	// 调用 commit 函数,
>       // 触发 mutations 时携带参数
>       this.$store.commit('addN',3)  // commit 的作用就是调用某个 mutation 函数
>   }
> }
> ```



## 调用 mutations 的第二种方式-- mapMutations

> ```js
> // 从 vuex 中按需导入 mapMutations 函数
> import { mapMutations } from 'vuex'
> ```
>
> 
>
> ```js
> // 将指定的 mutations 函数, 映射为当前组件的 methods 函数
> methods: {
> 	...mapMutations(['add', 'addN'])
> }
> ```
>
> 

## Action

> mutation 不支持异步操作 ,  必须通过 action 用于处理异步任务, 但是在 action 中还是要通过触发 mutation 的方式间接变更数据, 没有直接修改 state 数据的权限
>
> ```js
> // 定义 action
> const store = new Vuex.Store({
> 	// ...省略一下其他代码
>     mutations: {
>     	add(state) {
>         	state.count++
>         }
>     },
>     actions: {
>     	addAsunc(context) {
>         	setTimeout (() => {
>             	context.commit('add')
>             },1000)
>         }
>     }
> })
> ```
>
> 
>
> ```js
> // 触发 action
> methods: {
> 	handle() {
>     	// 触发 actions 的第一种方式
>         this.$store.dispatch('addAsync') // 这里的dispatch 函数, 专门用来触发 action
>     }
> }
> ```
>
> 

## 触发 Action 异步任务时携带参数

> ```js
> // 定义 action
> const store = new Vuex.Store({
> 	// ...省略一下其他代码
>     metations: {
>     	addN(state, step) {
>         	state.count += step
>         }
>     },
>     actions: {
>     	addNAsync(context, step) {
>         	setTimeout(() => {
>             	context,commit('addN', step)
>             },1000)
>         }
>     }
> })
> ```
>
> 
>
> ```js
> // 触发 action
> methods: {
> 	handle () {
>     	// 调用 dispatch 函数,
>         // 触发 actions 时携带参数
>         this.$store.dispatch('addNAsync', 5)
>     }
> }
> ```
>
> 

## 触发 Action 异步任务的另外一种方式

> ```js
> // 1. 从 vuex 中按需导入 mapActions 函数
> import { mapActions } from 'vuex'
> ```
>
> 
>
> ```js
> // 2. 将指定的 actions 函数, 因设为当前组件的 methods 函数
> method: {
> 	...mapActions(['addAsync', 'addNAsync']) // 映射后就相当于组件自己的方法, 可以直接使用
> }
> ```
>
> 

## Getter

> getter 用于对 store 中的数据进行加工处理形成新的数据
>
> > getter 可以对 store 中已有的数据加工处理之后形成新的数据, 类似于 Vue 的计算属性
> >
> > store 中数据发生变化, getter的数据也会跟着变化
>
> ```js
> // 定义 getter
> const store = new Vuex.Store({
> 	state: {
>     	count: 0 
>     },
>     getters: {
>     	showNum: state => {
>         	return '当前最新的数量是[' + state.count +']'
>         }
>     }
> })
> ```
>
> ```js
> // 使用方式第一种
> this.$store.getters.showNum
> ```
>
> ```js
> // 使用方式第二种
> import { mapGetters } from 'vuex'
> 
> computed: {
> 	...mapGetters(['showNum'])
> }
> ```
>
> 