//
//  LoginController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/9/21.
//


import UIKit
import Firebase
import GoogleMaps

final class LoginController: UIViewController, UITextFieldDelegate, CustomAlertCallBackProtocol, CLLocationManagerDelegate {
    
    let databaseRef = Database.database().reference()
    var isKeyboardShowing : Bool = false
    var lastKeyboardHeight : CGFloat = 0.0
    let mainLoadingScreen = MainLoadingScreen()
    var locationManager = CLLocationManager()
    
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
        hl.text = "Welcome back"
        hl.font = UIFont(name: dsHeaderFont, size: 24)
        hl.numberOfLines = 1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        
        return hl
    }()
    
    let placeHolderEmailLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "Enter email"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    let placeHolderPasswordLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "Enter password"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    
    let typingEmailLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = coreWhiteColor
        tel.text = "Email"
        tel.font = UIFont(name: rubikBold, size: 13)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = true
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    let typingPasswordLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = coreWhiteColor
        tel.text = "Password"
        tel.font = UIFont(name: rubikBold, size: 13)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = true
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    lazy var emailTextField: CustomTextField = {
        
        let etfc = CustomTextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: rubikRegular, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.keyboardAppearance = UIKeyboardAppearance.light
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .alphabet
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 8
        etfc.leftViewMode = .always
        etfc.layer.borderColor = UIColor.clear.cgColor
        etfc.layer.borderWidth = 1
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        etfc.clipsToBounds = false
        etfc.layer.masksToBounds = true
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.addTarget(self, action: #selector(self.handleEmailTextFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handleEmailTextFieldBegin), for: .touchDown)
        
        return etfc
        
    }()
    
    lazy var passwordTextField: CustomTextField = {
        
        let etfc = CustomTextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: rubikRegular, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.keyboardAppearance = UIKeyboardAppearance.light
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .alphabet
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 8
        etfc.leftViewMode = .always
        etfc.layer.borderColor = UIColor.clear.cgColor
        etfc.layer.borderWidth = 1
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        etfc.clipsToBounds = false
        etfc.layer.masksToBounds = true
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.isSecureTextEntry = true
        etfc.addTarget(self, action: #selector(self.handlePasswordTextFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handlePasswordTextFieldBegin), for: .touchDown)
        
        return etfc
        
    }()
    
    lazy var loginButton: UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Login", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.layer.cornerRadius = 12
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.backgroundColor = coreOrangeColor
        cbf.addTarget(self, action: #selector(self.handleGroomerLogin), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var forgortPasswordButton: UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Forgot Password?", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsSubHeaderFont, size: 16)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreBlackColor
        cbf.backgroundColor = .clear
        cbf.addTarget(self, action: #selector(self.didTapForgotPassword), for: .touchUpInside)
        
        return cbf
        
    }()
    
    private let dividerLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: dsHeaderFont, size: 18)
        label.textColor = dsFlatBlack.withAlphaComponent(0.4)
        label.text = "or"
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var showHideEyeButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.tintColor = coreOrangeColor
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 18, style: .light)
        cbf.setTitle(String.fontAwesomeIcon(name: .eyeSlash), for: .normal)
        cbf.tintColor = coreOrangeColor
        cbf.addTarget(self, action: #selector(self.showHidePassWord), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        navigationController?.navigationBar.isHidden = true
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.addViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardShow(notification : Notification) {
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        if keyboardRectangle.height > 200 {
            
            if self.isKeyboardShowing == true {return}
            self.isKeyboardShowing = true
            self.lastKeyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.25) {
                self.forgortPasswordButton.alpha = 0
            }
        }
    }
    
    @objc func handleKeyboardHide(notification : Notification) {
        
        self.isKeyboardShowing = false
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        self.lastKeyboardHeight = keyboardRectangle.height
        
        UIView.animate(withDuration: 0.25) {
            self.forgortPasswordButton.alpha = 1
        }
    }
    
    private func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.dsCompanyLogoImage)
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.typingEmailLabel)
        
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.typingPasswordLabel)
        self.view.addSubview(self.showHideEyeButton)
        
        self.view.addSubview(self.placeHolderEmailLabel)
        self.view.addSubview(self.placeHolderPasswordLabel)
        
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.forgortPasswordButton)
        
        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 64).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.dsCompanyLogoImage.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 32).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.emailTextField.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 15).isActive = true
        self.emailTextField.leftAnchor.constraint(equalTo: self.headerLabel.leftAnchor, constant: 0).isActive = true
        self.emailTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderEmailLabel.leftAnchor.constraint(equalTo: self.emailTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderEmailLabel.centerYAnchor.constraint(equalTo: self.emailTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderEmailLabel.sizeToFit()
        
        self.typingEmailLabel.leftAnchor.constraint(equalTo: self.emailTextField.leftAnchor, constant: 25).isActive = true
        self.typingEmailLabel.topAnchor.constraint(equalTo: self.emailTextField.topAnchor, constant: 14).isActive = true
        self.typingEmailLabel.sizeToFit()
        
        self.typingPasswordLabel.leftAnchor.constraint(equalTo: self.passwordTextField.leftAnchor, constant: 25).isActive = true
        self.typingPasswordLabel.topAnchor.constraint(equalTo: self.passwordTextField.topAnchor, constant: 14).isActive = true
        self.typingPasswordLabel.sizeToFit()
        
        self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10).isActive = true
        self.passwordTextField.leftAnchor.constraint(equalTo: self.headerLabel.leftAnchor, constant: 0).isActive = true
        self.passwordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderPasswordLabel.leftAnchor.constraint(equalTo: self.passwordTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderPasswordLabel.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderPasswordLabel.sizeToFit()
        
        self.showHideEyeButton.rightAnchor.constraint(equalTo: self.passwordTextField.rightAnchor, constant: -10).isActive = true
        self.showHideEyeButton.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor, constant: 0).isActive = true
        self.showHideEyeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.showHideEyeButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 10).isActive = true
        self.loginButton.leftAnchor.constraint(equalTo: self.headerLabel.leftAnchor, constant: 0).isActive = true
        self.loginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.forgortPasswordButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 10).isActive = true
        self.forgortPasswordButton.leftAnchor.constraint(equalTo: self.headerLabel.leftAnchor, constant: 0).isActive = true
        self.forgortPasswordButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.forgortPasswordButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
    func resignation() {
        
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        
    }
    
    @objc func showHidePassWord() {
        
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
        
        if self.passwordTextField.isSecureTextEntry {
            
            self.showHideEyeButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 18, style: .light)
            self.showHideEyeButton.setTitle(String.fontAwesomeIcon(name: .eyeSlash), for: .normal)
            
        } else {
            
            self.showHideEyeButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 18, style: .solid)
            self.showHideEyeButton.setTitle(String.fontAwesomeIcon(name: .eye), for: .normal)
        }
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            handleGroomerLogin()
        }
        return false
    }
    
    @objc func handleEmailTextFieldChange() {
        
        guard let emailText = self.emailTextField.text else {return}
        self.emailTextField.text = emailText.lowercased()
        
        if self.emailTextField.text != "" {
            typingEmailLabel.isHidden = false
            placeHolderEmailLabel.isHidden = true
        }
    }
    
    @objc func handleEmailTextFieldBegin() {
        self.typingEmailLabel.isHidden = false
        self.placeHolderEmailLabel.isHidden = true
    }
    
    @objc func handlePasswordTextFieldBegin() {
        self.typingPasswordLabel.isHidden = false
        self.placeHolderPasswordLabel.isHidden = true
    }
    
    @objc func handlePasswordTextFieldChange() {
        
        if self.passwordTextField.text != "" {
            typingPasswordLabel.isHidden = false
            placeHolderPasswordLabel.isHidden = true
        }
    }
    
    @objc private func handleGroomerLogin() {
        
        UIDevice.vibrateLight()
        self.resignation()
        
        guard let emailText = emailTextField.text,
              let passwordText = passwordTextField.text else { return }
        
        let cleanEmail = emailText.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = passwordText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanEmail.count > 2 && cleanEmail.contains("@") && cleanEmail.contains(".") {
            self.emailTextField.layer.borderColor = UIColor .clear.cgColor
            if cleanPassword.count > 3 {
                
                self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.LOADING_ANIMATION_GENERAL)
                
                self.emailTextField.layer.borderColor = UIColor .clear.cgColor
                self.passwordTextField.layer.borderColor = UIColor .clear.cgColor
                
                //ALL SYSTEMS GO FOR LOGIN
                Service.shared.FirebaseLogin(usersEmailAddress: cleanEmail, usersPassword: cleanPassword) { loginSuccess, response, responseCode in
                    
                    if loginSuccess {
                        
                        self.mainLoadingScreen.cancelMainLoadingScreen()
                        
                        Service.shared.fillGroomerDataStruct { isComplete in
                            self.presentHomeController()
                        }
                        
                    } else {
                        self.mainLoadingScreen.cancelMainLoadingScreen()
                        
                        self.handleCustomPopUpAlert(title: "ERROR", message: response, passedButtons: ["Ok"])
                    }
                }
                
            } else {
                self.passwordTextField.layer.borderColor = coreRedColor.cgColor
            }
            
        } else {
            self.emailTextField.layer.borderColor = coreRedColor.cgColor
        }
    }
    
    
    
    func onSelectionPassBack(buttonTitleForSwitchStatement type: String) {
        print("USer selected okay")
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
    
    @objc private func didTapForgotPassword() {
        let passwordResetController = PasswordResetController()
        passwordResetController.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(passwordResetController, animated: true)
    }
    
    private func presentHomeController() {
        let homeController = HomeController()
        let navVC = UINavigationController(rootViewController: homeController)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationBar.isHidden = true
        navigationController?.present(navVC, animated: true)
    }
}


