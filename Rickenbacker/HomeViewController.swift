//
//  HomeViewController.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
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
        tableView.backgroundColor = R.color("background")
        //tableView.separatorStyle = .none
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
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
        self.view.backgroundColor = R.color("background")
        self.hbd_barShadowHidden = true
    }
    
    func setupUI() {
        self.view.addSubview(self.tableView)
        tableView.contentInset = UIEdgeInsets(top: C.navigationHeight, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupBinding() {
        /// 绑定数据源
        viewModel.datasObservable.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = UITableViewCell(style: .value1, reuseIdentifier: HomeViewController.homeCellIdentifier)
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = R.color("defaultTint")
            cell.textLabel?.text = "\(row + 1). " + element.rawValue
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            return cell
        }.disposed(by: disposeBag)
        
        /// 订阅点击事件
        tableView.rx.modelSelected(ViewControllerType.self)
            .subscribe (onNext: { [weak self] in
                let vc: UIViewController = $0.viewController
                vc.title = $0.rawValue
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
}
