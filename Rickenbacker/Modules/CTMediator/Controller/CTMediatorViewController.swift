//
//  CTMediatorViewController.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Rickenbacker

class CTMediatorViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var pushButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = self.view.center
        button.backgroundColor = UIColor.yellow
        button.setTitle("CTMediator", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        self.view.addSubview(button)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bingViewModel()
    }
    
    func bingViewModel() {
        
        if let vc = CTMediator.shared.Second_viewController(title: "biaoti") {
            pushButton.rx.tap
                .bind(to: rx.pushViewController(vc, animated: true))
                .disposed(by: disposeBag)
        }
    }
}
