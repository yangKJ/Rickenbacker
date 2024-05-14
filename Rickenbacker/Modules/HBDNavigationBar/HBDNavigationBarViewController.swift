//
//  HBDNavigationBarViewController.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Rickenbacker
import HBDNavigationBar

class HBDNavigationBarViewController: BasicsViewController {
    
    lazy var backButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 10, y: Ces.statusBarHeight, width: 44, height: 44)
        button.setImage(Res.image("base_black_close"), for: .normal)
        button.rx.tap.subscribe { [weak self] _ in
            self?.backAction()
        }.disposed(by: rx.disposeBag)
        return button
    }()
    
    lazy var pushButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = self.view.center
        button.backgroundColor = UIColor.yellow
        button.setTitle("CTMediator", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.rx.tap.subscribe { [weak self] _ in
            let vm = SecondViewModel.init(title: self?.title ?? "")
            let vc = SecondViewController.init(viewModel: vm)
            self?.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: rx.disposeBag)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hbd_barHidden = true
        self.hbd_blackBarStyle = true
        self.view.backgroundColor = UIColor.gray
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.pushButton)
    }
}
