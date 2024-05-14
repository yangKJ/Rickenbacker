//
//  BasicsViewController.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation
import UIKit

open class BasicsViewController: UIViewController {
    
    /// 强制移除，开启之后`viewDidDisappear`时，此页面会从堆栈中移除。
    /// When you jump to the next view controller after opening, this view controller will be removed from the stack.
    public var wasForceRemoved = false
    
    public var realSelf: UIViewController {
        get {
            var realSelf: UIViewController = self
            while let par = realSelf.parent, !(par is UINavigationController) {
                realSelf = par
            }
            return realSelf
        }
    }
    
    public lazy var backBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: Res.base_black_back,
                                        style: .plain,
                                        target: self,
                                        action: #selector(BasicsViewController.backAction))
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
        self.view.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            //self.view.backgroundColor = R.color("background")
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    // MARK: - public methods
    
    public var willCloseByUserBlock: ((_ vc: BasicsViewController) -> Void)?
    public var closedByUserBlock: ((_ vc: BasicsViewController) -> Void)?
    
    /// About to close the current page. Click the back button or gesture to return.
    open func setWillCloseByUserBlock(_ block: @escaping (_ vc: BasicsViewController) -> Void) {
        self.willCloseByUserBlock = block
    }
    
    /// It has been successfully closed. Click the back button or gesture to return.
    open func setClosedByUserComplete(_ block: @escaping (_ vc: BasicsViewController) -> Void) {
        self.closedByUserBlock = block
    }
    
    /// Customize the back button click event.
    @objc dynamic open func backAction() {
        popoutOrDismiss()
    }
    
    open func popoutOrDismiss(completion: (() -> Void)? = nil) {
        self.willCloseByUserBlock?(self)
        if self.presentingViewController != nil {
            if let count = self.navigationController?.viewControllers.count, count > 1, self.navigationController?.topViewController == realSelf {
                popout(completion: completion)
            } else if self.navigationController?.children[0] == self {
                self.dismiss(animated: true) {
                    completion?()
                    self.closedByUserBlock?(self)
                }
            } else {
                popout(completion: completion)
            }
        } else {
            popout(completion: completion)
        }
    }
    
    private func popout(completion: (() -> Void)? = nil) {
        if let completion = completion {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            self.navigationController?.popViewController(animated: true)
            self.closedByUserBlock?(self)
            CATransaction.commit()
        } else {
            self.navigationController?.popViewController(animated: true)
            self.closedByUserBlock?(self)
        }
    }
}

extension BasicsViewController {
    
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
        guard wasForceRemoved, let viewControllers = navigationController?.viewControllers else {
            return
        }
        navigationController?.viewControllers = viewControllers.compactMap({ vc in
            return vc == self.realSelf ? nil : vc
        })
    }
}
