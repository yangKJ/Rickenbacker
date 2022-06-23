//
//  MJRefreshViewController.swift
//  Rickenbacker_Example
//
//  Created by Condy on 2021/10/3.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Rickenbacker

class MJRefreshViewController: VMTableViewController<MJRefreshViewModel> {
    
    private static let identifier = "MJRefreshCellIdentifier"
    
    lazy var resetBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem.init(title: "Reset", style: .plain, target: nil, action: nil)
        barButton.rx.tap
            .bind(to: tableView.mj_header!.rx.beginRefreshing)
            .disposed(by: disposeBag)
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.setupTable()
        self.setupBindings()
    }
    
    func setupInit() {
        self.hbd_barShadowHidden = true
        self.navigationItem.rightBarButtonItem = self.resetBarButton
    }
    
    func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MJRefreshViewController.identifier)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.rx.modelSelected(String.self).subscribe (onNext: { (element) in
            Log.debug(element)
        }).disposed(by: disposeBag)
    }
    
    func setupBindings() {
        let input = MJRefreshViewModel.Input(headerRefresh: headerRefreshing, footerRefresh: footerRefreshing)
        let output = viewModel.transform(input: input)
        
        output.items.asObservable().bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: MJRefreshViewController.identifier)!
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

extension MJRefreshViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ((indexPath.row % 2) != 0) ? 100 : 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log.debug("原始点击事件:\(indexPath.row)")
    }
}
