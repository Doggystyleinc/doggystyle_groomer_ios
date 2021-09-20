//
//  GroomerProfilePhoto.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/16/21.
//

import Foundation
import UIKit
import AVFoundation
import MobileCoreServices
import Photos


class GroomerProfileController : UIViewController {
    
    var selectedImage : UIImage?
    var dashboardController : DashboardController?
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
    
    let dsCompanyLogoImage : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = false
        let image = UIImage(named: "ds_orange_logo")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        
        return dcl
    }()
    
    let headerLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "Profile Photo"
        hl.font = UIFont(name: dsHeaderFont, size: 24)
        hl.numberOfLines = 2
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    let subHeaderLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "This is how doggy owners will recognize you for pickups and dropoffs. Smile!"
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = 2
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    lazy var profileImageview : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 65, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .user), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        cbf.layer.borderColor = coreOrangeColor.cgColor
        cbf.layer.borderWidth = 1
        cbf.isUserInteractionEnabled = false
        cbf.clipsToBounds = true
        cbf.imageView?.contentMode = .scaleAspectFill
        cbf.contentMode = .scaleAspectFill
        
        return cbf
        
    }()
    
    lazy var cameraButton: UIView = {
        
        let cbf = UIView()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.layer.masksToBounds = true
        cbf.backgroundColor = coreWhiteColor
        cbf.layer.masksToBounds = false
        cbf.tintColor = dsFlatBlack
        cbf.clipsToBounds = false
        cbf.layer.masksToBounds = false
        cbf.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        cbf.layer.shadowOpacity = 0.05
        cbf.layer.shadowOffset = CGSize(width: 2, height: 3)
        cbf.layer.shadowRadius = 9
        cbf.layer.shouldRasterize = false
        cbf.layer.cornerRadius = 10
        cbf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleCustomPhotoController)))
        
        return cbf
        
    }()
    
    var cameraIcon : UIButton = {
        
        let ci = UIButton()
        ci.backgroundColor = .clear
        ci.translatesAutoresizingMaskIntoConstraints = false
        ci.contentMode = .scaleAspectFill
        ci.isUserInteractionEnabled = false
        ci.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
        ci.setTitle(String.fontAwesomeIcon(name: .camera), for: .normal)
        ci.setTitleColor(dsFlatBlack, for: .normal)
       
        return ci
        
    }()
    
    let cameraLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Camera"
        thl.font = UIFont(name: rubikMedium, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreBlackColor
        return thl
        
    }()
    
    lazy var photoLibraryButton: UIView = {
        
        let cbf = UIView()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.layer.masksToBounds = true
        cbf.backgroundColor = coreWhiteColor
        cbf.layer.masksToBounds = false
        cbf.tintColor = dsFlatBlack
        cbf.clipsToBounds = false
        cbf.layer.masksToBounds = false
        cbf.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        cbf.layer.shadowOpacity = 0.05
        cbf.layer.shadowOffset = CGSize(width: 2, height: 3)
        cbf.layer.shadowRadius = 9
        cbf.layer.shouldRasterize = false
        cbf.layer.cornerRadius = 10
        cbf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handlePhotoLibrarySelection)))

        return cbf
        
    }()
    
    var photoLibraryIcon : UIButton = {
        
        let ci = UIButton()
        ci.backgroundColor = .clear
        ci.translatesAutoresizingMaskIntoConstraints = false
        ci.contentMode = .scaleAspectFill
        ci.isUserInteractionEnabled = false
        ci.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
        ci.setTitle(String.fontAwesomeIcon(name: .image), for: .normal)
        ci.setTitleColor(dsFlatBlack, for: .normal)
       
        return ci
        
    }()
    
    let photoLibraryLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Photo Library"
        thl.font = UIFont(name: rubikMedium, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreBlackColor
        return thl
        
    }()
    
    lazy var lookingGoodButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Done", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.alpha = 0.5
        cbf.isEnabled = false
        cbf.addTarget(self, action: #selector(self.handleLookingGoodButton), for: .touchUpInside)
        
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
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.dsCompanyLogoImage)
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.subHeaderLabel)
        self.view.addSubview(self.profileImageview)
        self.profileImageview.addSubview(self.activityIndicator)
        
        self.view.addSubview(self.cameraButton)
        self.cameraButton.addSubview(self.cameraIcon)
        self.cameraButton.addSubview(self.cameraLabel)

        self.view.addSubview(self.photoLibraryButton)
        self.photoLibraryButton.addSubview(self.photoLibraryIcon)
        self.photoLibraryButton.addSubview(self.photoLibraryLabel)
        
        self.view.addSubview(self.lookingGoodButton)

        self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 17).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.dsCompanyLogoImage.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 30).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.subHeaderLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 15).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.subHeaderLabel.sizeToFit()
        
        self.profileImageview.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 31).isActive = true
        self.profileImageview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.profileImageview.heightAnchor.constraint(equalToConstant: 142).isActive = true
        self.profileImageview.widthAnchor.constraint(equalToConstant: 142).isActive = true
        self.profileImageview.layer.cornerRadius = 71
        
        self.cameraButton.topAnchor.constraint(equalTo: self.profileImageview.bottomAnchor, constant: 26).isActive = true
        self.cameraButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.cameraButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.cameraButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        
        self.cameraIcon.rightAnchor.constraint(equalTo: self.cameraButton.rightAnchor, constant: -22).isActive = true
        self.cameraIcon.centerYAnchor.constraint(equalTo: self.cameraButton.centerYAnchor, constant: 0).isActive = true
        self.cameraIcon.heightAnchor.constraint(equalToConstant: 22).isActive = true
        self.cameraIcon.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        self.cameraLabel.leftAnchor.constraint(equalTo: self.cameraButton.leftAnchor, constant: 31).isActive = true
        self.cameraLabel.rightAnchor.constraint(equalTo: self.cameraIcon.leftAnchor, constant: -20).isActive = true
        self.cameraLabel.centerYAnchor.constraint(equalTo: self.cameraButton.centerYAnchor, constant: 0).isActive = true
        self.cameraLabel.sizeToFit()

        self.photoLibraryButton.topAnchor.constraint(equalTo: self.cameraButton.bottomAnchor, constant: 10).isActive = true
        self.photoLibraryButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.photoLibraryButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.photoLibraryButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        
        self.photoLibraryIcon.rightAnchor.constraint(equalTo: self.photoLibraryButton.rightAnchor, constant: -22).isActive = true
        self.photoLibraryIcon.centerYAnchor.constraint(equalTo: self.photoLibraryButton.centerYAnchor, constant: 0).isActive = true
        self.photoLibraryIcon.heightAnchor.constraint(equalToConstant: 22).isActive = true
        self.photoLibraryIcon.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        self.photoLibraryLabel.leftAnchor.constraint(equalTo: self.photoLibraryButton.leftAnchor, constant: 31).isActive = true
        self.photoLibraryLabel.rightAnchor.constraint(equalTo: self.photoLibraryIcon.leftAnchor, constant: -20).isActive = true
        self.photoLibraryLabel.centerYAnchor.constraint(equalTo: self.photoLibraryButton.centerYAnchor, constant: 0).isActive = true
        self.photoLibraryLabel.sizeToFit()
        
        self.lookingGoodButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.lookingGoodButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.lookingGoodButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -53).isActive = true
        self.lookingGoodButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.profileImageview.centerYAnchor, constant: 0).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.profileImageview.centerXAnchor, constant: 0).isActive = true
        self.activityIndicator.sizeToFit()

    }
    
    @objc func handleProfileImageTap() {
        print("profile photo tap")
    }
    
    @objc func handleLookingGoodButton() {
        
        if self.selectedImage != nil {
            
            guard let safeSelectedImage = self.selectedImage else {return}
            
            self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.LOADING_ANIMATION_GENERAL)
            
            self.dashboardController?.homeController?.uploadProfileImage(imageToUpload: safeSelectedImage, completion: { isComplete in
                
                if isComplete {
                    
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    self.handleBackButton()
                    
                } else {
                    
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Photo failed to upload. Please try again. If this issue persists, please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS)") { isComplete in
                        self.handleBackButton()
                    }
                }
            })
        }
    }
    
    @objc func handlePhotoLibrarySelection() {
        self.checkForGalleryAuth()
    }
    
    @objc func handleCustomPhotoController() {
        
        let customPhotoController = CustomPhotoController()
        customPhotoController.groomerProfileController = self
        let nav = UINavigationController(rootViewController: customPhotoController)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @objc func handleBackButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func undoPhoto() {
        
        self.profileImageview.titleLabel?.font = UIFont.fontAwesome(ofSize: 65, style: .solid)
        self.profileImageview.setTitle(String.fontAwesomeIcon(name: .user), for: .normal)
        self.lookingGoodButton.alpha = 0.5
        self.lookingGoodButton.isEnabled = false
        self.lookingGoodButton.setTitle("Done", for: .normal)
        self.activityInvoke(shouldStart: false)
        self.profileImageview.setBackgroundImage(UIImage(), for: .normal)
        self.selectedImage = nil
        
    }
}

extension GroomerProfileController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            print("Dismissed the image picker or camera")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {
            
            let mediaType = info[.mediaType] as! CFString
            
            switch mediaType {
            
            case kUTTypeImage :
                
                if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                    
                    self.profileImageview.setTitle("", for: .normal)
                    self.lookingGoodButton.alpha = 1
                    self.lookingGoodButton.isEnabled = true
                    self.lookingGoodButton.setTitle("Looking good!", for: .normal)
                    self.activityInvoke(shouldStart: true)
                    self.profileImageview.setImage(editedImage, for: .normal)
                    self.activityInvoke(shouldStart: false)
                    self.selectedImage = editedImage
                    
                } else if let originalImage = info[.originalImage] as? UIImage  {
                    
                    self.profileImageview.setTitle("", for: .normal)
                    self.lookingGoodButton.alpha = 1
                    self.lookingGoodButton.isEnabled = true
                    self.lookingGoodButton.setTitle("Looking good!", for: .normal)
                    self.activityInvoke(shouldStart: true)
                    self.profileImageview.setImage(originalImage, for: .normal)
                    self.activityInvoke(shouldStart: false)
                    self.selectedImage = originalImage

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
                self.profileImageview.alpha = 0.25
            } completion: { complete in
                self.activityIndicator.startAnimating()
            }
        } else {
            UIView.animate(withDuration: 0.35) {
                self.profileImageview.alpha = 1.0
            } completion: { complete in
                self.activityIndicator.stopAnimating()
            }
        }
    }
}



