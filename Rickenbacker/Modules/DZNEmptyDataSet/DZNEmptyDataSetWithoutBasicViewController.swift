//
//  DZNEmptyDataSetWithoutBasicViewController.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Rickenbacker
import HBDNavigationBar

class DZNEmptyDataSetWithoutBasicViewController: BasicsViewController, ViewEmptiable, HasDisposeBag {
    
    var viewModel: EmptyViewModel = EmptyViewModel()
    
    var emptyViewModel: Rickenbacker.ViewModelEmptiable {
        viewModel
    }
    
    var emptyScrollView: UIScrollView {
        tableView
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .grouped)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 50
        table.sectionHeaderHeight = 0.00001
        table.sectionFooterHeight = 0.00001
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.cellLayoutMarginsFollowReadableWidth = false
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: Ces.width, height: 0.1))
        table.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: Ces.width, height: 0.1))
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        table.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11, *) {
            table.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        return table
    }()
    
    private static let identifier = "DZNEmptyDataSetCellIdentifier"
    
    lazy var resetBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Refresh",
                                        style: .plain,
                                        target: self,
                                        action: #selector(resetAction))
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.setupUI()
        self.setupTable()
        self.setupBindings()
        self.setupOptionalEmptyData()
        self.resetAction()
    }
    
    func setupInit() {
        self.hbd_barShadowHidden = true
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = self.resetBarButton
        tableView.rowHeight = 66
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DZNEmptyDataSetWithoutBasicViewController.identifier)
    }
    
    func setupBindings() {
        tableView.rx.modelSelected(String.self).subscribe (onNext: { (element) in
            Log.debug(element)
        }).disposed(by: disposeBag)
        
        viewModel.datas.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: DZNEmptyDataSetWithoutBasicViewController.identifier)!
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = UIColor.blue
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
            cell.textLabel?.text = "\(row + 1). " + element
            cell.backgroundColor = ((row % 2) != 0) ? UIColor.red.withAlphaComponent(0.3) : UIColor.red
            return cell
        }.disposed(by: disposeBag)
        
        viewModel.isEmptyData.subscribe { (empty) in
            Log.debug(empty.element)
        }.disposed(by: disposeBag)
        
        emptyDataSetViewTap.subscribe { [weak self] _ in
            Log.debug("点击了空数据视图")
            self?.resetAction()
        }.disposed(by: disposeBag)
    }
    
    @objc func resetAction() {
        viewModel.loadData()
    }
}

// 配置空数据展示信息
extension DZNEmptyDataSetWithoutBasicViewController: DZNEmptyDataSetable {
    
    func DZNEmptyDataSetImage(scrollView: UIScrollView) -> UIImage {
        return Res.image("base_network_error_black")
    }
    
    func DZNEmptyDataSetImageTintColor(scrollView: UIScrollView) -> UIColor? {
        return UIColor.red
    }
    
    func DZNEmptyDataSetTitle(scrollView: UIScrollView) -> NSAttributedString? {
        NSAttributedString(string: Res.text("TEXT"))
    }
    
    func DZNEmptyDataSetDescription(scrollView: UIScrollView) -> NSAttributedString? {
        NSAttributedString(string: Res.text("测试网络异常展示"))
    }
    
    func DZNEmptyDataSetVerticalOffset(scrollView: UIScrollView) -> CGFloat {
        return 20
    }
}
