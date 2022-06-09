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
    public private(set) var style: UITableView.Style = UITableView.Style.plain
    public private(set) var tableView: TableView
    
    public convenience init(_ style: UITableView.Style = UITableView.Style.plain) {
        self.init(style: style, viewModel: T.init())
    }
    
    public init(style: UITableView.Style = UITableView.Style.plain, viewModel: T) {
        self.style = style
        self.tableView = TableView.init(frame: .zero, style: style)
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
        tableView.rx.itemSelected.bind { [weak self] in
            self?.tableView.deselectRow(at: $0, animated: false)
        }.disposed(by: disposeBag)
    }
}
