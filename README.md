# Rickenbacker

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker)
[![Releases Compatible](https://img.shields.io/github/release/yangKJ/Rickenbacker.svg?style=flat&label=Releases&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker/releases)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Rickenbacker.svg?style=flat&label=CocoaPods&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Rickenbacker)
[![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-4E4E4E.svg?colorA=28a745)](#installation)

<font color=red>**👌. MVVM + RxSwift + Mediatror + MJRefresh + DZNEmptyDataSet**</font>

-------

English | [**简体中文**](README_CN.md)

This is a set of infrastructure based on MVVM + RxSwift

## Features
At the moment, the most important features of [Rickenbacker](https://github.com/yangKJ/Rickenbacker) can be summarized as follows:

### Core
This module is mainly to encapsulate the base class.

- [BasicsViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Core/BasicsViewController.swift): Base class, public part.
- [VMScrollViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Core/VMScrollViewController.swift): Provide refresh and empty data display support for the list.
- [VMTableViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Core/VMTableViewController.swift): List base class, internally responsive processing.
- [VMViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Core/VMViewController.swift): You need to specify ViewModel or its subclasses as generics.
- [ViewModel](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Core/ViewModel.swift): Basic view model, Subclasses must inherit.
- [NavigationBarHiddenable](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Core/NavigationBarHiddenable.swift): Hide the protocol of NavigationBar.

Resource module, which mainly deals with image resource and text resource reading.

- Read image resource: 

```
Res.image("base_black_back")
```

- Read text resource: 

```
Res.text("base_empty_title")
```

- Read color resource:

```
Res.color("background")
```

### Mediatror

- This module mainly provides a design component intermediate layer.

- There are two more representative schemes for designing the component middle layer:
  - Based on the URL registration jump method, refer to Mushroom Street Open Source [MGJRouter](https://github.com/lyujunwei/MGJRouter)
  - Mediator method based on Objective-C runtime, refer to [CTMediator](https://github.com/casatwy/CTMediator)

- Briefly talk about the advantages and differences between the two:
  - The way of URL registration is very cumbersome to use and often is not necessary. First of all, you need to register the URL in advance for each page jump, which will involve a lot of string hard coding.
  - Based on the runtime Mediator method, first of all, it does not need to register, which saves a lot of process of contrasting strings. Secondly, it is very easy to pass various parameters for inter-establishment communication.

- Therefore, the final choice to provide the solution is also the `Mediator` method;

Test case：

```swift
if let vc = Mediator.Second_viewController(title: "biaoti") {
    pushButton.rx.tap
        .bind(to: rx.pushViewController(vc, animated: true))
        .disposed(by: disposeBag)
}
```
- Componentized intermediate layer:

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
    /// Note prompt, `@objc` must be added here.
    @objc func setupSecondViewController(_ params: NSDictionary) -> UIViewController? {
        guard let title = params["title"] as? String else { return nil }
        let vm = SecondViewModel.init(title: title)
        let vc = SecondViewController.init(viewModel: vm)
        return vc
    }
}
```

### MJRefresh
This module is based on the refresh function of [MJRefresh](https://github.com/CoderMJLee/MJRefresh) encapsulated UITableView.

- Inject refresh function, you only need to simply implement the `ViewModelHeaderable` protocol.
- Inject load more functions, just simply implement the `ViewModelFooterable` protocol.

Test case:

```swift
extension MJRefreshViewModel: ViewModelHeaderable, ViewModelFooterable {
    
    var enterBeginRefresh: Bool {
        return false
    }
    // Automatic non-sensing pull-up refresh function
    var footer: MJRefreshFooter {
        let footer = MJRefreshAutoFooter()
        footer.triggerAutomaticallyRefreshPercent = -5
        return footer
    }
}
```

> Remarks: Of course, you can also customize `header` and `footer` according to your needs.

### DZNEmptyDataSet
This module is based on the empty data display function of the [DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet) package UITableView.

- To inject empty data display function, you only need to simply implement the `ViewModelEmptiable` protocol.

Test case:

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

- Here also supports custom style design, only need to implement `DZNEmptyDataSetSourceable` or `DZNEmptyDataSetDelegateable` agreement, interfaces are directly to `DZNEmptyDataSet` do turning processing.

Test case:

```swift
// Configure empty data display information
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

----

### CocoaPods
- If you want use this framework.☠️

```
pod 'Rickenbacker'
```

### Remarks

> The general process is almost like this, the Demo is also written in great detail, you can check it out for yourself.🎷
>
> [**RickenbackerDemo**](https://github.com/yangKJ/Rickenbacker)
>
> Tip: If you find it helpful, please help me with a star. If you have any questions or needs, you can also issue.
>
> Thanks.🎇

### About the author
- 🎷 **E-mail address: [yangkj310@gmail.com](yangkj310@gmail.com) 🎷**
- 🎸 **GitHub address: [yangKJ](https://github.com/yangKJ) 🎸**

-----

### License
Rickenbacker is available under the [MIT](LICENSE) license. See the [LICENSE](LICENSE) file for more info.

-----
