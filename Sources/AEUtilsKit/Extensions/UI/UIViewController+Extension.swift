//
//  UIViewController+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import UIKit

public extension UIViewController {

    func setTabBarItem(image: UIImage, title: String) {
        tabBarItem.image = image
        tabBarItem.title = title
        
        if CGFloat.screenHeight > CGFloat.sevenHundredFifty {
            tabBarItem.imageInsets = .init(top: .five, left: .zero, bottom: .five * -.one, right: .zero)
            tabBarItem.titlePositionAdjustment = .init(horizontal: .zero, vertical: .five)
        }
    }

    func showHideNavigationBar(isHidden: Bool, animated: Bool = false) {
        navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }

    func showHideTabBar(isHidden: Bool) {
        guard var frame = tabBarController?.tabBar.frame else { return }
        tabBarController?.tabBar.isHidden = isHidden
        
        frame.origin.y = view.frame.height + (isHidden ? CGFloat.eighty : -CGFloat.eighty)
        view.animateView(withDuration: CGFloat.zeroPointThree) { [weak self] in
            self?.tabBarController?.tabBar.frame = frame
        }
    }

    func configureNavigationBar(tintColor: UIColor,
                                backgroundColor: UIColor,
                                font: UIFont,
                                isTitleLeftAligned: Bool? = nil,
                                title: String? = nil,
                                foregroundColor: UIColor? = nil,
                                backImage: UIImage? = nil) {
        let backBarButtonItem: UIBarButtonItem = .init(title: .empty, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.navigationBar.tintColor = tintColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        if let backImage = backImage {
            let backImage = backImage.withAlignmentRectInsets(.init(top: .zero, left: -.ten, bottom: .zero, right: .zero))
            appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        }
        
        appearance.titleTextAttributes = [
            .font: font.withSize(18.0),
            .foregroundColor: foregroundColor ?? UIColor.black
        ]
        appearance.backgroundColor = backgroundColor
        appearance.shadowColor = .clear
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        if let title = title {
            if let isTitleLeftAligned = isTitleLeftAligned, isTitleLeftAligned {
                let leftTitleBarButtonItem: UIBarButtonItem = .init(title: title, style: .plain, target: nil, action: nil)
                leftTitleBarButtonItem.setTitleTextAttributes([
                    .font: font.withSize(18.0),
                    .foregroundColor: foregroundColor ?? UIColor.black
                ], for: [.normal, .disabled])
                
                leftTitleBarButtonItem.isEnabled = false
                navigationItem.leftBarButtonItem = leftTitleBarButtonItem
            } else {
                navigationItem.title = title
            }
        }
    }

    func disableUserInteraction() {
        view.isUserInteractionEnabled = false
    }

    func enableUserInteraction() {
        view.isUserInteractionEnabled = true
    }
}

// MARK: - Action Sheet
public protocol ActionSheetTypeProtocol {
    var title: String { get }
    var style: UIAlertAction.Style? { get }
    var color: UIColor? { get }
}

public typealias ActionSheetTypeCompletion = ((ActionSheetTypeProtocol) -> Void)

public extension UIViewController {

    func showActionSheet(title: String? = nil, actions: [ActionSheetTypeProtocol], completion: @escaping ActionSheetTypeCompletion) {
        let options: UIAlertController = .init(title: nil, message: title, preferredStyle: .actionSheet)
       
        actions.forEach { action in
            let editAction: UIAlertAction = .init(
                title: action.title, style: action.style ?? .default
            ) { _ in
                completion(action)
            }
            if let color = action.color {
                editAction.setValue(color, forKey: "titleTextColor")
            }
            options.addAction(editAction)
        }

        present(options, animated: true, completion: nil)
    }
}

// MARK: - Bar Button Item
public extension UIViewController {

    enum BarButtonPositionType {
        case left
        case right
    }

    typealias BarCompletionHandler = () -> Void

    func addBarButtonItem(image: UIImage, position: BarButtonPositionType = .right, completion: @escaping BarCompletionHandler) {
        let barButtonItem: UIBarButtonItem = .init(image: image) { [completion] in completion() }
        switch position {
        case .left:
            navigationItem.leftBarButtonItem = barButtonItem
        case .right:
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }
}
