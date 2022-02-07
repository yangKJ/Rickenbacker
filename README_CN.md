# Rickenbacker

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker)
[![Releases Compatible](https://img.shields.io/github/release/yangKJ/Rickenbacker.svg?style=flat&label=Releases&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker/releases)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Rickenbacker.svg?style=flat&label=CocoaPods&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Rickenbacker)
[![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-4E4E4E.svg?colorA=28a745)](#installation)

<font color=red>**👌. MVVM + RxSwift + CTMediatror + MJRefresh + DZNEmptyDataSet + SkeletonView**</font>

-------

[**English**](README.md) | 简体中文

基于 **MVVM + RxSwift** 搭建响应式数据绑定基础架构

### Resources
- 资源模块，主要处理图片资源和文本资源读取
  - 读取图片资源：`R.image("base_black_back")`
  - 读取文本资源：`R.text("base_empty_title")`

### Adapter
- 该模块主要就是封装基类
  - [BaseViewController](https://github.com/yangKJ/Rickenbacker): 支持oc基类，公共部分
  - [VMTableViewController](https://github.com/yangKJ/Rickenbacker): 列表基类, 内部采用响应式处理
  - [VMViewController](https://github.com/yangKJ/Rickenbacker): 该基类继承时需指定`ViewModel`或其子类作为泛型
  - [ViewModel](https://github.com/yangKJ/Rickenbacker): 基础模型
  - [TableViewModel](https://github.com/yangKJ/Rickenbacker): 主要用于`VMTableViewController`数据驱动绑定模型

### CTMediatror
- 该模块主要解决Swift采用该组件化方案CocoaPods问题

### HBDNavigationBar
- 该模块是基于`HBDNavigationBar`二次封装底层基础导航栏

### MJRefresh
- 该模块是基于`MJRefresh`封装列表刷新功能

### DZNEmptyDataSet
- 该模块是基于`EmptyDataSet-Swift`封装列表空数据展示功能

### CocoaPods Install
```
Ex: 导入项目响应式基类模块
- pod 'Rickenbacker/Adapter'

Ex: 导入组件化模块
- pod 'Rickenbacker/CTMediatror'

Ex: 导入导航栏基础模块
- pod 'Rickenbacker/HBDNavigationBar'

Ex: 导入自动刷新模块
- pod 'Rickenbacker/MJRefresh'

Ex: 导入空数据自动展示模块
- pod 'Rickenbacker/DZNEmptyDataSet'
```

-----

> <font color=red>**觉得有帮助的老哥们，请帮忙点个星 ⭐..**</font>

**救救孩子吧，谢谢各位老板。**

🥺

-----
