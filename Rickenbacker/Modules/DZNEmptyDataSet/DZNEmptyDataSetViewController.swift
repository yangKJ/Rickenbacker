//
//  DZNEmptyDataSetViewController.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import Rickenbacker

class DZNEmptyDataSetViewController: VMTableViewController<EmptyViewModel> {
    
    private static let identifier = "DZNEmptyDataSetCellIdentifier"
    
    lazy var resetBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Refresh",
                                        style: .plain,
                                        target: self,
                                        action: #selector(resetAction))
        return barButton
    }()
    
    override func loadView() {
        super.loadView()
        self.hideFooter = true
        self.enterBeginRefresh = true
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
    }
    
    func setupUI() {
        self.navigationItem.rightBarButtonItem = self.resetBarButton
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.topMargin)
            make.bottom.equalTo(self.view.snp.bottomMargin)
            make.left.right.equalTo(self.view)
        }
    }
    
    func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DZNEmptyDataSetViewController.identifier)
        tableView.rx.modelSelected(String.self).subscribe (onNext: { (element) in
            D.DLog(element)
        }).disposed(by: disposeBag)
    }
    
    func setupBindings() {
        tableView.rx.modelSelected(String.self).subscribe (onNext: { (element) in
            D.DLog(element)
        }).disposed(by: disposeBag)
        
        viewModel.outputs.dataSource.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: DZNEmptyDataSetViewController.identifier)!
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = UIColor.blue
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.textLabel?.text = "\(row + 1). " + element
            return cell
        }
        .disposed(by: disposeBag)
        
        viewModel.isEmptyData.subscribe { (empty) in
            D.DLog(empty.element)
        }.disposed(by: disposeBag)
        
        self.emptyDataSetViewTap.subscribe { [weak self] _ in
            self?.resetAction()
        }.disposed(by: disposeBag)
        
        headerRefreshing.subscribe { [weak self] _ in
            self?.resetAction()
        }.disposed(by: disposeBag)
    }
    
    @objc func resetAction() {
        viewModel.loadData()
    }
}
