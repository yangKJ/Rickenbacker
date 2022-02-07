//
//  HomeViewController.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import Rickenbacker

class HomeViewController: UIViewController {
 
    private static let homeCellIdentifier = "homeCellIdentifier"
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel = HomeViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.rowHeight = 44
        tableView.sectionHeaderHeight = 0.00001
        tableView.sectionFooterHeight = 0.00001
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: HomeViewController.homeCellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupInit()
        self.setupUI()
        self.setupBinding()
    }
    
    func setupInit() {
        self.title = "Case"
        self.view.backgroundColor = UIColor.background
        self.hbd_barShadowHidden = true
    }
    
    func setupUI() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.topMargin)
            make.bottom.equalTo(self.view.snp.bottomMargin)
            make.left.right.equalTo(self.view).inset(0)
        }
    }
    
    func setupBinding() {
        /// 绑定数据源
        viewModel.datasObservable.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = UITableViewCell(style: .value1, reuseIdentifier: HomeViewController.homeCellIdentifier)
            cell.selectionStyle = .none
            cell.textLabel?.textColor = UIColor.defaultTint
            cell.textLabel?.text = "\(row + 1). " + element.rawValue
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            if row % 2 == 0 {
                cell.backgroundColor = UIColor.cell_background?.withAlphaComponent(0.6)
            } else {
                cell.backgroundColor = UIColor.background
            }
            return cell
        }
        .disposed(by: disposeBag)
        
        /// 订阅点击事件
        tableView.rx.modelSelected(ViewControllerType.self).subscribe (onNext: { type in
            let vc: UIViewController = type.viewController
            vc.title = type.rawValue
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
}
