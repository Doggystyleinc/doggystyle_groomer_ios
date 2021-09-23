//
//  CompleteProfileController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/23/21.
//

import Foundation
import Firebase
import UIKit
import AVFoundation
import MobileCoreServices
import Photos

class CompleteProfileController : UIViewController {
    
    var dashboardController : DashboardController?,
        selectedImage : UIImage?
    
    let mainLoadingScreen = MainLoadingScreen()
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.tintColor = coreOrangeColor
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    let headerLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "Complete profile"
        hl.font = UIFont(name: dsHeaderFont, size: 24)
        hl.numberOfLines = 1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        
        return hl
    }()
    
    
    lazy var profileContainer : UIButton = {
        
        let fpc = UIButton(type: .system)
        fpc.translatesAutoresizingMaskIntoConstraints = false
        fpc.backgroundColor = coreWhiteColor
        fpc.isUserInteractionEnabled = true
        fpc.layer.masksToBounds = false
        fpc.layer.cornerRadius = 20
        fpc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        fpc.layer.shadowOpacity = 0.05
        fpc.layer.shadowOffset = CGSize(width: 2, height: 3)
        fpc.layer.shadowRadius = 9
        fpc.layer.shouldRasterize = false
        
        return fpc
    }()
    
    let profileImageView : UIImageView = {
        
        let piv = UIImageView()
        piv.translatesAutoresizingMaskIntoConstraints = false
        piv.backgroundColor = coreBackgroundWhite
        piv.contentMode = .scaleAspectFill
        piv.isUserInteractionEnabled = false
        piv.clipsToBounds = true
        
        return piv
    }()
    
    let headerProfileLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = ""
        thl.font = UIFont(name: dsSubHeaderFont, size: 20)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let headerProfileSubLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Let your team and clients know a little about you"
        thl.font = UIFont(name: rubikRegular, size: 13)
        thl.numberOfLines = 3
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreOrangeColor
        return thl
        
    }()
    
    lazy var pencilIconButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.masksToBounds = true
        cbf.layer.borderColor = coreOrangeColor.cgColor
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 12, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .pencilAlt), for: .normal)
        cbf.setTitleColor(coreWhiteColor, for: .normal)
        cbf.tintColor = coreWhiteColor
        cbf.layer.borderWidth = 2
        cbf.layer.borderColor = coreWhiteColor.cgColor
        cbf.addTarget(self, action: #selector(self.checkForGalleryAuth), for: .touchUpInside)
        
        return cbf
        
    }()
    
    let activityIndicator : UIActivityIndicatorView = {
        
        let ai = UIActivityIndicatorView(style: .medium)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.backgroundColor = .clear
        ai.hidesWhenStopped = true
        
       return ai
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        self.fillValues()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.profileContainer)
        
        self.profileContainer.addSubview(self.profileImageView)
        self.profileContainer.addSubview(self.headerProfileLabel)
        self.profileContainer.addSubview(self.headerProfileSubLabel)
        self.profileContainer.addSubview(self.pencilIconButton)
        
        self.view.addSubview(self.activityIndicator)

        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 32).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.profileContainer.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 15).isActive = true
        self.profileContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.profileContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.profileContainer.heightAnchor.constraint(equalToConstant: 137).isActive = true
        
        self.profileImageView.centerYAnchor .constraint(equalTo: self.profileContainer.centerYAnchor, constant: 0).isActive = true
        self.profileImageView.leftAnchor.constraint(equalTo: self.profileContainer.leftAnchor, constant: 24).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 99).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 99).isActive = true
        self.profileImageView.layer.cornerRadius = 99/2
        
        self.headerProfileLabel.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor, constant: -15).isActive = true
        self.headerProfileLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 25).isActive = true
        self.headerProfileLabel.rightAnchor.constraint(equalTo: self.profileContainer.rightAnchor, constant: -25).isActive = true
        self.headerProfileLabel.sizeToFit()
        
        self.headerProfileSubLabel.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor, constant: 15).isActive = true
        self.headerProfileSubLabel.leftAnchor.constraint(equalTo: self.headerProfileLabel.leftAnchor, constant: 0).isActive = true
        self.headerProfileSubLabel.rightAnchor.constraint(equalTo: self.profileContainer.rightAnchor, constant: -25).isActive = true
        self.headerProfileSubLabel.sizeToFit()
        
        self.pencilIconButton.centerXAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: -13).isActive = true
        self.pencilIconButton.centerYAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: -13).isActive = true
        self.pencilIconButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        self.pencilIconButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        self.pencilIconButton.layer.cornerRadius = 28/2
        
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor, constant: 0).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.profileImageView.centerXAnchor, constant: 0).isActive = true
        self.activityIndicator.sizeToFit()

    }
    
    func fillValues() {
        
        let usersName = groomerUserStruct.groomers_first_name?.capitalizingFirstLetter() ?? "Doggystylist"
        let memberSince = groomerUserStruct.users_sign_up_date?.returnYearFromTimeStamp() ?? "2021"
        let usersProfileImageURL = groomerUserStruct.profile_image_url ?? "nil"
        
        self.headerProfileLabel.text = usersName
        self.headerProfileSubLabel.text = "Doggystyling since \(memberSince)"
        self.profileImageView.loadImageGeneralUse(usersProfileImageURL) { complete in
            print("done")
        }
    }
    
    func uploadImage() {
        
        if self.selectedImage != nil {
            
            guard let safeImage = self.selectedImage else {return}
            
            self.activityInvoke(shouldStart: true)
            
            Service.shared.uploadProfileImage(imageToUpload: safeImage, completion: { isComplete, imageURL  in
                
                if isComplete {
                    
                    groomerUserStruct.profile_image_url = imageURL
                    self.activityInvoke(shouldStart: false)
                    self.dashboardController?.finishProfileSubview.profileImageView.image = safeImage
                    
                } else {
                    
                    AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Photo failed to upload. Please try again. If this issue persists, please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS)") { isComplete in
                        self.handleBackButton()
                    }
                    
                    self.activityInvoke(shouldStart: false)
                    
                }
            })
        }
    }
    
    @objc func handleBackButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension CompleteProfileController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func checkForGalleryAuth() {
        
        UIDevice.vibrateLight()
        
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
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Photo Library Permissions in the Settings application.") { (complete) in
                print("Alert presented")
            }
        case .denied:
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Photo Library Permissions in the Settings application.") { (complete) in
                print("Alert presented")
            }
        default :
            AlertControllerCompletion.handleAlertWithCompletion(title: "Permissions", message: "Please allow Photo Library Permissions in the Settings application.") { (complete) in
                print("Alert presented")
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
            self.selectedImage = nil
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {
            
            let mediaType = info[.mediaType] as! CFString
            
            switch mediaType {
            
            case kUTTypeImage :
                
                if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                    
                    self.profileImageView.image = editedImage
                    self.selectedImage = editedImage
                    self.uploadImage()
                    
                } else if let originalImage = info[.originalImage] as? UIImage  {
                    
                    self.profileImageView.image = originalImage
                    self.selectedImage = originalImage
                    self.uploadImage()

                } else {
                    print("Failed grabbing the photo")
                }
                
            default : print("SHOULD NOT HIT FOR THE CAMERA PICKER")
                
            }
        }
    }
    
    func activityInvoke(shouldStart : Bool) {
        
        if shouldStart {
            self.view.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.35) {
                self.profileImageView.alpha = 0.25
            } completion: { complete in
                self.activityIndicator.startAnimating()
            }
        } else {
            self.view.isUserInteractionEnabled = true
            UIDevice.vibrateLight()
            UIView.animate(withDuration: 0.35) {
                self.profileImageView.alpha = 1.0
            } completion: { complete in
                self.activityIndicator.stopAnimating()
            }
        }
    }
}




