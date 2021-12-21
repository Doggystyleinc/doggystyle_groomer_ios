//
//  TertiaryController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//

import Foundation
import Firebase

class ProfileController : UIViewController, CustomAlertCallBackProtocol {
    
    var homeController : HomeController?,
        shouldExpandClockedCell : Bool = false
    
    let mainLoadingScreen = MainLoadingScreen()
    
    let headerLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Profile"
        thl.font = UIFont(name: rubikMedium, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    lazy var profileImageView : UIImageView = {
        
        let pv = UIImageView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.backgroundColor = coreLightGrayColor
        pv.contentMode = .scaleAspectFill
        pv.isUserInteractionEnabled = true
        pv.layer.masksToBounds = true
        pv.clipsToBounds = true
        pv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.checkForGalleryAuth)))
        return pv
    }()
    
    let containerView : UIView = {
        
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = coreWhiteColor
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        cv.layer.shadowColor = coreBlackColor.cgColor
        cv.layer.shadowOpacity = 0.1
        cv.layer.shadowOffset = CGSize(width: 0, height: 0)
        cv.layer.shadowRadius = 7
        cv.layer.shouldRasterize = false
        cv.layer.cornerRadius = 15
        
        return cv
    }()
    
    let nameLabel : UILabel = {
        
        let nl = UILabel()
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.backgroundColor = .clear
        nl.text = ""
        nl.font = UIFont(name: dsHeaderFont, size: 20)
        nl.textColor = dsFlatBlack
        nl.textAlignment = .left
        nl.adjustsFontSizeToFitWidth = true
        nl.numberOfLines = 1
        
        return nl
    }()
    
    let stylingSinceLabel : UILabel = {
        
        let nl = UILabel()
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.backgroundColor = .clear
        nl.text = ""
        nl.font = UIFont(name: rubikRegular, size: 13)
        nl.textColor = coreOrangeColor
        nl.textAlignment = .left
        nl.adjustsFontSizeToFitWidth = true
        nl.numberOfLines = 1
        
        return nl
    }()
  
    let activityIndicator : UIActivityIndicatorView = {
        
        let ai = UIActivityIndicatorView(style: .medium)
        ai.hidesWhenStopped = true
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.color = coreOrangeColor
        ai.backgroundColor = coreBlackColor.withAlphaComponent(0.5)
        return ai
    }()
    
    lazy var pencilIcon : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 15, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .pencilAlt), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        cbf.addTarget(self, action: #selector(self.handleEditProfilePencil), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    lazy var profileCollectionSubview : ProfileCollectionSubview = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let dh = ProfileCollectionSubview(frame: .zero, collectionViewLayout: layout)
        dh.profileController = self
        return dh
        
    }()
    
    lazy var slideToConfirmComponent : SwipeToConfirmClockInSubview = {
        
       let sc = SwipeToConfirmClockInSubview()
       sc.profileController = self
       return sc
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        self.fetchJSON()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.headerLabel)
        
        self.view.addSubview(self.containerView)
        self.containerView.addSubview(self.profileImageView)
        self.containerView.addSubview(self.nameLabel)
        self.containerView.addSubview(self.stylingSinceLabel)
        self.containerView.addSubview(self.pencilIcon)
        
        self.view.addSubview(self.profileCollectionSubview)
        self.view.addSubview(self.slideToConfirmComponent)

        self.headerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.containerView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 34).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 147).isActive = true
        
        self.profileImageView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: 0).isActive = true
        self.profileImageView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 20).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 107).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 107).isActive = true
        self.profileImageView.layer.cornerRadius = 107/2
        
        self.nameLabel.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor, constant: -12).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 20).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -30).isActive = true
        self.nameLabel.sizeToFit()
        
        self.stylingSinceLabel.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor, constant: 12).isActive = true
        self.stylingSinceLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 20).isActive = true
        self.stylingSinceLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -30).isActive = true
        self.stylingSinceLabel.sizeToFit()
        
        self.pencilIcon.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 18).isActive = true
        self.pencilIcon.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -18).isActive = true
        self.pencilIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pencilIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.profileCollectionSubview.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 20).isActive = true
        self.profileCollectionSubview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.profileCollectionSubview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.profileCollectionSubview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.slideToConfirmComponent.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -44).isActive = true
        self.slideToConfirmComponent.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.slideToConfirmComponent.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.slideToConfirmComponent.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    func fetchJSON() {
      
        let userProfilePhoto = groomerUserStruct.profile_image_url ?? "nil"
        let first = groomerUserStruct.groomers_first_name ?? "nil"
        let last = groomerUserStruct.groomers_last_name ?? "nil"
        let users_name = "\(first) \(last)"
        self.nameLabel.text = users_name
        
        let accountCreationDate = Auth.auth().currentUser?.metadata.creationDate ?? nil
        
        if accountCreationDate == nil {
            self.stylingSinceLabel.text = "Doggystyling since 2021"
        } else {
            
            guard let dateFetch = accountCreationDate else {return}
            
            let calendar = Calendar.current
            let registrationYear = calendar.component(.year, from: dateFetch)
            self.stylingSinceLabel.text = "Doggystyling since \(registrationYear)"
            
        }
        
        if userProfilePhoto == "nil" {
            self.profileImageView.image = UIImage(named: "Owner Profile Placeholder")?.withRenderingMode(.alwaysOriginal)
        } else {
            self.profileImageView.loadImageGeneralUse(userProfilePhoto) { complete in
            }
        }
    }
    
    @objc func handleClockInButton() {
        print("handleClockInButton")
    }
    @objc func handleEarningsAndReviews() {

        //MARK: - PRESENT IF THEIR ARE NO DOGS IN THEIR PROFILE
        let earningsAndReviews = EarningsAndReviews()
        let nav = UINavigationController(rootViewController: earningsAndReviews)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationController?.navigationBar.isHidden = true
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    @objc func handleNotificationManagementController() {
        
        //MARK: - PRESENT IF THEIR ARE NO DOGS IN THEIR PROFILE
        let notificationManagement = NotificationManagement()
        let nav = UINavigationController(rootViewController: notificationManagement)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationController?.navigationBar.isHidden = true
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }
    @objc func handlePaymentPreferences() {
        print("handlePaymentPreferences")
        self.handleCustomPopUpAlert(title: "🚨", message: "Payment preferences will be available shortly.", passedButtons: [Statics.GOT_IT])
    }
    
    @objc func handleSwipeToClockIn() {
        print("********")
        print(self.profileCollectionSubview.arrayOfStaticLabels[0])
        self.profileCollectionSubview.arrayOfStaticLabels[0] = "Clocked into truck #signal"
        print(self.profileCollectionSubview.arrayOfStaticLabels[0])
        DispatchQueue.main.async {
            self.profileCollectionSubview.reloadData()
            for i in self.profileCollectionSubview.arrayOfStaticLabels {
                print(i)
            }
        }
    }
   
    @objc func handleCustomPopUpAlert(title : String, message : String, passedButtons: [String]) {
        
        self.mainLoadingScreen.cancelMainLoadingScreen()
        
        let alert = AlertController()
        alert.passedTitle = title
        alert.passedMmessage = message
        alert.passedButtonSelections = passedButtons
        alert.customAlertCallBackProtocol = self
        alert.passedIconName = .infoCircle
        alert.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(alert, animated: true, completion: nil)
        
    }
    
    func onSelectionPassBack(buttonTitleForSwitchStatement type: String) {
        
        switch type {
        
        case Statics.GOT_IT: print(Statics.GOT_IT)
        case Statics.OK: print(Statics.OK)
            
        default: print("Should not hit")
            
        }
    }
    
    @objc func handleBackButton() {
        
    }
    
    @objc func handleEditProfilePencil() {
        print("edit pencil icon bro")
        self.handleCustomPopUpAlert(title: "🚨", message: "Editing will be available shortly", passedButtons: [Statics.GOT_IT])
    }
}




import Foundation
import UIKit
import AVFoundation
import MobileCoreServices
import Photos

extension ProfileController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            self.handleCustomPopUpAlert(title: "PERMISSIONS", message: "Please allow Photo Library Permissions in the Settings application.", passedButtons: [Statics.OK])
        case .denied:
            self.handleCustomPopUpAlert(title: "PERMISSIONS", message: "Please allow Photo Library Permissions in the Settings application.", passedButtons: [Statics.OK])
        default :
            self.handleCustomPopUpAlert(title: "PERMISSIONS", message: "Please allow Photo Library Permissions in the Settings application.", passedButtons: [Statics.OK])
        }
    }
    
    func openCameraOptions() {
        
        DispatchQueue.main.async {
            
            let ip = UIImagePickerController()
            ip.sourceType = .camera
            ip.mediaTypes = [kUTTypeImage as String]
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
                    self.profileImageView.image = editedImage
                    self.homeController?.uploadProfileImage(imageToUpload: editedImage) { complete in
                        self.fetchJSON()
                        self.activityInvoke(shouldStart: false)
                        UIDevice.vibrateLight()
                    }
                    
                } else if let originalImage = info[.originalImage] as? UIImage  {
                    self.activityInvoke(shouldStart: true)
                    self.profileImageView.image = originalImage
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








    
  
