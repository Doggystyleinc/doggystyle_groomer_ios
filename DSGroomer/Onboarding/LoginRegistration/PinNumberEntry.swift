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
        cbf.setTitle("Back", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 16)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleCancelButton), for: UIControl.Event.touchUpInside)
        
        return cbf
        
    }()
    
    let mainHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Verification"
        thl.font = UIFont(name: dsHeaderFont, size: 30)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreBlackColor
        
        return thl
        
    }()
    
    let subHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Please enter the received pin in the circles below."
        thl.font = UIFont(name: dsSubHeaderFont, size: 15)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreGrayColor
        
        return thl
        
    }()
    
    lazy var registerButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Submit", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsSubHeaderFont, size: 20)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleRegistrationButton), for: UIControl.Event.touchUpInside)
        cbf.layer.masksToBounds = true
        cbf.layer.cornerRadius = 30.5
        
        return cbf
        
    }()
    
    lazy var slotOneTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor])
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
        etfc.layer.borderColor = coreBlackColor.cgColor
        etfc.layer.borderWidth = 0.5
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)

        return etfc
        
    }()
    
    lazy var slotTwoTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor])
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
        etfc.layer.borderColor = coreBlackColor.cgColor
        etfc.layer.borderWidth = 0.5
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)

        return etfc
        
    }()
    
    lazy var slotThreeTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor])
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
        etfc.layer.borderColor = coreBlackColor.cgColor
        etfc.layer.borderWidth = 0.5
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)

        return etfc
        
    }()
    
    lazy var slotFourTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor])
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
        etfc.layer.borderColor = coreBlackColor.cgColor
        etfc.layer.borderWidth = 0.5
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
         sv.spacing = 2
         
         return sv
     }()
    
    let counterForPinLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "120"
        thl.font = UIFont(name: dsHeaderFont, size: 21)
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
        print("Called?")
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

        self.stackView.addArrangedSubview(self.slotOneTextField)
        self.stackView.addArrangedSubview(self.slotTwoTextField)
        self.stackView.addArrangedSubview(self.slotThreeTextField)
        self.stackView.addArrangedSubview(self.slotFourTextField)
        
        self.cancelButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 19).isActive = true
        self.cancelButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.cancelButton.widthAnchor.constraint(equalToConstant: 72).isActive = true
        self.cancelButton.heightAnchor.constraint(equalToConstant: 35).isActive = true

        self.mainHeaderLabel.topAnchor.constraint(equalTo: self.cancelButton.bottomAnchor, constant: 15).isActive = true
        self.mainHeaderLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.mainHeaderLabel.sizeToFit()
        
        self.subHeaderLabel.topAnchor.constraint(equalTo: self.mainHeaderLabel.bottomAnchor, constant: 0).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.subHeaderLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.stackView.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 10).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 60).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -60).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.slotOneTextField.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.slotOneTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.slotOneTextField.layer.cornerRadius = 45/2

        self.slotTwoTextField.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.slotTwoTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.slotTwoTextField.layer.cornerRadius = 45/2

        self.slotThreeTextField.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.slotThreeTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.slotThreeTextField.layer.cornerRadius = 45/2

        self.slotFourTextField.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.slotFourTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.slotFourTextField.layer.cornerRadius = 45/2

        self.registerButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 15).isActive = true
        self.registerButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 36).isActive = true
        self.registerButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -36).isActive = true
        self.registerButton.heightAnchor.constraint(equalToConstant: 61).isActive = true
        
        self.counterForPinLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.counterForPinLabel.topAnchor.constraint(equalTo: self.registerButton.bottomAnchor, constant: 10).isActive = true
        self.counterForPinLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.counterForPinLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true

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

        print("Fire")
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
            
            //ALL CLEAR AND SUCCESSFUL
            print("Called listener")
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
                
                case "error" : print("Error on the listening key")
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
                    self.handleSuccessDecision(phone: phone, countryCode: countryCode)
                    
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
    
    func handleSuccessDecision(phone : String, countryCode : String) {

        if onboardingPath == .fromLogin {
            
            print("SUCCESS! - moving to login flow")

            self.handleLogin(phone: phone, countryCode: countryCode)
            
        } else if onboardingPath == .fromRegistration {
            
            print("SUCCESS! - moving to registration flow")

            self.handleRegistration(phone: phone, countryCode: countryCode)
            
        }
    }
    
    
    func handleLogin(phone : String, countryCode : String) {
        
        let usersEmail = "address_\(countryCode)_\(phone)@gmail.com"
        let usersPassword = "password_\(countryCode)_\(phone)"
        
        let timeStamp : Double = NSDate().timeIntervalSince1970
        let emailGrab = usersEmail
        let passswordGrab = usersPassword
        
        UIDevice.vibrateLight()
        
        Auth.auth().signIn(withEmail: emailGrab, password: passswordGrab) { (res, error) in
            
            if error != nil {
              
             print("Issue with login: ", error as Any)
             self.mainLoadingScreen.cancelMainLoadingScreen()
             AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Seems we are having trouble logging you in. Things to try:\n- Check for an active internet connection\n- Check your credentials\n- Try logging in again") { (done) in
                 print("Finished, try again")
             }
             
                return
            }
            
            //LOGIN SUCCESS
            let values = ["last_sign_in_time" : timeStamp]
            
            //USER MUST
            guard let user_uid = Auth.auth().currentUser?.uid else {return}
            
            let ref = self.databaseRef.child("all_users").child(user_uid)
            
            ref.updateChildValues(values, withCompletionBlock: { (error, ref) in

            //LOGIN SUCCESS
                
            })
        }
    }
   
    func handleRegistration(phone : String, countryCode : String) {
        
        let usersName = self.usersName ?? ""
        
        let usersEmail = "address_\(countryCode)_\(phone)@gmail.com"
        let usersPassword = "password_\(countryCode)_\(phone)"
        
        UIDevice.vibrateLight()
        
        Auth.auth().createUser(withEmail: usersEmail, password: usersPassword) { (result, error) in
            
            if error != nil {
                
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    
                    switch errCode {
                    
                    case .emailAlreadyInUse:
                        AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Email is already registered. Tap ‘Log In’ and try again. Thank you.") { (done) in
                            self.mainLoadingScreen.cancelMainLoadingScreen()
                            self.navigationController?.popViewController(animated: true)
                        }
                    default:
                        AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Seems we are having trouble with registration. Things to try:\n- Check for an active internet connection\n- Check your credentials\n- Try registering again") { (done) in
                            self.mainLoadingScreen.cancelMainLoadingScreen()
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    return
                } else {
                    AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Seems we are having trouble with registration. Things to try:\n- Check for an active internet connection\n- Check your credentials\n- Try registering again") { (done) in
                        self.mainLoadingScreen.cancelMainLoadingScreen()
                        self.navigationController?.popViewController(animated: true)
                    }
                    return
                }
            }
            
            //STEP 2 - SIGN THE USER IN WITH THEIR NEW CREDENTIALS
            Auth.auth().signIn(withEmail: usersEmail, password: usersPassword) { (user, error) in
                
                if error != nil {
                    
                    print("Issue with sign in after registration: ", error as Any)
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "We were able to make you an account, but we could not sign you in. Please go back and tap 'Log In' since you now have an active account. Thank you.") { (done) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    return
                    
                }
                
                //STEP 3 - UPDATE THE USERS CREDENTIALS IN THE DATABASE AS A BACKUP
                guard let firebase_uid = user?.user.uid else {return} //THIS CAN CAUSE AN ISSUE, NOTHING TO DO HERE AND SHOULD BE VERY RARE
                
                let ref = self.databaseRef.child("all_users").child(firebase_uid)
                
                let timeStamp : Double = NSDate().timeIntervalSince1970
                let sign_in_method = "phone_number_login"
                let ref_key = ref.key ?? ""
                
                let values : [String : Any] = ["firebase_uid" : firebase_uid, "users_name" : usersName, "email" : usersEmail, "sign_in_method" : sign_in_method, "sign_up_date" : timeStamp, "terms_and_conditions_accepted" : true, "phone_number" : phone, "country_code" : countryCode, "ref_key" : ref_key]
                
                ref.updateChildValues(values) { (error, ref) in
                    
                    if error != nil {
                        print(error?.localizedDescription as Any)
                        self.mainLoadingScreen.cancelMainLoadingScreen()
                        return
                    }
                    
                    if let request = Auth.auth().currentUser?.createProfileChangeRequest() {
                        
                        request.displayName = usersName
                        
                        request.commitChanges { (error) in
                            
                            print("User has successfully registered with firebase and logged in")
                            
                        }
                        
                    } else {
                        
                        print("User has successfully registered with firebase and logged in")
                        
                    }
                }
            }
        }
    }
    
    func handleHomeController() {
        
        DispatchQueue.main.async {
        self.mainLoadingScreen.cancelMainLoadingScreen()
        let homeController = HomeController()
        let nav = UINavigationController(rootViewController: homeController)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(nav, animated: true, completion: nil)
        }
    }
    
    @objc func handleCancelButton() {
        
        self.navigationController?.popViewController(animated: true)
    }
}
