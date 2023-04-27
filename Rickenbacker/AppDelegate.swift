//
//  AppDelegate.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc: HomeViewController = HomeViewController.init()
        let nav = BaseNavigationController.init(rootViewController: vc)
        self.window?.rootViewController = nav
        return true
    }
}
