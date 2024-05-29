//
//  VMViewController.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

///`RxSwift`中文文档
/// https://beeth0ven.github.io/RxSwift-Chinese-Documentation/
/// https://github.com/ReactiveX/RxSwift

@_exported import RxSwift
@_exported import RxCocoa
@_exported import RxRelay

/// 继承时需指定 ViewModel 或其子类作为泛型。该类会自动懒加载指定类型的 VM 对象。
/// When inheriting, you need to specify ViewModel or its subclasses as generics.
/// This class will automatically lazy load VM objects of the specified type.
open class VMViewController<T: ViewModel> : BasicsViewController {
    
    public let viewModel: T
    public var disposeBag = DisposeBag()
    
    public convenience init() {
        self.init(viewModel: T())
    }
    
    public init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
