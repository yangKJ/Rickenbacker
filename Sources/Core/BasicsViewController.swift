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
    
    public var navigationTitle = "" {
        didSet {
            self.navigationItem.title = navigationTitle
        }
    }
    
    public var realSelf: UIViewController {
        get {
            var realSelf: UIViewController = self
            while let par = realSelf.parent, !(par is UINavigationController) {
                realSelf = par
            }
            return realSelf
        }
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.hidesBottomBarWhenPushed = true
    }
    
    deinit {
        Log.debug("\(self.description): Deinited", file: "\(type(of: self))")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.setPopOrDismissButton(width: 50)
    }
    
    // MARK: - public methods
    
    open func setPopOrDismissButton(width: CGFloat) {
        guard let navigationController = self.navigationController else {
            return
        }
        if let _ = self.presentingViewController, navigationController.viewControllers.first == self {
            self.navigationItem.leftBarButtonItem = createBarButtonItem(image: Res.base_black_close, width: width)
        } else if navigationController.viewControllers.first != self {
            self.navigationItem.leftBarButtonItem = createBarButtonItem(image: Res.base_black_back, width: width)
        }
    }
    
    /// About to close the current page. Click the back button or gesture to return.
    open func setWillCloseByUserBlock(_ block: @escaping (_ vc: BasicsViewController) -> Void) {
        self.willCloseByUserBlock = block
    }
    
    /// It has been successfully closed. Click the back button or gesture to return.
    open func setClosedByUserComplete(_ block: @escaping (_ vc: BasicsViewController) -> Void) {
        self.closedByUserCompletionBlock = block
    }
    
    /// Customize the back button click event.
    @objc dynamic open func backAction() {
        popoutOrDismiss()
    }
    
    open func popoutOrDismiss(completion: (() -> Void)? = nil) {
        self.isPopedFromBackButton = true
        self.willCloseByUserBlock?(self)
        if self.presentingViewController != nil {
            if let count = self.navigationController?.viewControllers.count, count > 1, self.navigationController?.topViewController == realSelf {
                popout(completion: completion)
            } else if self.navigationController?.children[0] == self {
                self.dismiss(animated: true) {
                    completion?()
                    self.closedByUserCompletionBlock?(self)
                }
            } else {
                popout(completion: completion)
            }
        } else {
            popout(completion: completion)
        }
    }
    
    // MARK: - private methods
    
    private var isPopedFromBackButton = false
    private var hasNaviWhenWillDisappear = false
    private var willCloseByUserBlock: ((_ vc: BasicsViewController) -> Void)?
    private var closedByUserCompletionBlock: ((_ vc: BasicsViewController) -> Void)?
    
    private func popout(completion: (() -> Void)? = nil) {
        if let completion = completion {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            self.navigationController?.popViewController(animated: true)
            self.closedByUserCompletionBlock?(self)
            CATransaction.commit()
        } else {
            self.navigationController?.popViewController(animated: true)
            self.closedByUserCompletionBlock?(self)
        }
    }
    
    private func viewDidPopOut() {
        if !self.isPopedFromBackButton {
            self.willCloseByUserBlock?(self)
            self.closedByUserCompletionBlock?(self)
        }
    }
    
    private func createBarButtonItem(image: UIImage?, width: CGFloat) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(BasicsViewController.backAction), for: .touchUpInside)
        button.sizeToFit()
        button.frame = CGRect(x: 0, y: 0, width: width, height: 44)
        button.contentHorizontalAlignment = .left
        return UIBarButtonItem.init(customView: button)
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
        self.hasNaviWhenWillDisappear = self.navigationController != nil
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
        if let controllers = self.navigationController?.viewControllers, !controllers.contains(realSelf) {
            self.viewDidPopOut()
        } else if self.navigationController == nil && hasNaviWhenWillDisappear {
            self.viewDidPopOut()
        }
        navigationController?.viewControllers = viewControllers.compactMap({ vc in
            return vc == self.realSelf ? nil : vc
        })
    }
}
