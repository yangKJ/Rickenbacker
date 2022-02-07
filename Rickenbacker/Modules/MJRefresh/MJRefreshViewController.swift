//
//  MJRefreshViewController.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import Rickenbacker

class MJRefreshViewController: VMTableViewController<MJRefreshViewModel> {

    lazy var resetBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem.init(title: "Reset", style: .plain, target: nil, action: nil)
        barButton.rx.tap
            .bind(to: tableView.mj_header!.rx.beginRefreshing)
            .disposed(by: disposeBag)
        return barButton
    }()
    
    override func loadView() {
        super.loadView()
        // 这个必须写在`viewDidLoad`
//        let footer = MJRefreshAutoFooter()
//        footer.triggerAutomaticallyRefreshPercent = -5
//        tableView.mj_footer = footer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.setupUI()
        self.setupTable()
        self.setupBindings()
    }
    
    func setupInit() {
        self.hbd_barShadowHidden = true
        self.navigationItem.rightBarButtonItem = self.resetBarButton
    }
    
    func setupUI() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.topMargin)
            make.bottom.equalTo(self.view.snp.bottomMargin)
            make.left.right.equalTo(self.view)
        }
    }
    
    func setupTable() {
        tableView.register(withClass: UITableViewCell.self)
        tableView.rx.modelSelected(String.self).subscribe (onNext: { (element) in
            D.DLog(element)
        }).disposed(by: disposeBag)
    }
    
    func setupBindings() {
        let input = MJRefreshViewModel.Input(headerRefresh: headerRefreshing,
                                             footerRefresh: footerRefreshing)
        let output = viewModel.transform(input: input)
        
        output.items.asObservable().bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(with: UITableViewCell.self, for: IndexPath(index: row))
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = UIColor.blue
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.text = "\(row + 1). " + element
            return cell
        }
        .disposed(by: disposeBag)
    }
}
