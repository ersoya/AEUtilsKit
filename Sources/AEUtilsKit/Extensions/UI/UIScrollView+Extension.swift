//
//  UIScrollView+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import UIKit

public extension UIScrollView {

    func scrollTo(horizontalPage: Int? = .zero, verticalPage: Int? = .zero) {
        var frame: CGRect = frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? .zero)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? .zero)
        scrollRectToVisible(frame, animated: true)
    }
}

public extension UIScrollView {

    private enum AssociatedObjectKeys {
        static var onRefreshAction = "onRefreshAction"
    }

    private typealias Action = () -> Void

    private var onRefreshAction: Action? {
        get {
            let onRefreshActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.onRefreshAction) as? Action
            return onRefreshActionInstance
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedObjectKeys.onRefreshAction, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
    }

    static var onRefresh: (() -> Void)?

    func addRefreshControl(_ onRefresh: (() -> Void)?) {
        onRefreshAction = onRefresh
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
    }

    @objc func didRefresh() {
        if let action = onRefreshAction {
            action()
        }
    }

    func endRefreshing() {
        refreshControl?.endRefreshing()
        onRefreshAction = nil
    }
}
