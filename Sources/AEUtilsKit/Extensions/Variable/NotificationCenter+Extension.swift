//
//  NotificationCenter+Extension.swift
//  AEUtilsKit
//
//  Created by Arda Ersoy on 26.01.2026.
//

import Foundation

extension NotificationCenter {
    
    static func post(name: NSNotification.Name, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
    }
}
