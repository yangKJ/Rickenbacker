//
//  RxUIViewController.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/5/2.
//  Copyright © 2018年 Pircate. All rights reserved.
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
