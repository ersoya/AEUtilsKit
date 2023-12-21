//
//  UIImageView+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import UIKit
import Kingfisher

public extension UIImageView {

    func setAdvancedKfImage(with url: String) {
        let url: URL? = URL(string: url)
        kf.setImage(with: url)
    }
}
