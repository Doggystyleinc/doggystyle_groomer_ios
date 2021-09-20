//
//  DriversLicenseController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//

import Foundation
import UIKit


class DriverLicenseController : UIViewController {
    
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
        hl.text = "Drivers License"
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
        hl.text = "Please take a photo of your driver’s license. Make sure your information is visible and clear in the photo."
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = 2
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    lazy var driversLicenseImageButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 85, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .creditCard), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        cbf.clipsToBounds = true
        cbf.isUserInteractionEnabled = false
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
//        cbf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleCustomPhotoController)))
        
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
//        cbf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handlePhotoLibrarySelection)))

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
    
    lazy var documentsButton: UIView = {
        
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
//        cbf.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handlePhotoLibrarySelection)))

        return cbf
        
    }()
    
    var documentsIcon : UIButton = {
        
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
    
    let documentsLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Documents"
        thl.font = UIFont(name: rubikMedium, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreBlackColor
        return thl
        
    }()
    
    lazy var lookingGoodButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Submit", for: UIControl.State.normal)
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
//        cbf.addTarget(self, action: #selector(self.handleLookingGoodButton), for: .touchUpInside)
        
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
        self.view.addSubview(self.driversLicenseImageButton)
        self.driversLicenseImageButton.addSubview(self.activityIndicator)
        
        self.view.addSubview(self.cameraButton)
        self.cameraButton.addSubview(self.cameraIcon)
        self.cameraButton.addSubview(self.cameraLabel)

        self.view.addSubview(self.photoLibraryButton)
        self.photoLibraryButton.addSubview(self.photoLibraryIcon)
        self.photoLibraryButton.addSubview(self.photoLibraryLabel)
        
        self.view.addSubview(self.documentsButton)
        self.documentsButton.addSubview(self.documentsIcon)
        self.documentsButton.addSubview(self.documentsLabel)
        
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
        
        self.driversLicenseImageButton.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 31).isActive = true
        self.driversLicenseImageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.driversLicenseImageButton.heightAnchor.constraint(equalToConstant: 142).isActive = true
        self.driversLicenseImageButton.widthAnchor.constraint(equalToConstant: 142).isActive = true
        self.driversLicenseImageButton.layer.cornerRadius = 71
        
        self.cameraButton.topAnchor.constraint(equalTo: self.driversLicenseImageButton.bottomAnchor, constant: 26).isActive = true
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
        
        self.documentsButton.topAnchor.constraint(equalTo: self.photoLibraryButton.bottomAnchor, constant: 10).isActive = true
        self.documentsButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.documentsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.documentsButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        
        self.documentsIcon.rightAnchor.constraint(equalTo: self.documentsButton.rightAnchor, constant: -22).isActive = true
        self.documentsIcon.centerYAnchor.constraint(equalTo: self.documentsButton.centerYAnchor, constant: 0).isActive = true
        self.documentsIcon.heightAnchor.constraint(equalToConstant: 22).isActive = true
        self.documentsIcon.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        self.documentsLabel.leftAnchor.constraint(equalTo: self.documentsButton.leftAnchor, constant: 31).isActive = true
        self.documentsLabel.rightAnchor.constraint(equalTo: self.documentsIcon.leftAnchor, constant: -20).isActive = true
        self.documentsLabel.centerYAnchor.constraint(equalTo: self.documentsButton.centerYAnchor, constant: 0).isActive = true
        self.documentsLabel.sizeToFit()
        
        self.lookingGoodButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.lookingGoodButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.lookingGoodButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -53).isActive = true
        self.lookingGoodButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    @objc func handleBackButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}