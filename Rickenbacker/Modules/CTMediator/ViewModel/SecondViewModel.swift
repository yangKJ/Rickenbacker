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
    let setupTitle = BehaviorRelay<String?>(value: nil)
    let changeTitle = PublishRelay<String>()
    
    init(title: String) {
        self.setupTitle.accept(title)
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    //MARK: - inputs
    func changeTitle(_ title: String?) {
        guard let title = title else { return }
        self.inputs.changeTitle.accept(title)
    }
}
