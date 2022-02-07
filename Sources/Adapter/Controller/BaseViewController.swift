//
//  BaseViewController.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import Foundation
import UIKit

@objc(BaseViewController)
open class BaseViewController: UIViewController {

    @objc public lazy var backBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: R.image("base_black_back"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(BaseViewController.backAction))
        barButton.imageInsets.left = 5
        return barButton
    }()
    
    deinit {
        D.DLog("🎷<\(D.split(String(describing: self))): Deinited")
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        D.DLog("🎷<\(D.split(String(describing: self))): didReceiveMemoryWarning")
    }
    
    @objc public var navigationTitle = "" {
        didSet {
            self.navigationItem.title = navigationTitle
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = self.backBarButton
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    // MARK: - action
    @objc dynamic open func backAction() {
        if (self.navigationController?.children[0] == self) {
            self.dismiss(animated: true, completion:nil)
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
}
