//
//  PhoneNumberVerification.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/9/21.
//

import Foundation
import UIKit

class PhoneNumberVerification : UIViewController, UITextFieldDelegate {
    
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
        hl.text = "Hello! Welcome to the Doggystyle team!"
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
        hl.text = "Let’s start by verifying your phone number"
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = 2
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack

        return hl
    }()
    
    lazy var phoneNumberTextField: PhoneTextFieldWithPadding = {
        
        let etfc = PhoneTextFieldWithPadding()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: rubikRegular, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .numberPad
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 10
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 0))
        etfc.clipsToBounds = false
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.layer.borderColor = UIColor.clear.cgColor
        etfc.layer.borderWidth = 1
        etfc.keyboardAppearance = UIKeyboardAppearance.light
        etfc.withFlag = false
        etfc.withPrefix = true
        etfc.withExamplePlaceholder = false
        etfc.addTarget(self, action: #selector(self.handlePhoneNumberTextFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handlePhoneNumberTextFieldBegin), for: .touchDown)
        
        return etfc
        
    }()
    
    let placeHolderPhoneNumberLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "Phone number"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    let typingPhoneNumberLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = coreWhiteColor
        tel.text = "Phone"
        tel.font = UIFont(name: rubikBold, size: 13)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = true
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    lazy var nextButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Next", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 20
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleNextButton), for: .touchUpInside)
        
        return cbf
        
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
        self.view.addSubview(self.phoneNumberTextField)
        self.view.addSubview(self.placeHolderPhoneNumberLabel)
        self.view.addSubview(self.typingPhoneNumberLabel)
        self.view.addSubview(self.nextButton)

        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.dsCompanyLogoImage.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 32).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.subHeaderLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 20).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.subHeaderLabel.sizeToFit()
        
        self.phoneNumberTextField.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 20).isActive = true
        self.phoneNumberTextField.leftAnchor.constraint(equalTo: self.subHeaderLabel.leftAnchor, constant: 0).isActive = true
        self.phoneNumberTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.phoneNumberTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderPhoneNumberLabel.leftAnchor.constraint(equalTo: self.phoneNumberTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderPhoneNumberLabel.centerYAnchor.constraint(equalTo: self.phoneNumberTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderPhoneNumberLabel.sizeToFit()
        
        self.typingPhoneNumberLabel.leftAnchor.constraint(equalTo: self.phoneNumberTextField.leftAnchor, constant: 25).isActive = true
        self.typingPhoneNumberLabel.topAnchor.constraint(equalTo: self.phoneNumberTextField.topAnchor, constant: 14).isActive = true
        self.typingPhoneNumberLabel.sizeToFit()
        
        self.nextButton.topAnchor.constraint(equalTo: self.phoneNumberTextField.bottomAnchor, constant: 20).isActive = true
        self.nextButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.nextButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    @objc func handlePhoneNumberTextFieldChange() {
        if self.phoneNumberTextField.text != "" {
            typingPhoneNumberLabel.isHidden = false
            placeHolderPhoneNumberLabel.isHidden = true
        }
    }
    
    @objc func handlePhoneNumberTextFieldBegin() {
        self.typingPhoneNumberLabel.isHidden = false
        self.placeHolderPhoneNumberLabel.isHidden = true
    }
    
    @objc func handleNextButton() {
        
        let pinNumberEntry = PinNumberEntry()
        pinNumberEntry.modalPresentationStyle = .fullScreen
        pinNumberEntry.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(pinNumberEntry, animated: true)
        
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}