---
title: Vue-router
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
# Vue-router

## 路由的概念与原理

> 路由的本质就是对应关系

### 后端路由

> 概念: 根据不同的URL请求, 返回不同的内容
>
> 本质: URL 请求地址与服务器资源之间的对应关系

### SPA ( Single Page Application)

> 后端渲染 会造成页面的频繁刷新
>
> Ajax前端渲染 提高性能, 但是不支持浏览器的前进后退
>
> SPA 单页面应用程序: 整个网站只有一个页面, 内容变化通过Ajax实现, 同时支持浏览器前进后退操作
>
> SPA实现原理之一: 基于URL地址的`hash(锚链接)` (hash的变化会导致浏览器记录访问历史变化, 但是hash的变化不会触发新的URL请求)
>
> 实现SPA过程中, 最核心的技术点就是前端路由

### 前端路由

> 概念: 根据不同的`用户事件`, 显示不同的页面内容
>
> 本质: `用户事件`与`事件处理函数`之间的对应关系

####  简易前端路由

```js
// 监听 window 的 onhashchange 事件, 根据获取到的最新的 hash 值, 切换要显示的组件的名称
window.onhashchange = function(){
	//通过 location.hash 获取到最新的 hash 值
    location.hash.slice(1)// 去掉第一个字符 #
}
```

#### Vue Router

##### 介绍

> Vue.js 官方的`路由管理器`
>
> 它和Vue.js 的核心深度集成

> Vue Router 支持的功能有:
>
> > HTML5历史模式或hash模式
> >
> > 嵌套路由
> >
> > 路由参数
> >
> > 编程式路由
> >
> > 命名路由

##### 使用步骤

> **引入相关的库文件**
>
> > 导入vue文件 , 为全局window 对象挂载 Vue 构造函数
> >
> > `<script src=""></script>`
> >
> > 导入 vue-router 文件, 为全局 window 对象挂载 VueRouter 构造函数
>
> **添加路由连接**
>
> > router-link 是 vue 中提供的标签, 默认会被渲染为 a 标签
> >
> > to 属性默认会被渲染为 href属性
> >
> > to 属性的值默认会被渲染为 # 开头的hash 地址
> >
> > `<router-link to="/user">User</router-link`
>
> **添加路由填充位**
>
> > 路由填充位(也叫`路由占位符`)
> >
> > 将来通过路由规则匹配到的组件, 将会被渲染到 router-view 所在的位置
> >
> > `<router-view></router-view>`
>
> **定义路由组件**
>
> ```
> const User = {
> 	template: '<div>User</div>'
> }
> ```
>
> 
>
> **配置路由规则并创建路由实例**
>
> ```
> // 创建路由实例对象
> var router = new VueRouter({
> 	// routers 是路由规则数组
> 	routes: [
> 	// 每个路由规则都是一个配置对象. 至少包含 path 和 component 两个属性:
> 	// path 表示当前路由规则匹配的 hash 地址
> 	// component 表示当前路由规则对应要展示的组件
> 	{path: '/user', component: User}
> 	]
> })
> ```
>
> 
>
> **把路由挂载到Vue 根实例中** 
>
> ```
> new Vue ({
> 	el: '#app',
> 	// 为了能够让路由规则生效, 必须把路由对象挂载到 vue 实例对象上
> 	router: router //把创建的实例对象赋值给 Vue 实例的属性router , 也可以直接简写成一个 router
> })
> ```
>
> 

##### 路由重定向

> 访问 地址 A 的时候 , 强制跳转到 B   -- redirect
>
> ```
> var router = new VueRouter({
> 	routes:[
> 		{path: '/', redirect: '/user'},
> 		{path: '/', component: User}
> 	]
> })
> ```
>
> 

##### 嵌套路由

> 父级路由连接显示的模板内容中又有子级路由连接, 点击子路由连接显示子级模板内容
>
> > 先在父路由组件中添加子路由连接和容器
> >
> > 然后定义子路由组件
> >
> > 最后将子路由组件添加到父路由规则的 children 属性中
>
> ```
> 
> const User = {
> 	template: `<div>
> 		<h1>User 组件</h1>
> 		<hr/>
> 		<!-- 子路由连接 -->
> 		<router-link to = "/user/tab1">tab1</router-link>
> 		<router-link to = "/user/tab2">tab2</router-link>
> 		<!-- 子路由占位符 -->
> 		<router-view/>
> 	</div>`
> }
> ```
>
> ```
> const Tab1= {
> 	template: '<h3>Tab1子组件</h3>'
> }
> const Tab2= {
> 	template: '<h3>Tab2子组件</h3>'
> }
> ```
>
> ```
> const router = new VueRouter({
> 	routes:[
> 		{path: '/', redirect: '/user'},
> 		// children 数组表示子路由规则
> 		{path: '/', component: User, children:[
> 		{path:'user/tab1',component: Tab1},
> 		{path:'user/tab2', component: Tab2}
> 		]}
> 	]
> })
> ```
>
> 

##### 动态路由匹配

> 如果路由连接一部分相同一部分是变化的, 我们可以把变化的部分设置成路由参数, 
>
> 多个路由共用一个规则,  减少路由规则定义的数量
>
> 设置路由规则:
>
> ```
> var router = new VueRouter({
> 	routes: [
> 		//动态路径参数, 以冒号开头
> 		{path: '/user/:id', component: User}
> 	]
> })
> ```
>
> 获取路由参数
>
> ```
> const User = {
> 	// 路由组件中通过$route.params 获取路由参数
> 	template : '<div>User {{ $route.params.id }} </div>'
> }
> ```
>
> 使用 props 
>
> ```
> const router = new VueRouter({
> 	routes: [
> 		// 如果props 被设置为 true, route.params 将会被设置为组件属性
> 		{ path: '/user/:id, component: User, props: true}
> 		//props 也可以传递动态参数 props: { uname: 'list', age: 20}
> 	]
> })
> 
> const User= {
> 	props: ['id'], // 使用props 接收路由参数
> 	// props: ['name','age']
> 	templata: '<div>用户ID:{{id}}</div>' //使用路由参数
> }
> ```
>
> 

props 的值为函数类型

> ```
> const router = newVueRouter({
> 	toutes: [
> 		//如果 props 是一个函数, 则这个函数接收route 对象为自己的形参
> 		{
> 		path: '/user/:id',
> 		component: User,
> 		props: route => ({ uname:'zs, age: 20, id: route.params.id})
> 		}
> 	]
> })
> 
> const User = { 
> 	props: ['uname','age','id'],
> 	template: `<div>用户信息:{{uname + age + id}}</div>
> }
> ```
>
> 

##### 命名路由导航

> ```
> <router-link :to: "{ name: 'user', params: { id: 3} }">User3</router-link>
> ```
>
> ```
> 给路由规则添加一个 name: 'user' 属性
> ```
>
> 

##### 编程式导航

> 通过点击链接试下导航的方式, 叫做声明式导航
>
> 例如 : a 连接 或者 vue 中的<router-link></router-link> 
>
> 通过调用 JavaScript 形式的API 实现导航的方式, 叫做编程式导航
>
> 例如 : 普通网页中的 location.href
>
> > this.$router.push('hash地址') // 跳转到对应的地址
> >
> > this.$router.go(1)  // 前进或者后退 , 正数表示前进, 负数表示后退
>
> ```
> //字符串(路径名称)
> router.push('/home')
> //对象
> router.push({ path: '/home'})
> //命名路由(传递参数)
> router.push({ name: '/user', params: {userid: 123}})
> //带查询参数, 变成 /user?uname=zhanglei
> router.push({ path: '/user', query: { uname: 'zhanglei'}})
> ```
>
> 