//
//  SecondViewModel.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Rickenbacker

class SecondViewModel: ViewModel {
    
    //MARK: - outputs
    let changeTitle = BehaviorRelay<String?>(value: nil)
    
    init(title: String) {
        self.changeTitle.accept(title)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
