//
//  EmptyDataConfig.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/4.
//

import RxSwift
import RxCocoa

/// 空数据配置
public protocol EmptyDataConfig {
    /// 点击事件响应
    var emptyDataSetButtonTap: PublishSubject<Void> { get set }
    var emptyDataSetViewTap: PublishSubject<Void> { get set }
    
    /// 设置控件属性
    var emptyDataSetTitle: String { get set }
    var emptyDataSetDescription: String { get set }
    var emptyDataSetImage: UIImage { get set }
    var emptyDataSetImageTintColor: BehaviorRelay<UIColor> { get set }
    var emptyDataSetVerticalOffset: CGFloat { get set }
}

fileprivate var EmptyDataSetButtonTapContext: UInt8 = 0
fileprivate var EmptyDataSetViewTapContext: UInt8 = 0
fileprivate var EmptyDataSetTitleContext: UInt8 = 0
fileprivate var EmptyDataSetDescriptionContext: UInt8 = 0
fileprivate var EmptyDataSetImageContext: UInt8 = 0
fileprivate var EmptyDataSetImageTintColorContext: UInt8 = 0
fileprivate var EmptyDataSetVerticalOffsetContext: UInt8 = 0

extension EmptyDataConfig {
    
    public var emptyDataSetButtonTap: PublishSubject<Void> {
        get {
            if let emptyData = objc_getAssociatedObject(self, &EmptyDataSetButtonTapContext) {
                return emptyData as! PublishSubject<Void>
            } else {
                let emptyData: PublishSubject<Void> = PublishSubject<Void>()
                objc_setAssociatedObject(self, &EmptyDataSetButtonTapContext, emptyData, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return emptyData
            }
        }
        set {
            objc_setAssociatedObject(self, &EmptyDataSetButtonTapContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var emptyDataSetViewTap: PublishSubject<Void> {
        get {
            if let emptyData = objc_getAssociatedObject(self, &EmptyDataSetViewTapContext) {
                return emptyData as! PublishSubject<Void>
            } else {
                let emptyData: PublishSubject<Void> = PublishSubject<Void>()
                objc_setAssociatedObject(self, &EmptyDataSetViewTapContext, emptyData, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return emptyData
            }
        }
        set {
            objc_setAssociatedObject(self, &EmptyDataSetViewTapContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var emptyDataSetTitle: String {
        get {
            if let emptyData = objc_getAssociatedObject(self, &EmptyDataSetTitleContext) {
                return emptyData as! String
            } else {
                let emptyData: String = R.text("base_empty_title")
                objc_setAssociatedObject(self, &EmptyDataSetTitleContext, emptyData, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return emptyData
            }
        }
        set {
            objc_setAssociatedObject(self, &EmptyDataSetTitleContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var emptyDataSetDescription: String {
        get {
            if let emptyData = objc_getAssociatedObject(self, &EmptyDataSetDescriptionContext) {
                return emptyData as! String
            } else {
                let emptyData: String = ""
                objc_setAssociatedObject(self, &EmptyDataSetDescriptionContext, emptyData, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return emptyData
            }
        }
        set {
            objc_setAssociatedObject(self, &EmptyDataSetDescriptionContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var emptyDataSetImage: UIImage {
        get {
            if let emptyData = objc_getAssociatedObject(self, &EmptyDataSetImageContext) {
                return emptyData as! UIImage
            } else {
                let emptyData: UIImage = R.image("base_empty_black")
                objc_setAssociatedObject(self, &EmptyDataSetImageContext, emptyData, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return emptyData
            }
        }
        set {
            objc_setAssociatedObject(self, &EmptyDataSetImageContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var emptyDataSetImageTintColor: BehaviorRelay<UIColor> {
        get {
            if let emptyData = objc_getAssociatedObject(self, &EmptyDataSetImageTintColorContext) {
                return emptyData as! BehaviorRelay<UIColor>
            } else {
                let emptyData: BehaviorRelay<UIColor> = BehaviorRelay<UIColor>(value: UIColor.clear)
                objc_setAssociatedObject(self, &EmptyDataSetImageTintColorContext, emptyData, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return emptyData
            }
        }
        set {
            objc_setAssociatedObject(self, &EmptyDataSetImageTintColorContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var emptyDataSetVerticalOffset: CGFloat {
        get {
            if let emptyData = objc_getAssociatedObject(self, &EmptyDataSetVerticalOffsetContext) {
                return emptyData as! CGFloat
            } else {
                let emptyData: CGFloat = -60
                objc_setAssociatedObject(self, &EmptyDataSetVerticalOffsetContext, emptyData, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return emptyData
            }
        }
        set {
            objc_setAssociatedObject(self, &EmptyDataSetVerticalOffsetContext, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension VMTableViewController: EmptyDataConfig { }
