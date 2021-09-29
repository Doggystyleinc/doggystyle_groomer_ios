//
//  SocialSecurityController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//
//  The nine-digit SSN is composed of three parts:
//
//  The first set of three digits is called the Area Number
//  The second set of two digits is called the Group Number
//  The final set of four digits is the Serial Number
        

import AVFoundation
import UIKit
import Firebase


class SocialSecurityController : UIViewController, UITextFieldDelegate, CustomAlertCallBackProtocol {
    
    let mainLoadingScreen = MainLoadingScreen()
    let databaseRef = Database.database().reference()
    
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
        hl.text = "Social Security Number"
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
        hl.text = "Needed so you can get paid and to run your background check. Your information is encrypted and secure.\n\nYour SSN won’t be used to run a credit check - your credit won’t be affected."
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = -1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    lazy var authorizeButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("I authorize", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.isEnabled = true
        cbf.addTarget(self, action: #selector(self.handleAuthorizeButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var stackView : UIStackView = {
               
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        sv.spacing = 6
         
         return sv
     }()
    
    lazy var slotOneTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "...", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .center
        etfc.textColor = coreGrayColor
        etfc.font = UIFont(name: dsSubHeaderFont, size: 22)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.keyboardAppearance = UIKeyboardAppearance.default
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .numberPad
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 2
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.layer.borderColor = slotGrey.cgColor
        etfc.layer.borderWidth = 1
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)

        return etfc
        
    }()
    
    lazy var slotTwoTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "..", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .center
        etfc.textColor = coreGrayColor
        etfc.font = UIFont(name: dsSubHeaderFont, size: 22)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.keyboardAppearance = UIKeyboardAppearance.default
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .numberPad
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 2
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.layer.borderColor = slotGrey.cgColor
        etfc.layer.borderWidth = 1
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)

        return etfc
        
    }()
    
    lazy var slotThreeTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "....", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .center
        etfc.textColor = coreGrayColor
        etfc.font = UIFont(name: dsSubHeaderFont, size: 22)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.keyboardAppearance = UIKeyboardAppearance.default
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .numberPad
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 2
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.layer.borderColor = slotGrey.cgColor
        etfc.layer.borderWidth = 1
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)

        return etfc
        
    }()
    
    lazy var toolBar : UIToolbar = {
           
           let bar = UIToolbar()
           let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.resignation))
           bar.items = [space, done]
           bar.backgroundColor = coreWhiteColor
           bar.tintColor = coreOrangeColor
           bar.sizeToFit()
           
           return bar
           
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()

        self.slotOneTextField.inputAccessoryView = self.toolBar
        self.slotTwoTextField.inputAccessoryView = self.toolBar
        self.slotThreeTextField.inputAccessoryView = self.toolBar

    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.dsCompanyLogoImage)
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.subHeaderLabel)
        self.view.addSubview(self.authorizeButton)
        
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.slotOneTextField)
        self.stackView.addArrangedSubview(self.slotTwoTextField)
        self.stackView.addArrangedSubview(self.slotThreeTextField)

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
        
        self.stackView.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 30).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        self.slotOneTextField.widthAnchor.constraint(equalToConstant: 102).isActive = true
        self.slotOneTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.slotOneTextField.layer.cornerRadius = 10

        self.slotTwoTextField.widthAnchor.constraint(equalToConstant: 97).isActive = true
        self.slotTwoTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.slotTwoTextField.layer.cornerRadius = 10

        self.slotThreeTextField.widthAnchor.constraint(equalToConstant: 102).isActive = true
        self.slotThreeTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.slotThreeTextField.layer.cornerRadius = 10
        
        self.authorizeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.authorizeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.authorizeButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -53).isActive = true
        self.authorizeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    @objc func handleResponders(textField : UITextField) {
        
        if self.slotOneTextField.text?.count  == 3 && self.slotTwoTextField.text?.count  == 2 && self.slotThreeTextField.text?.count == 4 {
            self.handleAuthorizeButton()
            return
        }
        
        if textField == self.slotOneTextField {
            
            if self.slotOneTextField.text?.count == 3 {
                self.slotOneTextField.resignFirstResponder()
                self.slotTwoTextField.becomeFirstResponder()
            }
            
        } else if textField == self.slotTwoTextField {
            
            if self.slotTwoTextField.text?.count == 2 {
                self.slotTwoTextField.resignFirstResponder()
                self.slotThreeTextField.becomeFirstResponder()
            }
            
        } else if textField == self.slotThreeTextField {
            
            if self.slotThreeTextField.text?.count == 4 {
                self.slotThreeTextField.resignFirstResponder()
                self.handleAuthorizeButton()
            }
            
        } else {
            print("SHOULD NEVER HIT THIS")
        }
    }
    
   @objc func resignation() {
        
        self.slotOneTextField.resignFirstResponder()
        self.slotTwoTextField.resignFirstResponder()
        self.slotThreeTextField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignation()
        return false
    }
    
    @objc func handleAuthorizeButton() {
        
        self.resignation()
     
        guard let slotOne = self.slotOneTextField.text else {return}
        guard let slotTwo = self.slotTwoTextField.text else {return}
        guard let slotThree = self.slotThreeTextField.text else {return}
        
        let cleanSlotOne = slotOne.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanSlotTwo = slotTwo.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanSlotThree = slotThree.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanSlotOne.count == 3 {
            self.slotOneTextField.layer.borderColor = UIColor .clear.cgColor
            if cleanSlotTwo.count == 2 {
                self.slotTwoTextField.layer.borderColor = UIColor .clear.cgColor
                if cleanSlotThree.count == 4 {
                    
                    self.slotOneTextField.layer.borderColor = UIColor .clear.cgColor
                    self.slotTwoTextField.layer.borderColor = UIColor .clear.cgColor
                    self.slotThreeTextField.layer.borderColor = UIColor .clear.cgColor

                    self.slotOneTextField.text = ""
                    self.slotTwoTextField.text = ""
                    self.slotThreeTextField.text = ""

                    self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.LOADING_ANIMATION_GENERAL)
                    self.simulationLogic()
                    
                } else {
                    self.slotThreeTextField.layer.borderColor = coreRedColor.cgColor
                }
            } else {
                self.slotTwoTextField.layer.borderColor = coreRedColor.cgColor
            }
        } else {
            self.slotOneTextField.layer.borderColor = coreRedColor.cgColor
        }
    }
    
    @objc func simulationLogic() {
        
        let groomerKey = groomerUserStruct.groomer_child_key_from_playbook ?? "nil"
        
        if groomerKey == "nil" {
            
            self.mainLoadingScreen.cancelMainLoadingScreen()
            self.handleCustomPopUpAlert(title: "ERROR", message: "Seems to be a systems error. Reach out to support @ \(Statics.SUPPORT_EMAIL_ADDRESS)", passedButtons: [Statics.GOT_IT])
           
        } else {
            
            let ref = self.databaseRef.child("play_books").child(groomerKey)
            let values : [String : Any] = ["groomer_has_completed_background_check_management" : true]
            ref.updateChildValues(values) { error, ref in
                if error != nil {
                    
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    self.handleCustomPopUpAlert(title: "ERROR", message: "Seems to be a systems error. Reach out to support @ \(Statics.SUPPORT_EMAIL_ADDRESS)", passedButtons: [Statics.GOT_IT])

                    return
                }
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Statics.RUN_DATA_ENGINE), object: self)

                self.mainLoadingScreen.cancelMainLoadingScreen()
                self.handleSocialVerificationController()
            }
        }
    }
  
    @objc func handleCustomPopUpAlert(title : String, message : String, passedButtons: [String]) {
        
        let alert = AlertController()
        alert.passedTitle = title
        alert.passedMmessage = message
        alert.passedButtonSelections = passedButtons
        alert.customAlertCallBackProtocol = self
        
        alert.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(alert, animated: true, completion: nil)
        
    }
    
    func onSelectionPassBack(buttonTitleForSwitchStatement type: String) {
        
        switch type {
        
        case Statics.GOT_IT: self.handleBackButton()
            
        default: print("Should not hit")
            
        }
    }
    
    @objc func handleSocialVerificationController() {
        
        let socialSecuritySuccessController = SocialSecuritySuccessController()
        socialSecuritySuccessController.navigationController?.navigationBar.isHidden = true
        socialSecuritySuccessController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(socialSecuritySuccessController, animated: true)
       
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
