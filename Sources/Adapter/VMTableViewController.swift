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
    public private(set) var style: UITableView.Style
    public private(set) var tableView: UITableView
    
    public convenience init(_ style: UITableView.Style = .plain) {
        self.init(style: style, viewModel: T.init())
    }
    
    public convenience init(style: UITableView.Style = .plain, viewModel: T) {
        let table = UITableView.init(frame: .zero, style: style)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 50
        table.sectionHeaderHeight = 0.00001
        table.sectionFooterHeight = 0.00001
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.cellLayoutMarginsFollowReadableWidth = false
        table.tableFooterView = UIView()
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        if #available(iOS 11, *) {
            table.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
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
        self.setupTableView()
    }
    
    final func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: Ces.navigationHeight, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        tableView.rx.itemSelected.bind { [weak self] in
            self?.tableView.deselectRow(at: $0, animated: false)
        }.disposed(by: disposeBag)
    }
}
