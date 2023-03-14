//
//  UIViewController+Rx.swift
//  Rickenbacker
//
//  Created by Condy on 2023/3/13.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    /// Push view controller
    /// Example:
    ///
    ///     pushButton.rx.tap
    ///         .bind(to: rx.pushViewController(vc, animated: true))
    ///         .disposed(by: disposeBag)
    ///
    public func pushViewController(_ viewController: @escaping @autoclosure () -> UIViewController,
                                   animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.pushViewController(viewController(), animated: animated)
        }
    }
    
    public func pushViewControllerAndReplace(_ viewController: @escaping @autoclosure () -> UIViewController,
                                             replaceCount: Int,
                                             animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.pushViewControllerAndReplace(viewController(), replaceCount: replaceCount, animated: animated)
        }
    }
    
    public func pushViewController(_ viewController: @escaping @autoclosure () -> UIViewController,
                                   removeType: UIViewController.Type,
                                   animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.pushViewController(viewController(), removeType: removeType, animated: animated)
        }
    }
    
    public func pushViewController(_ viewController: @escaping @autoclosure () -> UIViewController,
                                   removeTypes: [UIViewController.Type],
                                   animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.pushViewController(viewController(), removeTypes: removeTypes, animated: animated)
        }
    }
    
    /// Pop view controller
    /// Example:
    ///
    ///     popButton.rx.tap
    ///        .bind(to: rx.popViewController(animated: false))
    ///        .disposed(by: disposeBag)
    ///
    public func popViewController(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.popViewController(animated: animated)
        }
    }
    
    public func popToRootViewController(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.navigationController?.popToRootViewController(animated: animated)
        }
    }
}

extension Reactive where Base: UIViewController {
    
    public func present(_ viewController: @escaping @autoclosure () -> UIViewController,
                        animated: Bool = true,
                        completion: (() -> Void)? = nil) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.present(viewController(), animated: animated, completion: completion)
        }
    }
    
    public func dismiss(animated: Bool = true) -> Binder<Void> {
        return Binder(base) { this, _ in
            this.dismiss(animated: animated, completion: nil)
        }
    }
}
