//
//  BaseScrollViewController.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

import RxSwift

/// 兼容其他类型的控制器，只要是使用`UIScrollView`或其子类的均可采用
open class BaseScrollViewController: BaseViewController {
    
    public let disposeBag = DisposeBag()
    public private(set) var viewModel: ViewModel
    public private(set) var scrollView: UIScrollView
    
    public init(scrollView: UIScrollView, viewModel: ViewModel) {
        self.scrollView = scrollView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupScrollView()
    }
    
    final func setupScrollView() {
        view.addSubview(scrollView)
        self.setupSubRefresh()
        self.setupSubEmptyData()
    }
    
    /// 需要添加dynamic修饰，否则无法使用方法交换
    /// Need to add dynamic modification, otherwise the method exchange cannot be used
    dynamic func setupSubRefresh() { }
    dynamic func setupSubEmptyData() { }
}
