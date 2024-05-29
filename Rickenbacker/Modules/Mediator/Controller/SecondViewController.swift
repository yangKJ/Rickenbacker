//
//  SecondViewController.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Rickenbacker
import HBDNavigationBar

class SecondViewController: VMViewController<SecondViewModel> {
    
    lazy var clickButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 88)
        button.center = self.view.center
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.green
        button.setTitle("change title", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.rx.tap
            .map { button.titleLabel?.text ?? "" }
            .bind(to: viewModel.changeTitle)
            .disposed(by: disposeBag)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupBindings()
    }
    
    func setupUI() {
        self.view.addSubview(self.clickButton)
        self.hbd_tintColor = UIColor.purple
        self.hbd_barTintColor = UIColor.green
    }
    
    func setupBindings() {
        viewModel.changeTitle
            .bind(to: rx.title)
            .disposed(by: disposeBag)
    }
    
    override func backAction() {
        super.backAction()
    }
}
