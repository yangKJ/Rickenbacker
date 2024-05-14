# Rickenbacker

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker)
[![Releases Compatible](https://img.shields.io/github/release/yangKJ/Rickenbacker.svg?style=flat&label=Releases&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker/releases)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Rickenbacker.svg?style=flat&label=CocoaPods&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Rickenbacker)
[![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-4E4E4E.svg?colorA=28a745)](#installation)

<font color=red>**👌. MVVM + RxSwift + Mediatror + MJRefresh + DZNEmptyDataSet + SkeletonView**</font>

-------

[**English**](README.md) | 简体中文

基于 **MVVM + RxSwift** 搭建响应式数据绑定基础架构

### CatHome
- 资源模块，主要处理图片资源和文本资源读取
  - 读取图片资源：`Res.image("base_black_back")`
  - 读取文本资源：`Res.text("base_empty_title")`
  - 读取颜色资源：`Res.color("background")`

### BeeBox
- 主要收集[RxSwift](https://github.com/ReactiveX/RxSwift)相关好用方法类等

### Adapter
- 该模块主要就是封装基类
  - [BaseViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/BaseViewController.swift): 支持oc基类，公共部分
  - [VMScrollViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/VMScrollViewController.swift): 提供对列表提供刷新和空数据展示支持
  - [VMTableViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/VMTableViewController.swift): 列表基类, 内部采用响应式处理
  - [VMViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/VMViewController.swift): 该基类继承时需指定ViewModel或其子类作为泛型
  - [ViewModel](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/ViewModel.swift): 基础模型，子类必须继承使用
  - [NavigationBarHiddenable](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/NavigationBarHiddenable.swift): 隐藏NavigationBar的协议

### Mediatror

- 该模块主要就是提供设计组件化中间层

- 设计组件化中间层有两种比较有代表性的方案：
  - 基于URL注册跳转的方式，参考蘑菇街开源 [MGJRouter](https://github.com/lyujunwei/MGJRouter)
  - 基于Objective-C运行时的Mediator方式，参考 [CTMediator](https://github.com/casatwy/CTMediator)

- 简单谈谈二者优势区别：
  - URL注册的方式在使用上非常繁琐而且很多时候其实没有必要。首先每一个页面跳转都需要事先注册好URL，这里会牵涉到非常多字符串硬编码。
  - 基于runtime的Mediator方式，首先它不需要注册，省去了很多比对字符串的过程，其次它可以非常容易的传递各种参数来进行组建间通信。

- 因此这边最终选择提供方案也是`Mediator`方式；

使用示例：

```swift
extension Mediator {
    static func Second_viewController(title: String) -> UIViewController? {
        self.perform(target: SecondTarget.self,
                     action: "setupSecondViewController",
                     module: "Rickenbacker_Example",
                     params: ["title": title])
    }
}

class SecondTarget: NSObject {
    /// 备注提示，这里必须加上`@objc`
    /// 否则会出现找不到该方法从而导致控制器为`nil`问题
    @objc func setupSecondViewController(_ params: NSDictionary) -> UIViewController? {
        guard let title = params["title"] as? String else { return nil }
        let vm = SecondViewModel.init(title: title)
        let vc = SecondViewController.init(viewModel: vm)
        return vc
    }
}
```

### HBDNavigationBar
- 该模块是基于[HBDNavigationBar](https://github.com/listenzz/HBDNavigationBar)二次封装底层基础导航栏

### MJRefresh
该模块是基于[MJRefresh](https://github.com/CoderMJLee/MJRefresh)封装列表刷新功能

- 注入下拉刷新功能，只需要简单的实现`ViewModelHeaderable`协议即可
- 注入上拉加载更多功能，只需要简单的实现`ViewModelFooterable`协议即可

使用示例：

```swift
extension MJRefreshViewModel: ViewModelHeaderable, ViewModelFooterable {
    
    var enterBeginRefresh: Bool {
        return false
    }
    // 自动无感上拉刷新功能
    var footer: MJRefreshFooter {
        let footer = MJRefreshAutoFooter()
        footer.triggerAutomaticallyRefreshPercent = -5
        return footer
    }
}
```

> 备注提示：当然这边你也可以根据你的需求来自定义`header`和`footer`

### DZNEmptyDataSet
该模块是基于[DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet)封装列表空数据展示功能

- 注入空数据展示功能，只需要简单的实现`ViewModelEmptiable`协议

使用示例：

```swift
class EmptyViewModel: ViewModel, ViewModelEmptiable, ViewModelHeaderable {
    
    let dataSource: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    func loadData() {
        let driver = NetworkService().randomResult().asObservable()
        driver.bind(to: dataSource).disposed(by: disposeBag)
        driver.map { $0.isEmpty }.bind(to: isEmptyData).disposed(by: disposeBag)
        driver.subscribe { _ in } onCompleted: {
            self.refreshSubject.onNext(.endHeaderRefresh)
        }.disposed(by: disposeBag)
    }
}
```

- 这边也支持自定义样式设计，只需要实现`DZNEmptyDataSetSourceable`或`DZNEmptyDataSetDelegateable`协议，接口都是直接对`DZNEmptyDataSet`提供的做转行处理。

使用示例：

```swift
// 配置空数据展示信息
extension DZNEmptyDataSetViewController: DZNEmptyDataSetable {
    
    func DZNEmptyDataSetImage(scrollView: UIScrollView) -> UIImage {
        return Res.image("base_network_error_black")
    }
    
    func DZNEmptyDataSetImageTintColor(scrollView: UIScrollView) -> UIColor? {
        return UIColor.red
    }
    
    func DZNEmptyDataSetTitle(scrollView: UIScrollView) -> NSAttributedString? {
        NSAttributedString(string: Res.text("TEXT"))
    }
    
    func DZNEmptyDataSetDescription(scrollView: UIScrollView) -> NSAttributedString? {
        NSAttributedString(string: Res.text("测试网络异常展示"))
    }
    
    func DZNEmptyDataSetVerticalOffset(scrollView: UIScrollView) -> CGFloat {
        return -77
    }
}
```

### CocoaPods
- 导入项目响应式基类模块

```
pod 'Rickenbacker/Adapter'
```

- 导入组件化模块

```
pod 'Rickenbacker/Mediatror'
```

- 导入导航栏基础模块

```
pod 'Rickenbacker/HBDNavigationBar'
```

- 导入自动刷新模块

```
pod 'Rickenbacker/MJRefresh'
```

- 导入空数据自动展示模块

```
pod 'Rickenbacker/DZNEmptyDataSet'
```

-----

> <font color=red>**觉得有帮助的老哥们，请帮忙点个星 ⭐..**</font>

**救救孩子吧，谢谢各位老板。**

🥺

-----
