//
//  UIBarButtonItem+Extension.swift
//
//
//  Created by Arda Ersoy on 16.12.2023.
//

import Foundation
import UIKit

private var actionKey: Void?

public extension UIBarButtonItem {
    
    private var _action: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &actionKey) as? () -> Void
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    convenience init(image: UIImage, action: @escaping () -> Void) {
        self.init(image: image, style: .plain, target: nil, action: #selector(pressed))
        target = self
        _action = action
    }
    
    @objc private func pressed(sender _: UIBarButtonItem) {
        _action?()
    }
}
