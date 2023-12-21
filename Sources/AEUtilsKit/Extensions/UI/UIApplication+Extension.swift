//
//  UIApplication+Extension.swift
//
//
//  Created by Arda Ersoy on 16.12.2023.
//

import Foundation
import UIKit

public extension UIApplication {

    private func topViewController(of viewController: UIViewController) -> UIViewController {
        if let presented = viewController.presentedViewController {
            return topViewController(of: presented)
        } else if let navigation = viewController as? UINavigationController {
            if let visible = navigation.visibleViewController {
                return topViewController(of: visible)
            } else if let last = navigation.topViewController {
                return topViewController(of: last)
            }
            return navigation
        } else if let tabBar = viewController as? UITabBarController {
            if let selected = tabBar.selectedViewController {
                return topViewController(of: selected)
            } else if let first = tabBar.viewControllers?.first {
                return topViewController(of: first)
            }
            return tabBar
        } else {
            return viewController
        }
    }

    @objc func topViewController() -> UIViewController? {
        guard let root = delegate?.window??.rootViewController else { return nil }
        return topViewController(of: root)
    }
}
