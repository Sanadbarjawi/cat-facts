//
//  UIScrollView+PullToRefresh.swift
//  CatFacts
//
//  Created by sanad barjawi on 26/01/2022.
//

import UIKit

extension UIScrollView {

    func addPulltoRefreshControl(controller: UIViewController,
                                 doing action: Selector,
                                 with attributedString: NSAttributedString? = nil,
                                 tintColor: UIColor? = nil) {

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(controller, action: action, for: .valueChanged)
        refreshControl.attributedTitle = attributedString
        refreshControl.tintColor = tintColor
        self.refreshControl = refreshControl
    }

    func beginRefreshing() {
        self.refreshControl?.beginRefreshing()
    }

    func endRefreshing() {
        self.refreshControl?.endRefreshing()
    }
}
