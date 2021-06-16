//
//  ProfilePhotoUploadExt.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 6/15/21.
//

import Foundation
import AVFoundation
import MobileCoreServices
import Photos

extension ProfileController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func checkForGalleryAuth() {
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        
        case .authorized:
            self.openGallery()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                
                if newStatus ==  PHAuthorizationStatus.authorized {
                    self.openGallery()
                }
            })
            
        case .restricted:
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Photo Library Permissions in the Settings application") { (complete) in
                print("Alert presented")
            }
        case .denied:
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Photo Library Permissions in the Settings application") { (complete) in
                print("Alert presented")
            }
        default :
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Photo Library Permissions in the Settings application") { (complete) in
                print("Alert presented")
            }
        }
    }
    
    func openCameraOptions() {
        
        DispatchQueue.main.async {
            
            let ip = UIImagePickerController()
            ip.sourceType = .camera
            ip.mediaTypes = [kUTTypeImage as String] //kUTTypeMovie as String
            ip.allowsEditing = true
            ip.delegate = self
            
            if let topViewController = UIApplication.getTopMostViewController() {
                topViewController.present(ip, animated: true) {
                    
                }
            }
        }
    }
    
    func openGallery() {
        
        DispatchQueue.main.async {
            
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            if let topViewController = UIApplication.getTopMostViewController() {
                topViewController.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true) {
            print("Dismissed the image picker or camera")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {
            
            let mediaType = info[.mediaType] as! CFString
            
            switch mediaType {
            
            case kUTTypeImage :
                
                if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                    
                    self.activityInvoke(shouldStart: true)
                    self.homeController?.uploadProfileImage(imageToUpload: editedImage) { complete in
                        self.fetchJSON()
                        self.activityInvoke(shouldStart: false)
                        UIDevice.vibrateLight()
                    }
                    
                } else if let originalImage = info[.originalImage] as? UIImage  {
                    self.activityInvoke(shouldStart: true)
                    self.homeController?.uploadProfileImage(imageToUpload: originalImage) { complete in
                        self.fetchJSON()
                        self.activityInvoke(shouldStart: false)
                        UIDevice.vibrateLight()
                    }
                    
                } else {
                    print("Failed grabbing the photo")
                }
                
            default : print("SHOULD NOT HIT FOR THE CAMERA PICKER")
                
            }
        }
    }
    
    func activityInvoke(shouldStart : Bool) {
        
        if shouldStart {
            UIView.animate(withDuration: 0.35) {
                self.profileImageView.alpha = 0.25
            } completion: { complete in
                self.activityIndicator.startAnimating()
            }
        } else {
            UIView.animate(withDuration: 0.35) {
                self.profileImageView.alpha = 1.0
            } completion: { complete in
                self.activityIndicator.stopAnimating()
            }
        }
    }
}







