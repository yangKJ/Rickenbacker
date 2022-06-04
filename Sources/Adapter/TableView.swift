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
