//
//  CScrollViewController.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2022/6/4.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Rickenbacker

class CScrollViewController: BaseScrollViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupBindings()
    }
    
    func setupUI() {
        guard let collectionView = scrollView as? CScrollView else { return }
        let width = self.view.frame.size.width / 3 - 10
        collectionView.layout.itemSize = CGSize(width: width, height: width/3*2)
        collectionView.contentInset = UIEdgeInsets(top: navigationHeight, left: 0, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupBindings() {
        guard let collectionView = scrollView as? UICollectionView,
              let viewModel = viewModel as? CScrollViewModel else {
            return
        }
        
        let input = CScrollViewModel.Input(headerRefresh: headerRefreshing, footerRefresh: footerRefreshing)
        let output = viewModel.transform(input: input)
        
        output.items.asObservable().bind(to: collectionView.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath.init(index: row)
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: CScrollView.identifier, for: indexPath)
            item.backgroundColor = UIColor.randomColor
            return item
        }.disposed(by: disposeBag)
        
        emptyDataSetViewTap.subscribe { _ in
            Log.debug("点击了空数据视图")
        }.disposed(by: disposeBag)
    }
}

// 配置空数据展示信息
extension CScrollViewController: DZNEmptyDataSetable {
    
    func DZNEmptyDataSetImage(scrollView: UIScrollView) -> UIImage {
        return R.image("base_network_error_white")
    }
    
    func DZNEmptyDataSetImageTintColor(scrollView: UIScrollView) -> UIColor? {
        return UIColor.blue
    }
    
    func DZNEmptyDataSetTitle(scrollView: UIScrollView) -> NSAttributedString? {
        NSAttributedString(string: R.text("TEXT"))
    }
    
    func DZNEmptyDataSetDescription(scrollView: UIScrollView) -> NSAttributedString? {
        NSAttributedString(string: R.text("上拉刷新可加载更多"))
    }
    
    func DZNEmptyDataSetVerticalOffset(scrollView: UIScrollView) -> CGFloat {
        return 20
    }
    
    func DZNEmptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
