//
//  BaseViewController.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    
    /// 强制移除，开启之后跳转到下一张页面时，此页面会从堆栈中移除
    /// When you jump to the next view controller after opening, this view controller will be removed from the stack.
    public var wasForceRemoved = false
    
    public lazy var backBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: R.image("base_black_back"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(BaseViewController.backAction))
        barButton.imageInsets.left = 5
        return barButton
    }()
    
    deinit {
        Log.debug("\(self.description): Deinited", file: "\(type(of: self))")
    }
    
    public var navigationTitle = "" {
        didSet {
            self.navigationItem.title = navigationTitle
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = self.backBarButton
        if #available(iOS 11.0, *) {
            self.view.backgroundColor = R.color("background")
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            self.view.backgroundColor = UIColor.white
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    // MARK: - public methods
    
    @objc dynamic open func backAction() {
        self.willCloseByUserBlock?(self)
        if (self.navigationController?.children[0] == self) {
            self.dismiss(animated: true) {
                self.closedByUserBlock?(self)
            }
            return
        }
        self.navigationController?.popViewController(animated: true)
        self.closedByUserBlock?(self)
    }
    
    var willCloseByUserBlock: ((_ vc: BaseViewController) -> Void)?
    var closedByUserBlock: ((_ vc: BaseViewController) -> Void)?
    
    /// About to close the current page. Click the back button or gesture to return.
    open func setWillCloseByUserBlock(_ block: @escaping (_ vc: BaseViewController) -> Void) {
        self.willCloseByUserBlock = block
    }
    
    /// It has been successfully closed. Click the back button or gesture to return.
    open func setClosedByUserComplete(_ block: @escaping (_ vc: BaseViewController) -> Void) {
        self.closedByUserBlock = block
    }
}

extension BaseViewController {
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarHiddenableViewWillAppear(animated)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupNavigationBarHiddenableViewWillDisappear(animated)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBarHiddenableViewDidAppear(animated)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if wasForceRemoved == false {
            return
        }
        var viewControllers = navigationController?.viewControllers ?? []
        viewControllers.removeAll {
            ($0 as? BaseViewController)?.wasForceRemoved ?? false ? true : false
        }
        navigationController?.viewControllers = viewControllers
    }
}
