//
//  CameraManager.swift
//  DanaMandiri
//
//  Created by hekang on 2025/10/14.
//

import UIKit
import AVFoundation
import Photos

class CameraManager: NSObject {
    
    static let shared = CameraManager()
    private var imagePicker: UIImagePickerController?
    private var completion: ((UIImage?) -> Void)?
    
    private override init() {
        super.init()
    }
    
    func takePhoto(_ type: String? = "", completion: @escaping (UIImage?) -> Void) {
        self.completion = completion
        
        checkCameraPermission { [weak self] granted in
            guard let self = self else { return }
            
            if granted {
                DispatchQueue.main.async {
                    self.presentCamera(type)
                }
            } else {
                DispatchQueue.main.async {
                    self.showPermissionAlert()
                }
            }
        }
    }
    
    private func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion(granted)
            }
        case .denied, .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    private func showPermissionAlert() {
        let alert = UIAlertController(
            title: LanguageManager.localizedString(for: "Camera permission is disabled"),
            message: LanguageManager.localizedString(for: "Please enable camera permission in Settings to use the camera"),
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: LanguageManager.localizedString(for: "Cancel"), style: .cancel) { _ in
            self.completion?(nil)
        }
        
        let settingsAction = UIAlertAction(title: LanguageManager.localizedString(for: "Settings"), style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
            self.completion?(nil)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        
        if let topViewController = getTopViewController() {
            topViewController.present(alert, animated: true)
        }
    }
    
    private func presentCamera(_ type: String? = "") {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            completion?(nil)
            return
        }
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .camera
        imagePicker?.allowsEditing = false
        
        if type == "1" {
            imagePicker?.cameraDevice = .front
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let imagePicker = self.imagePicker {
                    self.hideSwitchButton(in: imagePicker.view)
                }
            }
        }else {
            imagePicker?.cameraDevice = .rear
        }
        
        if let topViewController = getTopViewController() {
            topViewController.present(imagePicker!, animated: true)
        }
    }
    
    private func getTopViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return nil
        }
        
        var topController = window.rootViewController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    
    private func compressImage(_ image: UIImage, maxFileSize: Int = 500 * 1024) -> UIImage? {
        var compression: CGFloat = 1.0
        let maxCompression: CGFloat = 0.1
        let maxSize = maxFileSize
        
        guard var imageData = image.jpegData(compressionQuality: compression) else {
            return image
        }
        
        if imageData.count <= maxSize {
            return UIImage(data: imageData)
        }
        
        while imageData.count > maxSize && compression > maxCompression {
            compression -= 0.1
            if let newData = image.jpegData(compressionQuality: compression) {
                imageData = newData
            } else {
                break
            }
        }
        
        return UIImage(data: imageData)
    }
}

extension CameraManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let originalImage = info[.originalImage] as? UIImage {
            let compressedImage = compressImage(originalImage)
            completion?(compressedImage)
        } else {
            completion?(nil)
        }
        
        imagePicker = nil
        completion = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        completion?(nil)
        imagePicker = nil
        completion = nil
    }
}

extension CameraManager {
    
    private func hideSwitchButton(in view: UIView) {
        for subview in view.subviews {
            if let button = subview as? UIButton, String(describing: button).contains("CAMFlipButton") {
                button.isHidden = true
            } else {
                hideSwitchButton(in: subview)
            }
        }
    }
    
}
