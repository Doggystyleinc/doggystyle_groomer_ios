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
    
    let profileImageView : UIImageView = {
        
        let pv = UIImageView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.backgroundColor = coreLightGrayColor
        pv.contentMode = .scaleAspectFill
        pv.isUserInteractionEnabled = true
        pv.layer.masksToBounds = true
        pv.clipsToBounds = false
        pv.layer.masksToBounds = false
        pv.layer.shadowColor = coreBlackColor.cgColor
        pv.layer.shadowOpacity = 0.2
        pv.layer.shadowOffset = CGSize(width: 2, height: 3)
        pv.layer.shadowRadius = 4
        pv.layer.shouldRasterize = false
       return pv
    }()
    
    let containerView : UIView = {
        
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = coreWhiteColor
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        cv.layer.shadowColor = coreBlackColor.cgColor
        cv.layer.shadowOpacity = 0.2
        cv.layer.shadowOffset = CGSize(width: 2, height: 3)
        cv.layer.shadowRadius = 4
        cv.layer.shouldRasterize = false
        
       return cv
    }()
    
    let accountContainer : UIView = {
        
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = coreWhiteColor
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        cv.layer.shadowColor = coreBlackColor.cgColor
        cv.layer.shadowOpacity = 0.2
        cv.layer.shadowOffset = CGSize(width: 2, height: 3)
        cv.layer.shadowRadius = 4
        cv.layer.shouldRasterize = false
        
       return cv
    }()
    
    let earningsContainer : UIView = {
        
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = coreWhiteColor
        cv.clipsToBounds = false
        cv.layer.masksToBounds = false
        cv.layer.shadowColor = coreBlackColor.cgColor
        cv.layer.shadowOpacity = 0.2
        cv.layer.shadowOffset = CGSize(width: 2, height: 3)
        cv.layer.shadowRadius = 4
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()

    }
    
    func addViews() {
        
        self.view.addSubview(self.dsCompanyLogoImage)
        self.view.addSubview(self.notificationIcon)
        self.view.addSubview(self.containerView)
        self.view.addSubview(self.profileImageView)
        self.view.addSubview(self.accountContainer)
        self.view.addSubview(self.earningsContainer)
        self.view.addSubview(self.nameLabel)

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
        self.profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.profileImageView.layer.cornerRadius = 150/2

        self.containerView.topAnchor.constraint(equalTo: self.profileImageView.centerYAnchor, constant: 0).isActive = true
        self.containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.15).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        self.containerView.layer.cornerRadius = 12
        
        self.accountContainer.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 20).isActive = true
        self.accountContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.15).isActive = true
        self.accountContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.accountContainer.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.accountContainer.layer.cornerRadius = 12
        
        self.earningsContainer.topAnchor.constraint(equalTo: self.accountContainer.bottomAnchor, constant: 20).isActive = true
        self.earningsContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.15).isActive = true
        self.earningsContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.earningsContainer.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.earningsContainer.layer.cornerRadius = 12
        
        self.nameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 20).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 15).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -15).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true


    }
    
    @objc func handleLogout() {
      
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        Database.database().reference().removeAllObservers()
        
        let decisionController = DecisionController()
        let nav = UINavigationController(rootViewController: decisionController)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }
}
  
