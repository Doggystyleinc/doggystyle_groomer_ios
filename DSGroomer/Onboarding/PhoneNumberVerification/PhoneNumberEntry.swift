//
//  PhoneNumberEntry.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/9/21.
//

import Foundation
import UIKit
import Firebase

class PinNumberEntry : UIViewController, UITextFieldDelegate, CustomAlertCallBackProtocol {
    
    var phoneNumber : String?
    var countryCode : String?
    var groomersFirstName : String?
    var groomersLastName : String?
    var groomersEmail : String?

    var pinTimer : Timer?
    var pinCounter : Int = 120

    let databaseRef = Database.database().reference()
    let mainLoadingScreen = MainLoadingScreen()
    
    lazy var cancelButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.tintColor = coreOrangeColor
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        cbf.addTarget(self, action: #selector(self.handleCancelButton), for: UIControl.Event.touchUpInside)
        
        return cbf
        
    }()
    
    let mainHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "SMS Verification"
        thl.font = UIFont(name: dsHeaderFont, size: 24)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        
        return thl
        
    }()
    
    let subHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Enter the code sent to the phone number ending in"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreGrayColor
        
        return thl
        
    }()
    
    lazy var registerButton : UIButton = {
        
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
        cbf.addTarget(self, action: #selector(self.handleRegistrationButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var resendButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Re-send code", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = .clear
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreOrangeColor
        cbf.addTarget(self, action: #selector(self.handleCancelButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var slotOneTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
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
        let placeholder = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
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
        let placeholder = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
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
    
    lazy var slotFourTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "-", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
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
        thl.font = UIFont(name: dsSubHeaderFont, size: 16)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreGrayColor
        
        return thl
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.cancelButton.layer.cornerRadius = self.cancelButton.frame.height / 2

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
        self.view.addSubview(self.resendButton)

        self.stackView.addArrangedSubview(self.slotOneTextField)
        self.stackView.addArrangedSubview(self.slotTwoTextField)
        self.stackView.addArrangedSubview(self.slotThreeTextField)
        self.stackView.addArrangedSubview(self.slotFourTextField)
        
        self.cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 19).isActive = true
        self.cancelButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.cancelButton.widthAnchor.constraint(equalToConstant: 72).isActive = true
        self.cancelButton.heightAnchor.constraint(equalToConstant: 35).isActive = true

        self.mainHeaderLabel.topAnchor.constraint(equalTo: self.cancelButton.bottomAnchor, constant: 20).isActive = true
        self.mainHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.mainHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.mainHeaderLabel.sizeToFit()
        
        self.subHeaderLabel.topAnchor.constraint(equalTo: self.mainHeaderLabel.bottomAnchor, constant: 0).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.subHeaderLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.stackView.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 10).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        self.slotOneTextField.widthAnchor.constraint(equalToConstant: 74).isActive = true
        self.slotOneTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.slotOneTextField.layer.cornerRadius = 10

        self.slotTwoTextField.widthAnchor.constraint(equalToConstant: 74).isActive = true
        self.slotTwoTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.slotTwoTextField.layer.cornerRadius = 10

        self.slotThreeTextField.widthAnchor.constraint(equalToConstant: 74).isActive = true
        self.slotThreeTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.slotThreeTextField.layer.cornerRadius = 10

        self.slotFourTextField.widthAnchor.constraint(equalToConstant: 74).isActive = true
        self.slotFourTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.slotFourTextField.layer.cornerRadius = 10

        self.counterForPinLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.counterForPinLabel.topAnchor.constraint(equalTo: self.slotFourTextField.bottomAnchor, constant: 20).isActive = true
        self.counterForPinLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.counterForPinLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
       
        self.resendButton.topAnchor.constraint(equalTo: self.counterForPinLabel.bottomAnchor, constant: 15).isActive = true
        self.resendButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.resendButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.resendButton.heightAnchor.constraint(equalToConstant: 20).isActive = true

        self.registerButton.topAnchor.constraint(equalTo: self.resendButton.bottomAnchor, constant: 25).isActive = true
        self.registerButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 36).isActive = true
        self.registerButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -36).isActive = true
        self.registerButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        
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
            self.slotOneTextField.layer.borderColor = coreBlackColor.cgColor
            self.slotOneTextField.layer.borderWidth = 0.5
        } else {
            self.slotOneTextField.layer.borderColor = coreOrangeColor.cgColor
            self.slotOneTextField.layer.borderWidth = 1.5
        }
        
        if slotTwoText.isEmpty {
            self.slotTwoTextField.layer.borderColor = coreBlackColor.cgColor
            self.slotTwoTextField.layer.borderWidth = 0.5
        } else {
            self.slotTwoTextField.layer.borderColor = coreOrangeColor.cgColor
            self.slotTwoTextField.layer.borderWidth = 1.5
        }
        
        if slotThreeText.isEmpty {
            self.slotThreeTextField.layer.borderColor = coreBlackColor.cgColor
            self.slotThreeTextField.layer.borderWidth = 0.5
        } else {
            self.slotThreeTextField.layer.borderColor = coreOrangeColor.cgColor
            self.slotThreeTextField.layer.borderWidth = 1.5
        }
        
        if slotFourText.isEmpty {
            self.slotFourTextField.layer.borderColor = coreBlackColor.cgColor
            self.slotFourTextField.layer.borderWidth = 0.5
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
            print("Not complete")
            return
        }
        
        let pin = "\(slotOne)\(slotTwo)\(slotThree)\(slotFour)"

        self.registerButton.isHidden = true
        
        if self.phoneNumber == nil || self.countryCode == nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            
            self.pinTimer?.invalidate()
            self.counterForPinLabel.text = ""
            self.pinCounter = 120
            self.handleVerification(phone: self.phoneNumber ?? "", countryCode: self.countryCode ?? "", enteredCode: pin)
            
        }
    }
    
    private func handleVerification(phone : String, countryCode : String, enteredCode : String) {
        
        self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.LOADING_ANIMATION_GENERAL)
        self.resignation()
        
        ServiceHTTP.shared.twilioGetRequest(function_call: "request_for_authorization", users_country_code: countryCode, users_phone_number: phone, delivery_method: "sms", entered_code: enteredCode) { object, error in
            
            guard let obj = object else {return}
        
            for (key,value) in obj {
                
                let response = String(describing: value)
                
                if key == "twilio_response" {
                    
                    switch response {
                    
                    case "denied" :
                        DispatchQueue.main.async {
                            self.mainLoadingScreen.cancelMainLoadingScreen()
                            self.handleCustomPopUpAlert(title: "Incorrect Pin", message: "Please try again.", passedButtons: [Statics.GOT_IT])
                        }
                       
                    case "failed" :
                        DispatchQueue.main.async {
                            self.mainLoadingScreen.cancelMainLoadingScreen()
                            self.handleCustomPopUpAlert(title: "Internal Error", message: "Please try again.", passedButtons: [Statics.GOT_IT])
                        }
                        
                    case "approved" :
                        DispatchQueue.main.async {
                            self.mainLoadingScreen.cancelMainLoadingScreen()
                            self.handleNextButton()
                        }
                        
                    default: print("unknown from twilio")
                    
                    }
                }
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
        
        case Statics.GOT_IT: self.navigationController?.popViewController(animated: true)
            
        default: print("Should not hit")
            
        }
    }
   
    @objc func handleCancelButton() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNextButton() {
        
        if onboardingRoutes == .fromRegister {
            self.presentLocationFinderController()
        } else {
            self.handleGroomerLogin()
        }
    }
    
    func handleGroomerLogin() {
        
         let phoneNumber = self.phoneNumber ?? "nil"
         let areaCode = self.countryCode ?? "nil"
        
        if phoneNumber == "nil" || areaCode == "nil" {
        } else {
        
            let emailTemplate = "\(areaCode)_\(phoneNumber)_doggystyle@gmail.com"
            let passwordTemplate = "\(areaCode)_\(phoneNumber)_doggystyle"
            
            Service.shared.FirebaseLogin(usersEmailAddress: emailTemplate, usersPassword: passwordTemplate) { loginSuccess, response, responseCode in
              
                if loginSuccess == false {
                    print("Login error")
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    self.handleCustomPopUpAlert(title: "ERROR", message: "Seems there is an issue logging you in. Please make sure you have already registered.", passedButtons: [Statics.OK])
                    
                } else {
                    print("Login success now fill the data source")
                    
                    Service.shared.fillGroomerDataStruct { isComplete in
                    
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    self.presentHomeController()
                        
                    }
                }
            }
        }
    }
    
    func presentLocationFinderController() {
        
        let locationController = LocationController()
        
        locationController.phoneNumber = self.phoneNumber
        locationController.countryCode = self.countryCode
        locationController.groomersFirstName = self.groomersFirstName
        locationController.groomersLastName = self.groomersLastName
        locationController.groomersEmail = self.groomersEmail

        locationController.modalPresentationStyle = .fullScreen
        locationController.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(locationController, animated: true)
        
    }
    
    private func presentHomeController() {
        
        let homeController = HomeController()
        let navVC = UINavigationController(rootViewController: homeController)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.isHidden = true
        navigationController?.present(navVC, animated: true)
        
    }
}
