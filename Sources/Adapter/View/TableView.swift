//
//  TableView.swift
//  Rickenbacker
//
//  Created by Condy on 2021/10/2.
//

import UIKit

public final class TableView: UITableView {
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 50
        self.backgroundColor = UIColor.clear
        self.sectionHeaderHeight = 0.00001
        self.sectionFooterHeight = 0.00001
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.cellLayoutMarginsFollowReadableWidth = false
        self.tableFooterView = UIView()
        self.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        if #available(iOS 11, *) {
            self.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UITableView {
    /// SwiferSwift: Dequeue reusable UITableViewCell using class name for indexPath
    ///
    /// - Parameters:
    ///   - type: UITableViewCell type.
    ///   - indexPath: location of cell in tableView.
    /// - Returns: UITableViewCell object with associated class name.
    public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: type))")
        }
        return cell
    }
    
    /// SwifterSwift: Register UITableViewCell using class name
    ///
    /// - Parameter type: UITableViewCell type
    public func register<T: UITableViewCell>(withClass type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: type))
    }
}
