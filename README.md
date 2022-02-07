# Rickenbacker

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker)
[![Releases Compatible](https://img.shields.io/github/release/yangKJ/Rickenbacker.svg?style=flat&label=Releases&colorA=28a745&&colorB=4E4E4E)](https://github.com/yangKJ/Rickenbacker/releases)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Rickenbacker.svg?style=flat&label=CocoaPods&colorA=28a745&&colorB=4E4E4E)](https://cocoapods.org/pods/Rickenbacker)
[![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS-4E4E4E.svg?colorA=28a745)](#installation)

<font color=red>**👌. MVVM + RxSwift + CTMediatror + MJRefresh + DZNEmptyDataSet + SkeletonView**</font>

-------

English | [**简体中文**](README_CN.md)

This is a set of infrastructure based on `MVVM + RxSwift`

### Resources
- Resource module, which mainly deals with image resource and text resource reading.
  - Read image resource: `R.image("base_black_back")`
  - Read text resource: `R.text("base_empty_title")`

### Adapter
- This module is mainly to encapsulate the base class.
  - [BaseViewController](https://github.com/yangKJ/Rickenbacker): Support oc base class, public part.
  - [VMTableViewController](https://github.com/yangKJ/Rickenbacker): List base class, internally responsive processing.
  - [VMViewController](https://github.com/yangKJ/Rickenbacker): When inheriting this base class, you need to specify `ViewModel` or its subclasses as generics.
  - [ViewModel](https://github.com/yangKJ/Rickenbacker): Basic view model.
  - [TableViewModel](https://github.com/yangKJ/Rickenbacker): Mainly used for `VMTableViewController` data-driven binding model.

- CocoaPods Install ==> `pod 'Rickenbacker/Adapter'`

### CTMediatror
- This module mainly solves the cocoapods problem encountered by Swift using this componentized solution.

- CocoaPods Install ==> `pod 'Rickenbacker/CTMediatror'`

### HBDNavigationBar
- This module is based on `HBDNavigationBar` secondary encapsulation of the underlying basic Navigation.

- CocoaPods Install ==> `pod 'Rickenbacker/HBDNavigationBar'`

### MJRefresh
- This module is based on the refresh function of `MJRefresh` encapsulated UITableView.

- CocoaPods Install ==> `pod 'Rickenbacker/MJRefresh'`

### DZNEmptyDataSet
- This module is based on the empty data display function of the `EmptyDataSet-Swift` package UITableView.

- CocoaPods Install ==> `pod 'Rickenbacker/DZNEmptyDataSet'`

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
