//
//  PermissionManager.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation
import AppTrackingTransparency
import Photos

public enum PermissionManager {
    
    public static func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    break
                case .denied:
                    break
                case .notDetermined:
                    break
                case .restricted:
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    public typealias CompletionHandler = (_ isAuthorized: Bool) -> Void
    
    public static func requestCameraAuthorization(completionHandler: @escaping CompletionHandler) {
        guard AVCaptureDevice.authorizationStatus(for: .video) != .authorized else {
            completionHandler(true)
            return
        }
        
        AVCaptureDevice.requestAccess(for: .video) { granted in
            completionHandler(granted)
        }
    }
    
    public static func requestPhotoLibraryAuthorization(completionHandler: @escaping CompletionHandler) {
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            completionHandler(true)
            return
        }
        
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                DispatchQueue.main.async {
                    handleAuthorizationStatus(status, completionHandler)
                }
            }
        } else {
            let status = PHPhotoLibrary.authorizationStatus()
            handleAuthorizationStatus(status, completionHandler)
        }
    }
    
    private static func handleAuthorizationStatus(_ status: PHAuthorizationStatus,
                                                  _ completionHandler: @escaping CompletionHandler) {
        switch status {
        case .notDetermined, .restricted, .denied:
            completionHandler(false)
        case .authorized, .limited:
            completionHandler(true)
        @unknown default:
            completionHandler(false)
        }
    }
}
