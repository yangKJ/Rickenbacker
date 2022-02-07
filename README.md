# Rickenbacker

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker)
[![Releases Compatible](https://img.shields.io/github/release/yangKJ/Rickenbacker.svg?style=flat&label=Releases&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker/releases)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Rickenbacker.svg?style=flat&label=CocoaPods&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Rickenbacker)
[![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-4E4E4E.svg?colorA=28a745)](#installation)

<font color=red>**👌. MVVM + RxSwift + CTMediatror + MJRefresh + DZNEmptyDataSet + SkeletonView**</font>

-------

English | [**简体中文**](README_CN.md)

This is a set of infrastructure based on MVVM + RxSwift

## Features
At the moment, the most important features of [Rickenbacker](https://github.com/yangKJ/Rickenbacker) can be summarized as follows:

### Adapter
This module is mainly to encapsulate the base class.

- [BaseViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/Controller/BaseViewController.swift): Support oc base class, public part.
- [VMTableViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/Controller/VMTableViewController.swift): List base class, internally responsive processing.
- [VMViewController](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/Controller/VMViewController.swift): You need to specify `ViewModel` or its subclasses as generics.
- [ViewModel](https://github.com/yangKJ/Rickenbacker/blob/master/Sources/Adapter/ViewModel/ViewModel.swift): Basic view model, Subclasses must inherit.

### CatHome
Resource module, which mainly deals with image resource and text resource reading.

- Read image resource: 

```
R.image("base_black_back")
```

- Read text resource: 

```
R.text("base_empty_title")
```

- Read color resource:

```
R.color("background")
```

### BeeBox
Mainly collect [RxSwift](https://github.com/ReactiveX/RxSwift) related useful method classes, etc.

### CTMediatror
This module mainly solves the cocoapods problem encountered by Swift using this componentized solution.

### HBDNavigationBar
This module is based on [HBDNavigationBar](https://github.com/listenzz/HBDNavigationBar) secondary encapsulation of the underlying basic Navigation.

### MJRefresh
This module is based on the refresh function of [MJRefresh](https://github.com/CoderMJLee/MJRefresh) encapsulated UITableView.

### DZNEmptyDataSet
This module is based on the empty data display function of the [EmptyDataSet-Swift](https://github.com/Xiaoye220/EmptyDataSet-Swift) package UITableView.

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
