//
//  VMTableViewController.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import RxSwift
import RxCocoa

open class VMTableViewController<T: ViewModel>: VMScrollViewController<T> {
    
    public var clearsSelectionOnViewWillAppear = false
    public let style: UITableView.Style
    public let tableView: UITableView
    
    public convenience init(_ style: UITableView.Style = .plain) {
        self.init(style: style, viewModel: T.init())
    }
    
    public convenience init(style: UITableView.Style = .plain, viewModel: T) {
        let table = Self.createTableView(UITableView.self, style: style)
        self.init(tableView: table, viewModel: viewModel)
    }
    
    public init(tableView: UITableView, viewModel: T) {
        self.style = tableView.style
        self.tableView = tableView
        super.init(scrollView: tableView, viewModel: viewModel)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if clearsSelectionOnViewWillAppear, let rows = tableView.indexPathsForSelectedRows {
            rows.forEach({ (indexPath) in
                tableView.deselectRow(at: indexPath, animated: false)
            })
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.rx.itemSelected.bind { [weak self] in
            self?.tableView.deselectRow(at: $0, animated: false)
        }.disposed(by: disposeBag)
    }
}

extension VMTableViewController {
    /// 创建通用列表
    public static func createTableView<_Tp: UITableView>(_ type: _Tp.Type = _Tp.self, style: UITableView.Style) -> _Tp {
        let table = _Tp.init(frame: .zero, style: style)
        table.rowHeight = 44
        table.estimatedRowHeight = UITableView.automaticDimension
        table.sectionHeaderHeight = 0.002
        table.sectionFooterHeight = 0.002
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.cellLayoutMarginsFollowReadableWidth = false
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        if #available(iOS 11, *) {
            table.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        if style == .grouped {
            table.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.1))
        }
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.1))
        return table
    }
}
