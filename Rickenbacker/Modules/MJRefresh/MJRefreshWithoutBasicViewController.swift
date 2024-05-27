//
//  MJRefreshWithoutBasicViewController.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2024/5/27.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import Rickenbacker

class MJRefreshWithoutBasicViewController: BasicsViewController, HasDisposeBag, ViewRefreshable {
    var refreshScrollView: UIScrollView {
        tableView
    }
    
    var refreshViewModel: ViewModelRefreshable {
        viewModel
    }
    
    var viewModel: MJRefreshViewModel = MJRefreshViewModel()
    
    private static let identifier = "MJRefreshCellIdentifier"
    
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 50
        table.sectionHeaderHeight = 0.00001
        table.sectionFooterHeight = 0.00001
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.cellLayoutMarginsFollowReadableWidth = false
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
    
    lazy var resetBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem.init(title: "Reset", style: .plain, target: nil, action: nil)
        barButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.tableView.mj_header?.rx.beginRefreshing.onNext(())
        }).disposed(by: disposeBag)
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.setupTable()
        self.setupBindings()
        self.setupOptionalRefresh()
    }
    
    func setupInit() {
        self.navigationItem.rightBarButtonItem = self.resetBarButton
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Ces.navigationHeight),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MJRefreshWithoutBasicViewController.identifier)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.modelSelected(String.self).subscribe (onNext: { (element) in
            Log.debug(element)
        }).disposed(by: disposeBag)
    }
    
    func setupBindings() {
        let input = MJRefreshViewModel.Input(headerRefresh: headerRefreshing, footerRefresh: footerRefreshing)
        let output = viewModel.transform(input: input)
        
        output.items.asObservable().bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: MJRefreshWithoutBasicViewController.identifier)!
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = UIColor.blue
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            cell.textLabel?.text = "\(row + 1). " + element
            cell.backgroundColor = ((row % 2) != 0) ? UIColor.cyan : UIColor.green
            return cell
        }.disposed(by: disposeBag)
    }
}

extension MJRefreshWithoutBasicViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ((indexPath.row % 2) != 0) ? 100 : 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log.debug("原始点击事件:\(indexPath.row)")
    }
}
