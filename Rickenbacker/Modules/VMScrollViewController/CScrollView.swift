//
//  CScrollView.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2022/6/4.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Rickenbacker

class CScrollView: UICollectionView {
    
    static let identifier = "CScrollCellIdentifier"
    
    let layout: UICollectionViewFlowLayout
    
    init(viewModel: CScrollViewModel) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
        layout.minimumLineSpacing = 5
        self.layout = layout
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        self.setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: CScrollView.identifier)
        rx.setDelegate(self).disposed(by: rx.disposeBag)
        rx.modelSelected(String.self).subscribe (onNext: { (element) in
            Log.debug(element)
        }).disposed(by: rx.disposeBag)
    }
}

extension CScrollView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Log.debug("原始点击事件:\(indexPath.row)")
    }
}

