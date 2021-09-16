//
//  WelcomeController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/9/21.
//

import Foundation
import UIKit

class WelcomeController : UIViewController, UITextViewDelegate {
    
    let mainLoadingScreen = MainLoadingScreen()
    
    var topContainer : UIView = {
        
        let tc = UIView()
        tc.translatesAutoresizingMaskIntoConstraints = false
        tc.backgroundColor = coreOrangeColor
        tc.isUserInteractionEnabled = true
        
       return tc
    }()
    
    var bottomContainer : UIView = {
        
        let tc = UIView()
        tc.translatesAutoresizingMaskIntoConstraints = false
        tc.backgroundColor = coreBackgroundWhite
        tc.isUserInteractionEnabled = true
        
       return tc
    }()
    
    lazy var registrationButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Register", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleRegistrationButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var applyButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Apply to Doggystyle", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreOrangeColor
        cbf.addTarget(self, action: #selector(self.handleApplyButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var termsTextView : UITextView = {
        
        let tv = UITextView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor .clear
        
        var myMutableString = NSMutableAttributedString()
        
        let partOne = "Need Grooming?"
        let partTwo = " Get the Doggystyle app"
        
        let screenHeight = UIScreen.main.bounds.height
        var fontSize : CGFloat = 12
        
        myMutableString = NSMutableAttributedString(string: partOne + partTwo as String, attributes: [NSAttributedString.Key.font:UIFont(name: rubikRegular, size: 14)!])
        
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: dsDeepBlue.withAlphaComponent(1.0), range: NSRange(location:0,length:partOne.count))
        
        myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: rubikRegular, size: fontSize)!, range: NSRange(location: 0,length:partOne.count))
        
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: dsDeepBlue.withAlphaComponent(1.0), range: NSRange(location:partOne.count,length:partTwo.count))
        
        myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: rubikRegular, size: fontSize)!, range: NSRange(location: partOne.count,length:partTwo.count))
        
        myMutableString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: partOne.count,length:partTwo.count))
       
        _ = myMutableString.setAsLink(textToFind: "Get the Doggystyle app", linkURL: Statics.DOGGYSTYLE_CONSUMER_APP_URL)
        
        tv.linkTextAttributes = [
            .foregroundColor: dsDeepBlue,
            .underlineColor: dsDeepBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font : dsHeaderFont
        ]
        
        tv.attributedText = myMutableString
        tv.layer.masksToBounds = true
        tv.textAlignment = .center
        tv.delegate = self
        tv.isUserInteractionEnabled = true
        tv.isScrollEnabled = true
        tv.isEditable = false
        tv.isSelectable = true
        
        return tv
        
    }()
    
    lazy var loginButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Login", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 16)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = .clear
        cbf.layer.cornerRadius = 13
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.layer.borderWidth = 1
        cbf.layer.borderColor = coreWhiteColor.cgColor
        cbf.addTarget(self, action: #selector(self.handleLoginButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    let dsLogoImage : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = false
        let image = UIImage(named: "ds_white_logo")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        
        return dcl
    }()
    
    let welcomeLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Welcome to the Doggystylist app!"
        thl.font = UIFont(name: dsHeaderFont, size: 28)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreWhiteColor
        return thl
        
    }()
    
    let vanImage : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFill
        dcl.isUserInteractionEnabled = false
        let image = UIImage(named: "stylist_van_image")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        
        return dcl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.topContainer)
        self.view.addSubview(self.bottomContainer)
        
        self.bottomContainer.addSubview(self.registrationButton)
        self.bottomContainer.addSubview(self.applyButton)
        self.bottomContainer.addSubview(self.termsTextView)
        
        self.topContainer.addSubview(self.loginButton)
        self.topContainer.addSubview(self.dsLogoImage)
        self.topContainer.addSubview(self.welcomeLabel)
        self.topContainer.addSubview(self.vanImage)

        self.bottomContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.bottomContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.bottomContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.bottomContainer.heightAnchor.constraint(equalToConstant: self.view.frame.height / 3).isActive = true

        self.topContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.topContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.topContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.topContainer.bottomAnchor.constraint(equalTo: self.bottomContainer.topAnchor, constant: 0).isActive = true
        
        self.registrationButton.topAnchor.constraint(equalTo: self.bottomContainer.topAnchor, constant: 25).isActive = true
        self.registrationButton.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 30).isActive = true
        self.registrationButton.rightAnchor.constraint(equalTo: self.bottomContainer.rightAnchor, constant: -30).isActive = true
        self.registrationButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.applyButton.topAnchor.constraint(equalTo: self.registrationButton.bottomAnchor, constant: 20).isActive = true
        self.applyButton.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 30).isActive = true
        self.applyButton.rightAnchor.constraint(equalTo: self.bottomContainer.rightAnchor, constant: -30).isActive = true
        self.applyButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.termsTextView.bottomAnchor.constraint(equalTo: self.bottomContainer.bottomAnchor, constant: -30).isActive = true
        self.termsTextView.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 30).isActive = true
        self.termsTextView.rightAnchor.constraint(equalTo: self.bottomContainer.rightAnchor, constant: -30).isActive = true
        self.termsTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.loginButton.topAnchor.constraint(equalTo: self.topContainer.topAnchor, constant: 58).isActive = true
        self.loginButton.rightAnchor.constraint(equalTo: self.topContainer.rightAnchor, constant: -25).isActive = true
        self.loginButton.widthAnchor.constraint(equalToConstant: 82).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.dsLogoImage.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 50).isActive = true
        self.dsLogoImage.leftAnchor.constraint(equalTo: self.topContainer.leftAnchor, constant: 59).isActive = true
        self.dsLogoImage.widthAnchor.constraint(equalToConstant: 106).isActive = true
        self.dsLogoImage.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        self.welcomeLabel.topAnchor.constraint(equalTo: self.dsLogoImage.bottomAnchor, constant: 20).isActive = true
        self.welcomeLabel.leftAnchor.constraint(equalTo: self.dsLogoImage.leftAnchor, constant: 0).isActive = true
        self.welcomeLabel.rightAnchor.constraint(equalTo: self.topContainer.rightAnchor, constant: -30).isActive = true
        self.welcomeLabel.sizeToFit()
        
        self.vanImage.topAnchor.constraint(equalTo: self.dsLogoImage.bottomAnchor, constant: 0).isActive = true
        self.vanImage.leftAnchor.constraint(equalTo: self.topContainer.leftAnchor, constant: 0).isActive = true
        self.vanImage.rightAnchor.constraint(equalTo: self.topContainer.rightAnchor, constant: 0).isActive = true
        self.vanImage.bottomAnchor.constraint(equalTo: self.topContainer.bottomAnchor, constant: -40).isActive = true
        
    }

    
    @objc func handleRegistrationButton() {
        
        let phoneNumberVerification = PhoneNumberVerification()
        let nav = UINavigationController(rootViewController: phoneNumberVerification)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        
        //BUILDER STRUCT - RESET WHEN HITTING THE REGISTRATION FLOW
        groomerOnboardingStruct = GroomerOnboardingStruct()
        self.navigationController?.present(nav, animated: true, completion: {
            print("Onboarding has began")
        })
    }
    
    @objc func handleApplyButton() {
        print("Apply button")
    }
    
    @objc func handleLoginButton() {
        let loginController = LoginController()
        loginController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(loginController, animated: true)
    }
}
