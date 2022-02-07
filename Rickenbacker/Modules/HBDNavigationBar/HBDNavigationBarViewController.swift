//
//  HBDNavigationBarViewController.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Rickenbacker

class HBDNavigationBarViewController: BaseViewController {

    lazy var backButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 10, y: 44, width: 44, height: 44)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.setImage(R.image("base_black_close"), for: .normal)
        return button
    }()
    
    lazy var pushButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = self.view.center
        button.backgroundColor = UIColor.yellow
        button.setTitle("CTMediator", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hbd_barHidden = true
        self.hbd_blackBarStyle = true
        self.view.backgroundColor = UIColor.green
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.pushButton)
    }
    
    @objc func pushAction() {
        let vc = SecondViewController.init()
        vc.viewModel = SecondViewModel.init(title: self.title!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc override func backAction() {
        super.backAction()
    }
}
