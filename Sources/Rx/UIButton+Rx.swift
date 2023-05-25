//
//  UIButton+Rx.swift
//  Rickenbacker
//
//  Created by Condy on 2023/5/12.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {
    
    /// Will make the button behaves like a button of System Type.
    /// - Parameter minAlpha: Minimum transparency value.
    public func makeSystemButtonType(minAlpha: CGFloat = 0.5) {
        func setAlpha(_ alpha: CGFloat) {
            UIView.animate(withDuration: 0.25, delay: 0, options: .beginFromCurrentState, animations: {
                self.base.alpha = alpha
            }, completion: nil)
        }
        base.rx.methodInvoked(#selector(UIView.touchesBegan(_:with:)))
            .subscribe(onNext: { _ in
                setAlpha(minAlpha)
            }).disposed(by: base.rx.disposeBag)
        
        let cancelObservables = [
            #selector(UIView.touchesEnded),
            #selector(UIView.touchesCancelled),
        ].map { base.rx.methodInvoked($0) }
        Observable.merge(cancelObservables)
            .subscribe(onNext: { _ in
                setAlpha(1)
            }).disposed(by: base.rx.disposeBag)
    }
}
