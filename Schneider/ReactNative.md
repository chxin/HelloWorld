    1. React是基础框架，是一套基础设计实现理念 learn once，write anywhere
     2. 1. React.js开发网页
     2. React Native开发移动应用
     3. 跨平台通用能力、平台特色能力
     4. 混合开发

><u>React基础框架的基本概念和设计思想都是在React.js的相关文档中描述的</u>
  3. 预备知识
     1. JavaScript语法：包括语句、注释、变量、数据类型、数组（关联数组）、对象
     2. 运算符、语句、函数、对象

   4. Native良好的人机交互体验
     1. 反馈和高亮
     2. 撤销的能力

   5. React
     1. UI实现框架处理动态数据
     2. 组件化开发
     3. 跨平台移植代码迅速
     4. 自动匹配不同屏幕大小的手机

   6. React Native版本号
     1. 主版本号：不兼容的API修改
     2. 此版本号：向下兼容的功能性新增
     3. 修改号：向下兼容的问题修正

  7. 使用ios和Android设备

  8. flex布局：不指定宽高的值，或者只指定一个值

           1. ![flex](http://www.ruanyifeng.com/blogimg/asset/2015/bg2015071004.png)
           2. flex容器属性
                  1. flex-direction 主轴的方向（即项目的排列方向）row | row-reverse | column | column-reverse
                              1. `row`（默认值）：主轴为水平方向，起点在左端。
                            2. `row-reverse`：主轴为水平方向，起点在右端。
                            3. `column`：主轴为垂直方向，起点在上沿。
                            4. `column-reverse`：主轴为垂直方向，起点在下沿。
                2. flex-wrap如果一条轴线排不下，如何换行。nowrap | wrap | wrap-reverse;
                       1. `nowrap`（默认）：不换行。
                       2. `wrap`：换行，第一行在上方。
                       3. `wrap-reverse`：换行，第一行在下方。
                3. flex-flow是`flex-direction`属性和`flex-wrap`属性的简写形式，默认值为`row nowrap`
                4. justify-content项目在主轴上的对齐方式。flex-start | flex-end | center | space-between | space-around
                       1. `flex-start`（默认值）：左对齐
                       2. `flex-end`：右对齐
                       3. `center`： 居中
                       4. `space-between`：两端对齐，项目之间的间隔都相等。
                       5. `space-around`：每个项目两侧的间隔相等。所以，项目之间的间隔比项目与边框的间隔大一倍。
                5. align-items在交叉轴上如何对齐。flex-start | flex-end | center | baseline | stretch;
                       1. `flex-start`：交叉轴的起点对齐。
                       2. `flex-end`：交叉轴的终点对齐。
                       3. `center`：交叉轴的中点对齐。
                       4. `baseline`: 项目的第一行文字的基线对齐。
                       5. `stretch`（默认值）：如果项目未设置高度或设为auto，将占满整个容器的高度。
                6. align-content多根轴线的对齐方式。如果项目只有一根轴线，该属性不起作用flex-start | flex-end | center | space-between | space-around | stretch;
                       1. `flex-start`：与交叉轴的起点对齐。
                       2. `flex-end`：与交叉轴的终点对齐。
                       3. `center`：与交叉轴的中点对齐。
                       4. `space-between`：与交叉轴两端对齐，轴线之间的间隔平均分布。
                       5. `space-around`：每根轴线两侧的间隔都相等。所以，轴线之间的间隔比轴线与边框的间隔大一倍。
                       6. `stretch`（默认值）：轴线占满整个交叉轴。

  9. 疑惑

       1. import 后面的格式
       ```
          import React, { Component } from 'react';
          import {
            Platform,
            StyleSheet,
            Text,
            View,
            Dimensions,
            PixelRatio
          } from 'react-native';
       ```

       2. 组件和API的区别
          1. 组件是一个可显示的元素，通常在父组件的render函数返回值中
          2. API是ReactNative提供的类，在代码中调用它的静态函数以实现各种控制​

       3. 渲染过程

          1. shouldComponentUpdate函数来判断接下来是否进行渲染返回值是false，React Native将放弃渲染组件
             1. shouldComponentUpdate(nextProps, nextState)
          2. forceUpdate(callback)强制启动渲染
             1. 在组件中This.forceUpdate();
          3. render()重新渲染
             1. 只能返回一个可渲染组件描述

       4. 状态机变量

          1. ```
             updateNum(newText) {
               this.setState(() => {
                 return {
                   inputtedNum:newText,
                 };
               });
             }
             ```

          2. ```
             updatePW(inputedNum) {
               this.setState(() => 
               	return {inputedNum};
               );
             }
             ```

          3. ```
             updatePW(inputedNum) {
               this.setState({inputedNum});
             }
             ```

          4. ```
             onchangeText={(inputedNum) => this.setState({inputedNum})}/>
             ```

       5. 静态成员变量和静态成员函数

          1. 调用时，不能用this.+变量名（函数名）访问
          2. 直接以类名+点+变量名（函数名）访问

       6. 回调函数

          1. 使用箭头函数指向回调。  

          2. ```
             onChnageText = {(newText) => this.updateNum(newText)}
             ```

          3. 回调函数使用箭头函数来定义

          4. ```
             updateNum = (newText) => {
               this.setState((state) => {return {inputedNum: newText,}})
             }
             ```

             这种方法方便快捷，但与正规的类成员定义相左

          5. 在构造函数中绑定 bind，然后在回调函数中直接使用

          6. 在构造函数中不直接绑定，在使用时绑定

          7. ```
             onChangeText={this.updatePW.bind(this)}
             ```

             每次渲染时，都会执行一次bind函数

       7. 属性确认

          1. 在开发环境中，声明使用该组件需要哪些属性，如果在调用时没有提供对应的属性，则会在手机中弹出警告信息
          2. 属性的要求：js基本类型，节点，React元素，类的实例，特定值，数组，对象
          3. WaitingLeaf.propTypes

       8. 默然属性

          1. waitingLeaf.defaultProps

       9. 混合开发

          1. RCTBridgeModule协议

       10. 组件生命周期

         1. constructor 是RN的构建函数，第一个语句必须是  ``` super(props) ```。在组件加载前最先调用，并且仅仅调用一次。最大的作用是定义状态机变量
         2. componentWillMount  
            1. 在render被调用前执行，如果在这个函数里用setState函数改变状态机变量，不会立即被渲染，而是该函数执行完了渲染。
            2. 子组件的会在父组件的componentWillMount  执行完调用
            3. 读取本地存储的数据
         3. componentDidMount
            1. 在初始渲染完成后被调用，只执行一次
            2. 子组件的会在父组件的componentWillMount  执行前调用
            3. 从网络侧获取的数据
         4. componentWillReceiveProps
            1. 接收到新的props时，被调用。接受参数（nextProps）
            2. 老的props可以通过this.props访问，新的props在传入的参数中
            3. 如果在这个函数里用setState函数改变状态机变量，不会立即被渲染，而是该函数执行完了渲染。
         5. boolean shouldComponentUpdate( nextProps, nextState)
            1. 接收到新的Props或者State时执行，返回值告诉是否需要重新渲染，flase不渲染
         6. componentWillUpdate( nextProps, nextState )
            1. 重新渲染前要调用
            2. 不能通过this.setState再次改变状态机变量，可以在componentWillReceiveProps中进行改变
         7. componentDidUpdate (prevProps, prevState)
            1. 重新渲染完成后执行，传入的参数是渲染前的props和state
         8. componentWillUnmount
            1. 组件被卸载前执行
            2. 如果RN组件申请了某些资源或者订阅了某些信息，需要在这个函数中释放资源，取消订阅

       11. 项目配置

           1. 调试环境和正式运行环境的不同
           2. iOS 
              1. 应用名称：Build Setting：Product Name
              2. 显示图标：
              3. 启动动画：
           3. Android
              1. 应用名称：./android/app/src/main/res/values/string.xml
              2. 图标：./android/app/src/main/res的五个目录
              3. 签名打包 ./android/app/build/outputs/apk/app-release.apk
              4. ​

