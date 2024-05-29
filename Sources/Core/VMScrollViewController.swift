//
//  VMScrollViewController.swift
//  Rickenbacker
//
//  Created by Condy on 2022/5/20.
//

import RxSwift
import ObjectiveC

/// 兼容其他类型的控制器，只要是使用`UIScrollView`或其子类的均可采用
open class VMScrollViewController<T: ViewModel>: VMViewController<T> {
    
    public private(set) var scrollView: UIScrollView
    
    public init(scrollView: UIScrollView, viewModel: T) {
        self.scrollView = scrollView
        super.init(viewModel: viewModel)
    }
    
    public convenience init(scrollView: UIScrollView) {
        self.init(scrollView: scrollView, viewModel: T.init())
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
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        if self is NavigationBarHiddenable {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            scrollView.contentInset = UIEdgeInsets(top: Ces.navigationHeight, left: 0, bottom: 0, right: 0)
        }
        
        // 是否包含刷新模块
        #if RICKENBACKER_MJREFRESH
        self.setupOptionalRefresh()
        #endif
        
        // 是否包含空数据模块
        #if RICKENBACKER_DZNEMPTYDATASET
        self.setupOptionalEmptyData()
        #endif
    }
    
    /// 需要添加dynamic修饰，否则无法使用方法交换
    /// Need to add dynamic modification, otherwise the method exchange cannot be used
    //dynamic func setupScrollSubRefresh() { }
    //dynamic func setupScrollSubEmptyData() { }
}
