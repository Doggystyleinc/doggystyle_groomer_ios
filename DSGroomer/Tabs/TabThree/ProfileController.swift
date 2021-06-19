//
//  TertiaryController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//

import Foundation
import Firebase

class ProfileController : UIViewController {
    
    var homeController : HomeController?
    let storageRef = Storage.storage().reference(),
        databaseRef = Database.database().reference()
    
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
    
    lazy var notificationIcon : UIButton = {
        
        let dcl = UIButton(type: .system)
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = true
        let image = UIImage(named: "share_button")?.withRenderingMode(.alwaysOriginal)
        dcl.setBackgroundImage(image, for: .normal)
        dcl.clipsToBounds = false
        dcl.layer.masksToBounds = false
        dcl.layer.shadowColor = coreBlackColor.cgColor
        dcl.layer.shadowOpacity = 0.2
        dcl.layer.shadowOffset = CGSize(width: 2, height: 3)
        dcl.layer.shadowRadius = 4
        dcl.layer.shouldRasterize = false
        dcl.addTarget(self, action: #selector(self.handleLogout), for: .touchUpInside)
        
        return dcl
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
        
        return cv
    }()
    
    let nameLabel : UILabel = {
        
        let nl = UILabel()
        nl.translatesAutoresizingMaskIntoConstraints = false
        nl.backgroundColor = .clear
        nl.text = "Annie Schultz"
        nl.font = UIFont(name: dsHeaderFont, size: 20)
        nl.textColor = coreBlackColor
        nl.textAlignment = .center
        nl.adjustsFontSizeToFitWidth = true
        
        return nl
    }()
    
    lazy var profileCollectionSubview : ProfileCollectionSubview = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let dh = ProfileCollectionSubview(frame: .zero, collectionViewLayout: layout)
        dh.profileController = self
        return dh
        
    }()
    
    let activityIndicator : UIActivityIndicatorView = {
        
        let ai = UIActivityIndicatorView(style: .medium)
        ai.hidesWhenStopped = true
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.color = coreOrangeColor
        ai.backgroundColor = coreBlackColor.withAlphaComponent(0.5)
        return ai
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        self.fetchJSON()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //GOOD IDEA TO CHECK THIS EVERYTIME THE VIEW LOADS, INCASE THEY CHANGE THEIR PHOTO, NAME ETC.
        self.fetchJSON()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.dsCompanyLogoImage)
        self.view.addSubview(self.notificationIcon)
        self.view.addSubview(self.containerView)
        self.view.addSubview(self.profileImageView)
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.profileCollectionSubview)
        self.view.addSubview(self.activityIndicator)
        
        self.dsCompanyLogoImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.dsCompanyLogoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2.5).isActive = true
        self.dsCompanyLogoImage.sizeToFit()
        
        self.notificationIcon.centerYAnchor.constraint(equalTo: self.dsCompanyLogoImage.centerYAnchor, constant: 0).isActive = true
        self.notificationIcon.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.notificationIcon.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.notificationIcon.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.profileImageView.topAnchor.constraint(equalTo: self.dsCompanyLogoImage.bottomAnchor, constant: 20).isActive = true
        self.profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        self.profileImageView.layer.cornerRadius = 130/2
        
        self.containerView.topAnchor.constraint(equalTo: self.profileImageView.centerYAnchor, constant: 0).isActive = true
        self.containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.15).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.containerView.layer.cornerRadius = 12
        
        self.nameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 15).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 15).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -15).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.profileCollectionSubview.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 20).isActive = true
        self.profileCollectionSubview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.profileCollectionSubview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.profileCollectionSubview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.activityIndicator.topAnchor.constraint(equalTo: self.dsCompanyLogoImage.bottomAnchor, constant: 20).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant: 130).isActive = true
        self.activityIndicator.widthAnchor.constraint(equalToConstant: 130).isActive = true
        self.activityIndicator.layer.cornerRadius = 130/2
        
    }
    
    func fetchJSON() {
        
        //DATA SHOULD BE FILLED ON APPLICATION LOAD AFTER AUTHENTICATION OR SIGN IN
        let is_groomer = userProfileStruct.is_groomer ?? false
        if is_groomer {
            let usersName = userProfileStruct.groomers_full_name ?? "DOG LOVER"
            self.nameLabel.text = usersName
        } else {
            let usersName = userProfileStruct.usersName ?? "DOG LOVER"
            self.nameLabel.text = usersName
        }
        
        //THROW A DEFAULT PHOTO IN STORAGE AND GRAB THE URL THEN REPLACE "nil" WITH THE URL
        let userProfilePhoto = userProfileStruct.userProfileImageURL ?? "nil"
        self.profileImageView.loadImageGeneralUse(userProfilePhoto) { complete in
            print("Profile photo has been loaded.")
        }
    }
    
    @objc func handleProfileSelection(sender : UIImageView) {
        print("handle profile selection")
    }
    
    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
            return
        }
        
        Database.database().reference().removeAllObservers()
        
        let decisionController = DecisionController()
        let nav = UINavigationController(rootViewController: decisionController)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }
}
