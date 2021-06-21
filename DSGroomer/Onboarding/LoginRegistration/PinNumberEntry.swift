//
//  PinNumberEntry.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 6/12/21.
//

import Foundation
import UIKit
import Firebase

class PinNumberVerificationEntryController : UIViewController, UITextFieldDelegate {
    
    //AND ANY OTHER DATA YOU WOULD LIKE TO PASS IN HERE
    var phoneNumber : String?,
        countryCode : String?,
        usersName : String?,
        pinTimer : Timer?,
        pinCounter : Int = 120
    
    let databaseRef = Database.database().reference(),
        mainLoadingScreen = MainLoadingScreen()
    
    lazy var cancelButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = coreWhiteColor
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreOrangeColor
        cbf.clipsToBounds = false
        cbf.layer.masksToBounds = false
        cbf.layer.shadowColor = coreBlackColor.cgColor
        cbf.layer.shadowOpacity = 0.3
        cbf.layer.shadowOffset = CGSize(width: 2, height: 3)
        cbf.layer.shadowRadius = 4
        cbf.layer.shouldRasterize = false
        cbf.layer.cornerRadius = 4
        cbf.addTarget(self, action: #selector(self.handleCancelButton), for: UIControl.Event.touchUpInside)
        
        return cbf
        
    }()
    
    let mainHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "SMS Verification"
        thl.font = UIFont(name: dsHeaderFont, size: 27)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreBlackColor
        
        return thl
        
    }()
    
    lazy var subHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "We have sent you a unique 4 digit code to the phone number ending in \(self.phoneNumber ?? "xxxx")"
        thl.font = UIFont(name: dsSubHeaderFont, size: 13)
        thl.numberOfLines = -1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreGrayColor.withAlphaComponent(0.8)
        
        return thl
        
    }()
    
    lazy var registerButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Send", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsSubHeaderFont, size: 15)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleRegistrationButton), for: UIControl.Event.touchUpInside)
        cbf.layer.masksToBounds = true
        cbf.layer.cornerRadius = 14
        
        return cbf
        
    }()
    
    lazy var slotOneTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor.withAlphaComponent(0.2)])
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
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.cgColor
        etfc.layer.shadowOpacity = 0.2
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 4
        etfc.layer.shouldRasterize = false
        etfc.layer.cornerRadius = 6
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)
        
        return etfc
        
    }()
    
    lazy var slotTwoTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor.withAlphaComponent(0.2)])
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
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.cgColor
        etfc.layer.shadowOpacity = 0.2
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 4
        etfc.layer.shouldRasterize = false
        etfc.layer.cornerRadius = 6
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)
        
        return etfc
        
    }()
    
    lazy var slotThreeTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor.withAlphaComponent(0.2)])
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
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.cgColor
        etfc.layer.shadowOpacity = 0.2
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 4
        etfc.layer.shouldRasterize = false
        etfc.layer.cornerRadius = 6
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)
        
        return etfc
        
    }()
    
    lazy var slotFourTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor.withAlphaComponent(0.2)])
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
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.cgColor
        etfc.layer.shadowOpacity = 0.2
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 4
        etfc.layer.shouldRasterize = false
        etfc.layer.cornerRadius = 6
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)
        
        return etfc
        
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
    
    let counterForPinLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "120"
        thl.font = UIFont(name: dsSubHeaderFont, size: 15)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreGrayColor
        
        return thl
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreWhiteColor
        self.addViews()
        
        self.pinTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.handleCountDown), userInfo: nil, repeats: true)
        
    }
    
    @objc func handleCountDown() {
        
        self.pinCounter -= 1
        self.counterForPinLabel.text = "\(self.pinCounter)"
        
        if self.pinCounter == 0 {
            self.handleCancelButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.counterForPinLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.slotOneTextField.becomeFirstResponder()
        UIView.animate(withDuration: 1.0) {
            self.counterForPinLabel.alpha = 1
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        self.pinCounter = 120
        self.pinTimer?.invalidate()
        self.counterForPinLabel.text = "120"
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.mainHeaderLabel)
        self.view.addSubview(self.subHeaderLabel)
        self.view.addSubview(self.stackView)
        self.view.addSubview(self.registerButton)
        self.view.addSubview(self.cancelButton)
        self.view.addSubview(self.counterForPinLabel)
        
        self.stackView.addArrangedSubview(self.slotOneTextField)
        self.stackView.addArrangedSubview(self.slotTwoTextField)
        self.stackView.addArrangedSubview(self.slotThreeTextField)
        self.stackView.addArrangedSubview(self.slotFourTextField)
        
        self.cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.cancelButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        self.cancelButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        self.cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.mainHeaderLabel.topAnchor.constraint(equalTo: self.cancelButton.bottomAnchor, constant: 15).isActive = true
        self.mainHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.mainHeaderLabel.sizeToFit()
        
        self.subHeaderLabel.topAnchor.constraint(equalTo: self.mainHeaderLabel.bottomAnchor, constant: 0).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.subHeaderLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.stackView.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 10).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.slotOneTextField.widthAnchor.constraint(equalToConstant: 55).isActive = true
        self.slotOneTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        self.slotTwoTextField.widthAnchor.constraint(equalToConstant: 55).isActive = true
        self.slotTwoTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        self.slotThreeTextField.widthAnchor.constraint(equalToConstant: 55).isActive = true
        self.slotThreeTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        self.slotFourTextField.widthAnchor.constraint(equalToConstant: 55).isActive = true
        self.slotFourTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        self.registerButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 25).isActive = true
        self.registerButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 36).isActive = true
        self.registerButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -36).isActive = true
        self.registerButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        
        self.counterForPinLabel.bottomAnchor.constraint(equalTo: self.mainHeaderLabel.bottomAnchor, constant: 0).isActive = true
        self.counterForPinLabel.leftAnchor.constraint(equalTo: self.mainHeaderLabel.rightAnchor, constant: 8).isActive = true
        self.counterForPinLabel.sizeToFit()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let entrySlot = textField.text {
            
            let maxLength = 1
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            textField.text = entrySlot
            
            return newString.length <= maxLength
            
        }
        
        return true
    }
    
    @objc func handleResponders(textField : UITextField) {
        
        let slotOneText = self.slotOneTextField.text ?? ""
        let slotTwoText = self.slotTwoTextField.text ?? ""
        let slotThreeText = self.slotThreeTextField.text ?? ""
        let slotFourText = self.slotFourTextField.text ?? ""
        
        if slotOneText.isEmpty {
        } else {
            self.slotOneTextField.layer.borderColor = coreOrangeColor.cgColor
            self.slotOneTextField.layer.borderWidth = 1.5
        }
        
        if slotTwoText.isEmpty {
        } else {
            self.slotTwoTextField.layer.borderColor = coreOrangeColor.cgColor
            self.slotTwoTextField.layer.borderWidth = 1.5
        }
        
        if slotThreeText.isEmpty {
        } else {
            self.slotThreeTextField.layer.borderColor = coreOrangeColor.cgColor
            self.slotThreeTextField.layer.borderWidth = 1.5
        }
        
        if slotFourText.isEmpty {
        } else {
            self.slotFourTextField.layer.borderColor = coreOrangeColor.cgColor
            self.slotFourTextField.layer.borderWidth = 1.5
        }
        
        if self.slotOneTextField.isFirstResponder && slotOneText.count > 0 {
            self.slotTwoTextField.becomeFirstResponder()
        } else if slotTwoTextField.isFirstResponder && slotTwoText.count > 0 {
            self.slotThreeTextField.becomeFirstResponder()
        } else if slotThreeTextField.isFirstResponder && slotThreeText.count > 0 {
            self.slotFourTextField.becomeFirstResponder()
        } else if self.slotFourTextField.isFirstResponder && slotFourText.count > 0 {
            self.handlePinCompletionEntry()
        }
    }
    
    func resignation() {
        
        self.slotOneTextField.resignFirstResponder()
        self.slotTwoTextField.resignFirstResponder()
        self.slotThreeTextField.resignFirstResponder()
        self.slotFourTextField.resignFirstResponder()
    }
    
    @objc func handleRegistrationButton() {
        
        self.resignation()
        self.handlePinCompletionEntry()
        
    }
    
    func handlePinCompletionEntry() {
        
        let slotOne = self.slotOneTextField.text ?? ""
        let slotTwo = self.slotTwoTextField.text ?? ""
        let slotThree = self.slotThreeTextField.text ?? ""
        let slotFour = self.slotFourTextField.text ?? ""
        
        if slotOne.isEmpty || slotTwo.isEmpty || slotThree.isEmpty || slotFour.isEmpty {
            return
        }
        
        let pin = "\(slotOne)\(slotTwo)\(slotThree)\(slotFour)"
        
        self.registerButton.isHidden = true
        self.navigationController?.popViewController(animated: true)
        self.pinTimer?.invalidate()
        self.counterForPinLabel.text = ""
        self.pinCounter = 120
        self.handleVerification(phone: self.phoneNumber ?? "", countryCode: self.countryCode ?? "", enteredCode: pin)
    }
    
    func handleVerification(phone : String, countryCode : String, enteredCode : String) {
        
        self.mainLoadingScreen.callMainLoadingScreen()
        self.resignation()
        
        let unique_key = NSUUID().uuidString
        let ref = Database.database().reference().child("pin_verification_requests").child(unique_key)
        let values = ["unique_key" : unique_key, "users_phone_number" : phone, "users_country_code" : countryCode, "entered_code" : enteredCode]
        
        ref.updateChildValues(values) { (error, ref) in
            
            if error != nil {
                print(error?.localizedDescription as Any)
                self.mainLoadingScreen.cancelMainLoadingScreen()
                AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Seems something went wrong attempting to register. Plase try again. If this problem persists, please contact Team Doggystyle directly.") { (isComplete) in
                }
                self.registerButton.isHidden = false
                return
            }
            
            self.listenForPendingResponsesFromToken(listeningKey: unique_key, phone: phone, countryCode: countryCode)
            
        }
    }
    
    func listenForPendingResponsesFromToken(listeningKey : String, phone : String, countryCode : String) {
        
        let ref = Database.database().reference().child("pin_verification_responses").child(listeningKey)
        
        ref.observe(.value) { (snap : DataSnapshot) in
            
            if snap.exists() {
                
                guard let dic = snap.value as? [String : AnyObject] else {return}
                
                let status = dic["status"] as? String ?? ""
                
                switch status {
                
                case "error" : print("Error: listening key")
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Seems something went wrong attempting to validate. Plase try again. If this problem persists, please contact Team Doggystyle directly.") { (isComplete) in
                        self.registerButton.isHidden = false
                    }
                    
                case "expired" : print("Verification code has been approved")
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    AlertControllerCompletion.handleAlertWithCompletion(title: "Expired", message: "Code has expired. Please try again.") { (true) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                case "failed" : print("Failed Verification")
                    
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    AlertControllerCompletion.handleAlertWithCompletion(title: "Failed", message: "Please check your phone/pin # and try again.") { (true) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                case "canceled" : print("Canceled Verification")
                    
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    AlertControllerCompletion.handleAlertWithCompletion(title: "Canceled", message: "Verification was canceled.") { (true) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                case "approved" : print("Verification code has been approved")
                    self.handleVerifiedPinState()
                    
                default :
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    AlertControllerCompletion.handleAlertWithCompletion(title: "Unknown Error", message: "Something is not right. Please try again.") { (true) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }
                
            } else if !snap.exists() {
                print("nothing yet here from the linker")
            }
        }
    }
    
    @objc func handleVerifiedPinState() {
        print("User is verified - push them to the next controller in the flow")
    }
    
    @objc func handleCancelButton() {
        
        self.navigationController?.popViewController(animated: true)
    }
}
