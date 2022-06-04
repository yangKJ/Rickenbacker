# Rickenbacker

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker)
[![Releases Compatible](https://img.shields.io/github/release/yangKJ/Rickenbacker.svg?style=flat&label=Releases&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker/releases)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Rickenbacker.svg?style=flat&label=CocoaPods&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Rickenbacker)
[![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-4E4E4E.svg?colorA=28a745)](#installation)

<font color=red>**👌. MVVM + RxSwift + CTMediatror + MJRefresh + DZNEmptyDataSet + SkeletonView**</font>

-------

[**English**](README.md) | 简体中文

基于 **MVVM + RxSwift** 搭建响应式数据绑定基础架构

### CatHome
- 资源模块，主要处理图片资源和文本资源读取
  - 读取图片资源：`R.image("base_black_back")`
  - 读取文本资源：`R.text("base_empty_title")`
  - 读取颜色资源：`R.color("background")`

### BeeBox
- 主要收集[RxSwift](https://github.com/ReactiveX/RxSwift)相关好用方法类等

### Adapter
- 该模块主要就是封装基类
  - [BaseViewController](https://github.com/yangKJ/Rickenbacker): 支持oc基类，公共部分
  - [VMTableViewController](https://github.com/yangKJ/Rickenbacker): 列表基类, 内部采用响应式处理
  - [VMViewController](https://github.com/yangKJ/Rickenbacker): 该基类继承时需指定`ViewModel`或其子类作为泛型
  - [ViewModel](https://github.com/yangKJ/Rickenbacker): 基础模型，子类必须继承使用

### CTMediatror
- 该模块主要解决Swift采用该组件化方案CocoaPods问题

### HBDNavigationBar
- 该模块是基于[HBDNavigationBar](https://github.com/listenzz/HBDNavigationBar)二次封装底层基础导航栏

### MJRefresh
该模块是基于[MJRefresh](https://github.com/CoderMJLee/MJRefresh)封装列表刷新功能

- 注入下拉刷新功能，只需要简单的实现`ViewModelHeaderable`协议即可
- 注入上拉加载更多功能，只需要简单的实现`ViewModelFooterable`协议即可

测试用例：

```
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

测试用例：

```
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

```swift
public typealias DZNEmptyDataSetable = DZNEmptyDataSetSourceable & DZNEmptyDataSetDelegateable

public protocol DZNEmptyDataSetSourceable {
    
    /// Asks the data source for the image of the dataset.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: An image for the dataset.
    func DZNEmptyDataSetImage(scrollView: UIScrollView) -> UIImage
    
    /// Asks the data source for the title of the dataset.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: An attributed string for the dataset title, combining font, text color, text pararaph style, etc.
    func DZNEmptyDataSetTitle(scrollView: UIScrollView) -> NSAttributedString?
    
    /// Asks the data source for the description of the dataset.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: An attributed string for the dataset description text, combining font, text color, text pararaph style, etc.
    func DZNEmptyDataSetDescription(scrollView: UIScrollView) -> NSAttributedString?
    
    /// Asks the data source for a tint color of the image dataset. Default is nil.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: A color to tint the image of the dataset.
    func DZNEmptyDataSetImageTintColor(scrollView: UIScrollView) -> UIColor?
    
    /// Asks the data source for the image animation of the dataset.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: image animation
    func DZNEmptyDataSetImageAnimation(scrollView: UIScrollView) -> CAAnimation?
    
    /// Asks the data source for the title to be used for the specified button state.
    /// The dataset uses a fixed font style by default, if no attributes are set. If you want a different font style, return a attributed string.
    /// - Parameters:
    ///   - scrollView: A scrollView subclass informing the data source.
    ///   - state: The state that uses the specified title. The possible values are described in UIControlState.
    /// - Returns: An attributed string for the dataset button title, combining font, text color, text pararaph style, etc.
    func DZNEmptyDataSetButtonTitle(scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString?
    
    /// Asks the data source for the image to be used for the specified button state.
    /// This method will override buttonTitleForEmptyDataSet:forState: and present the image only without any text.
    /// - Parameters:
    ///   - scrollView: A scrollView subclass informing the data source.
    ///   - state: The state that uses the specified title. The possible values are described in UIControlState.
    /// - Returns: An image for the dataset button imageview.
    func DZNEmptyDataSetButtonImage(scrollView: UIScrollView, for state: UIControl.State) -> UIImage?
    
    /// Asks the data source for a background image to be used for the specified button state.
    /// There is no default style for this call.
    /// - Parameters:
    ///   - scrollView: A scrollView subclass informing the data source.
    ///   - state: The state that uses the specified image. The values are described in UIControlState.
    /// - Returns: An attributed string for the dataset button title, combining font, text color, text pararaph style, etc.
    func DZNEmptyDataSetButtonBackgroundImage(scrollView: UIScrollView, for state: UIControl.State) -> UIImage?
    
    /// Asks the data source for the background color of the dataset. Default is clear color.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: A color to be applied to the dataset background view.
    func DZNEmptyDataSetBackgroundColor(scrollView: UIScrollView) -> UIColor
    
    /// Asks the data source for a custom view to be displayed instead of the default views such as labels, imageview and button. Default is nil.
    /// Use this method to show an activity view indicator for loading feedback, or for complete custom empty data set.
    /// Returning a custom view will ignore -offsetForEmptyDataSet and -spaceHeightForEmptyDataSet configurations.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: The custom view.
    func DZNEmptyDataSetCustomView(scrollView: UIScrollView) -> UIView?
    
    /// Asks the data source for a offset for vertical and horizontal alignment of the content. Default is CGPointZero.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: The offset for vertical and horizontal alignment.
    func DZNEmptyDataSetVerticalOffset(scrollView: UIScrollView) -> CGFloat
    
    /// Asks the data source for a vertical space between elements. Default is 11 pts.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: The space height between elements.
    func DZNEmptyDataSetSpaceHeight(scrollView: UIScrollView) -> CGFloat
}

public protocol DZNEmptyDataSetDelegateable {
    
    /// Asks the delegate to know if the empty dataset should fade in when displayed. Default is YES.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: YES if the empty dataset should fade in.
    func DZNEmptyDataSetShouldFadeIn(_ scrollView: UIScrollView) -> Bool
    
    /// Asks the delegate to know if the empty dataset should still be displayed when the amount of items is more than 0. Default is NO
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: YES if empty dataset should be forced to display
    func DZNEmptyDataSetShouldBeForcedToDisplay(_ scrollView: UIScrollView) -> Bool
    
    /// Asks the delegate for touch permission. Default is YES.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: YES if the empty dataset receives touch gestures.
    func DZNEmptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool
    
    /// Asks the delegate for scroll permission. Default is NO.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: YES if the empty dataset is allowed to be scrollable.
    func DZNEmptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool
    
    /// Asks the delegate for image view animation permission. Default is NO.
    /// Make sure to return a valid CAAnimation object from imageAnimationForEmptyDataSet:
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    /// - Returns: YES if the empty dataset is allowed to animate
    func DZNEmptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool
    
    /// Tells the delegate that the empty data set will appear.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    func DZNEmptyDataSetWillAppear(_ scrollView: UIScrollView)
    
    /// Tells the delegate that the empty data set did appear.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    func DZNEmptyDataSetDidAppear(_ scrollView: UIScrollView)
    
    /// Tells the delegate that the empty data set will disappear.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    func DZNEmptyDataSetWillDisappear(_ scrollView: UIScrollView)
    
    /// Tells the delegate that the empty data set did disappear.
    /// - Parameter scrollView: A scrollView subclass informing the data source.
    func DZNEmptyDataSetDidDisappear(_ scrollView: UIScrollView)
}
```

使用示例：

```swift
// 配置空数据展示信息
extension DZNEmptyDataSetViewController: DZNEmptyDataSetable {
    
    func DZNEmptyDataSetImage(scrollView: UIScrollView) -> UIImage {
        return R.image("base_network_error_black")
    }
    
    func DZNEmptyDataSetImageTintColor(scrollView: UIScrollView) -> UIColor? {
        return UIColor.red
    }
    
    func DZNEmptyDataSetTitle(scrollView: UIScrollView) -> NSAttributedString? {
        NSAttributedString(string: R.text("TEXT"))
    }
    
    func DZNEmptyDataSetDescription(scrollView: UIScrollView) -> NSAttributedString? {
        NSAttributedString(string: R.text("测试网络异常展示"))
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
pod 'Rickenbacker/CTMediatror'
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
