//
//  UIViewController+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import UIKit
import SnapKit

public extension UIViewController {
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: animated)
        }
    }

    func presentAsSheet(_ viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            viewController.modalPresentationStyle = .pageSheet
            self.present(viewController, animated: animated, completion: nil)
        }
    }

    func dismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}

public extension UIViewController {

    func setTabBarItem(image: UIImage, title: String) {
        tabBarItem.image = image
        tabBarItem.title = title
        
        if CGFloat.screenHeight > CGFloat.sevenHundredFifty {
            tabBarItem.imageInsets = .init(top: .five, left: .zero, bottom: .five * -.one, right: .zero)
            tabBarItem.titlePositionAdjustment = .init(horizontal: .zero, vertical: .five)
        }
    }

    func setVisibilityOfNavigationBar(to isHidden: Bool, animated: Bool = true) {
        navigationController?.setNavigationBarHidden(isHidden, animated: animated)
    }

    func setVisibilityOfTabBar(to isHidden: Bool) {
        guard var frame = tabBarController?.tabBar.frame else { return }
        tabBarController?.tabBar.isHidden = isHidden

        frame.origin.y = view.frame.size.height + (isHidden ? frame.size.height : -frame.size.height)
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
            let newAction: UIAlertAction = .init(title: action.title, style: action.style ?? .default) { _ in
                completion(action)
            }
            if let color = action.color {
                newAction.setValue(color, forKey: "titleTextColor")
            }
            options.addAction(newAction)
        }

        present(options, animated: true, completion: nil)
    }
}

// MARK: - Alert
public protocol AlertProtocol {
    var title: String { get }
    var style: UIAlertAction.Style? { get }
    var color: UIColor? { get }
}

public typealias AlertCompletion = (AlertProtocol) -> Void

public extension UIViewController {

    func showAlert(title: String, message: String? = nil, actions: [AlertProtocol], completion: @escaping AlertCompletion) {
        let alert: UIAlertController = .init(title: title, message: message, preferredStyle: .alert)

        actions.forEach { action in
            let newAction: UIAlertAction = .init(title: action.title, style: action.style ?? .default) { _ in
                completion(action)
            }
            if let color = action.color {
                newAction.setValue(color, forKey: "titleTextColor")
            }
            alert.addAction(newAction)
        }

        present(alert, animated: true, completion: nil)
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

// MARK: - Toast View Extension
public final class ToastWindow: UIWindow {

    public static let shared: UIWindow = {
        let windowScene = UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first

        let window = UIWindow(windowScene: windowScene!)
        window.backgroundColor = .clear
        window.windowLevel = .alert + .one
        window.isHidden = true
        window.rootViewController = UIViewController()
        return window
    }()
}

public extension UIViewController {
    
    func showToastView(backgroundColor: UIColor, text: String, textColor: UIColor, font: UIFont, duration: CGFloat = .zeroPointThree) {
        let window = ToastWindow.shared
        window.isHidden = false
        
        guard window.subviews.first(where: { $0.tag == 728_364 }) == nil else {
            return
        }
        
        let containerView = UIView()
        containerView.tag = 728_364
        containerView.layer.cornerRadius = .twelve
        containerView.clipsToBounds = true
        containerView.backgroundColor = backgroundColor
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.numberOfLines = .zero
        titleLabel.configure(
            text: text,
            textColor: textColor,
            font: font,
            size: .sixteen
        )
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.twelve)
            make.trailing.equalToSuperview().inset(CGFloat.twelve)
            make.top.equalToSuperview().offset(CGFloat.twelve)
            make.bottom.equalToSuperview().inset(CGFloat.twelve)
        }
        
        let height = CGFloat.fourtyEight
        let topConstraintConstant = -(height + window.safeAreaInsets.top + .four)
        
        window.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.height.equalTo(height).priority(.medium)
            make.top.equalTo(window.safeAreaLayoutGuide.snp.top).offset(topConstraintConstant)
            make.leading.equalToSuperview().offset(CGFloat.sixteen)
            make.trailing.equalToSuperview().inset(CGFloat.sixteen)
        }
        
        window.setNeedsLayout()
        window.layoutIfNeeded()
        
        containerView.snp.updateConstraints { make in
            make.top.equalTo(window.safeAreaLayoutGuide.snp.top).offset(CGFloat.zero)
        }
        
        UIView.animate(
            withDuration: duration,
            delay: .zero,
            options: .curveLinear,
            animations: {
                window.layoutIfNeeded()
            }
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat.three) {
            if containerView.isDescendant(of: window) {
                containerView.snp.updateConstraints { make in
                    make.top.equalTo(window.safeAreaLayoutGuide.snp.top).offset(topConstraintConstant)
                }
                
                UIView.animate(
                    withDuration: duration / .two,
                    delay: .zero,
                    options: .curveLinear,
                    animations: {
                        window.layoutIfNeeded()
                    }, completion: { _ in
                        containerView.removeFromSuperview()
                        ToastWindow.shared.isHidden = true
                    }
                )
            }
        }
    }
}
