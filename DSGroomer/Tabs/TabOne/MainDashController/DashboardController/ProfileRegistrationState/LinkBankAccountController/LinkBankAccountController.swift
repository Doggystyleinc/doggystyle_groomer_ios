//
//  LinkBankAccountController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//

import Foundation
import UIKit


class LinkBankAccountController : UIViewController, UITextFieldDelegate {
    
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
        dcl.isHidden = true
        
        return dcl
    }()
    
    let headerLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "Link Bank Account"
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
        hl.text = "Please enter your checking account details. This information can be found on your checks or online banking portal."
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = 2
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    lazy var routingNumberTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "Routing number", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .left
        etfc.textColor = coreGrayColor
        etfc.font = UIFont(name: rubikMedium, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.keyboardAppearance = UIKeyboardAppearance.default
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .numberPad
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 15
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.layer.borderColor = slotGrey.cgColor
        etfc.layer.borderWidth = 1
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))

        return etfc
        
    }()
    
    lazy var accountNumberTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "Account number", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .left
        etfc.textColor = coreGrayColor
        etfc.font = UIFont(name: rubikMedium, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.keyboardAppearance = UIKeyboardAppearance.default
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .numberPad
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 15
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.layer.borderColor = slotGrey.cgColor
        etfc.layer.borderWidth = 1
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))

        return etfc
        
    }()
    
    lazy var confirmAccountNumberTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "Confirm account number", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .left
        etfc.textColor = coreGrayColor
        etfc.font = UIFont(name: rubikMedium, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.keyboardAppearance = UIKeyboardAppearance.default
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .numberPad
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 15
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.layer.borderColor = slotGrey.cgColor
        etfc.layer.borderWidth = 1
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))

        return etfc
        
    }()
    
    lazy var saveAndContinueButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Send", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 20
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleSaveAndContinueButton), for: .touchUpInside)
        
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
        self.view.addSubview(self.routingNumberTextField)
        self.view.addSubview(self.accountNumberTextField)
        self.view.addSubview(self.confirmAccountNumberTextField)
        self.view.addSubview(self.saveAndContinueButton)

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
        
        self.routingNumberTextField.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 30).isActive = true
        self.routingNumberTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.routingNumberTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.routingNumberTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.accountNumberTextField.topAnchor.constraint(equalTo: self.routingNumberTextField.bottomAnchor, constant: 20).isActive = true
        self.accountNumberTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.accountNumberTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.accountNumberTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.confirmAccountNumberTextField.topAnchor.constraint(equalTo: self.accountNumberTextField.bottomAnchor, constant: 20).isActive = true
        self.confirmAccountNumberTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.confirmAccountNumberTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.confirmAccountNumberTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.saveAndContinueButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.saveAndContinueButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.saveAndContinueButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -53).isActive = true
        self.saveAndContinueButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    @objc func handleSaveAndContinueButton() {
        
        let linkBankSuccessController = LinkBankSuccessController()
        linkBankSuccessController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(linkBankSuccessController, animated: true)
        
    }
    
    @objc func handleBackButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
