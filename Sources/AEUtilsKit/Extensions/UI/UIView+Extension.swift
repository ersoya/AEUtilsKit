//
//  UIView+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import UIKit

public extension UIView {

    private enum AssociatedObjectKeys {
        static var tapGestureRecognizer = "TapGestureObjectKey"
    }

    private typealias Action = () -> Void

    private var tapGestureRecognizerAction: Action? {
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self,
                                                                              &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self,
                                         &AssociatedObjectKeys.tapGestureRecognizer,
                                         newValue,
                                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
    }

    func addTapGestureRecognizer(numberOfTaps: Int? = nil, _ action: (() -> Void)?) {
        if let action = action {
            isUserInteractionEnabled = true
            tapGestureRecognizerAction = action
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
            if let numberOfTaps = numberOfTaps {
                tapGestureRecognizer.numberOfTapsRequired = numberOfTaps
            }
            addGestureRecognizer(tapGestureRecognizer)
        }
    }

    @objc private func handleTapGesture(sender _: UITapGestureRecognizer) {
        if let action = tapGestureRecognizerAction {
            action()
        }
    }
}

public extension UIView {

    func loadViewFromNib(in bundle: Bundle) -> UIView? {
        let identifier = String(describing: type(of: self))
        let nib = UINib(nibName: identifier, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    func animateView(withDuration: TimeInterval = CGFloat.zeroPointTwo, onAnimate: @escaping () -> Void) {
        UIView.animate(withDuration: withDuration, delay: .zero) { [weak self, onAnimate] in
            onAnimate()
            self?.layoutIfNeeded()
        }
    }
    
    func addGradientLayer(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: .zero, y: .zero, width: .screenWidth, height: .screenHeight)
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.shouldRasterize = true
        gradientLayer.colors = colors
        layer.insertSublayer(gradientLayer, at: .zero)
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let roundedLayer = CAShapeLayer()
        roundedLayer.path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        ).cgPath
        layer.mask = roundedLayer
    }
    
    var safeAreaHeight: CGFloat {
        safeAreaLayoutGuide.layoutFrame.size.height
    }
}

public extension UIView {

    @IBInspectable
    var radius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var topRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            let path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: newValue, height: newValue))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            layer.mask = maskLayer
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let shadowColor = layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowOpacity: CGFloat {
        get {
            return CGFloat(layer.shadowOpacity)
        }
        set {
            layer.shadowOpacity = Float(newValue)
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
