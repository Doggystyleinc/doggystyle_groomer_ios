//
//  NotificationsController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/9/21.
//

import Foundation
import UIKit
import Firebase

class NotificationsController : UIViewController {
    
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
        hl.text = "Allow push notifications?"
        hl.font = UIFont(name: dsHeaderFont, size: 24)
        hl.numberOfLines = 1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsFlatBlack
        
        return hl
    }()
    
    let subHeaderLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "Turn on push notifications to get doggy pick up updates and other important details"
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = -1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    lazy var allowNotificationsButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Allow notifications", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleAllowNotificationButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var notNowButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Not now", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreOrangeColor
        cbf.addTarget(self, action: #selector(self.handleNotNowButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    let dogImage : UIImageView = {
        
        let vi = UIImageView()
        vi.translatesAutoresizingMaskIntoConstraints = false
        vi.backgroundColor = .clear
        vi.contentMode = .scaleAspectFit
        vi.isUserInteractionEnabled = false
        let image = UIImage(named: "notification_groomer")?.withRenderingMode(.alwaysOriginal)
        vi.image = image
        
       return vi
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
        self.view.addSubview(self.dogImage)

        self.view.addSubview(self.allowNotificationsButton)
        self.view.addSubview(self.notNowButton)

        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 63).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.dsCompanyLogoImage.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 62).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.subHeaderLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 14).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.subHeaderLabel.sizeToFit()
        
        self.notNowButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -130).isActive = true
        self.notNowButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.notNowButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.notNowButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.allowNotificationsButton.bottomAnchor.constraint(equalTo: self.notNowButton.topAnchor, constant: -20).isActive = true
        self.allowNotificationsButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.allowNotificationsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.allowNotificationsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.dogImage.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 20).isActive = true
        self.dogImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.dogImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        self.dogImage.bottomAnchor.constraint(equalTo: self.allowNotificationsButton.bottomAnchor, constant: 0).isActive = true

    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAllowNotificationButton() {
        groomerOnboardingStruct.groomer_enable_notifications = true
        self.loadAndSave()
    }
    
    @objc func handleNotNowButton() {
        groomerOnboardingStruct.groomer_enable_notifications = false
        self.loadAndSave()
    }
    
    @objc func loadAndSave() {
        
        self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.LOADING_ANIMATION_GENERAL)
       
        Service.shared.FirebaseRegistrationAndLogin { isComplete, response, responseCode, responseMessage  in
            
            print(response)
            print(responseCode)
            print(responseMessage)

            if isComplete {
                self.mainLoadingScreen.cancelMainLoadingScreen()
                self.presentHomeController()
            } else {
                self.mainLoadingScreen.cancelMainLoadingScreen()
                AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "\(responseMessage)") { complete in
                    print("FAIL ERROR")
                    self.navigationController?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func presentHomeController() {
        
        let homeController = HomeController()
        let navVC = UINavigationController(rootViewController: homeController)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.isHidden = true
        navigationController?.present(navVC, animated: true)
        
    }
}

