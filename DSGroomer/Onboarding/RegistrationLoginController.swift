//
//  RegistrationController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//

import Foundation
import UIKit
import FontAwesome_swift
import GoogleSignIn
import Firebase



class RegistrationLoginController : UIViewController, UITextFieldDelegate, GIDSignInDelegate {
    
    var isRegistration : Bool = false,
        heightLayoutConstraint : NSLayoutConstraint?,
        confirmButtonLayoutConstraint : NSLayoutConstraint?
    
    let mainLoadingScreen = MainLoadingScreen()
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.tintColor = coreGrayColor.withAlphaComponent(0.5)
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
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
    
    let welcomeBackLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Registration is simple"
        thl.font = UIFont(name: dsHeaderFont, size: 20)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreBlackColor
        
        return thl
        
    }()
    
    lazy var registerWithfacebookButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.layer.cornerRadius = 14
        cbf.layer.masksToBounds = true
        let image = UIImage(named: "fb_register_button")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: .normal)
        cbf.imageView?.contentMode = .scaleAspectFit
        cbf.addTarget(self, action: #selector(self.handleFacebookRegistration), for: UIControl.Event.touchUpInside)
        
        return cbf
        
    }()
    
    lazy var registerWithGoogleButton : UIButton = {

        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.layer.cornerRadius = 14
        cbf.layer.masksToBounds = true
        let image = UIImage(named: "google_register_button")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: .normal)
        cbf.imageView?.contentMode = .scaleAspectFit
        cbf.addTarget(self, action: #selector(self.handleGoogleRegistration), for: UIControl.Event.touchUpInside)

        return cbf

    }()
    
    let orLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "or"
        thl.font = UIFont(name: dsSubHeaderFont, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = coreGrayColor.withAlphaComponent(0.5)
        
        return thl
        
    }()
    
    lazy var confirmButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Confirm", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 16)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 14
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleConfirmButton), for: UIControl.Event.touchUpInside)
        
        return cbf
        
    }()
    
    let inputContainer : UIView = {
        
        let ic = UIView()
        ic.translatesAutoresizingMaskIntoConstraints = false
        ic.backgroundColor = coreBackgroundWhite
        
        return ic
    }()
    
    lazy var emailTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "Enter email", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor.withAlphaComponent(0.5)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: dsSubHeaderFont, size: 15)
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
        etfc.layer.borderColor = coreRedColor.cgColor
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        return etfc
        
    }()
    
    lazy var fullNameTextfield : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "Enter full name", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor.withAlphaComponent(0.5)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: dsSubHeaderFont, size: 15)
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
        etfc.layer.borderColor = coreRedColor.cgColor
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        return etfc
        
    }()
    
    lazy var passwordTextfield : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor: coreGrayColor.withAlphaComponent(0.5)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: dsSubHeaderFont, size: 15)
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
        etfc.layer.borderColor = coreRedColor.cgColor
        etfc.isSecureTextEntry = true
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        return etfc
        
    }()
    
    lazy var forgotPasswordButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Forgot password?", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 16)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = .clear
        cbf.layer.cornerRadius = 3
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreBlackColor
        cbf.addTarget(self, action: #selector(self.handleForgotPasswordButton), for: UIControl.Event.touchUpInside)
        
        return cbf
        
    }()
    
    let toolBar : UIToolbar = {
        
        let bar = UIToolbar()
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(resignation))
        
        bar.items = [space, done]
        bar.backgroundColor = .white
        bar.tintColor = coreOrangeColor
        bar.sizeToFit()
        
        return bar
        
    }()
    
    let errorLabel : UILabel = {
        
        let el = UILabel()
        el.translatesAutoresizingMaskIntoConstraints = false
        el.font = UIFont(name: dsSubHeaderFont, size: 12)
        el.textColor = coreRedColor
        el.textAlignment = .center
        el.adjustsFontSizeToFitWidth = true
        el.isUserInteractionEnabled = false
        
        return el
    }()
    
    @objc func resignation() {
        
        self.emailTextField.resignFirstResponder()
        self.fullNameTextfield.resignFirstResponder()
        self.passwordTextfield.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        
        self.addViews()
        self.decisionTree()
        self.keyboardObservers()
        
        self.emailTextField.inputAccessoryView = toolBar
        self.fullNameTextfield.inputAccessoryView = toolBar
        self.passwordTextfield.inputAccessoryView = toolBar
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.passwordTextfield.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.fullNameTextfield.resignFirstResponder()
        return true
    }
    
    func keyboardObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification : Notification) {
        
        UIView.animate(withDuration: 0.25) {
            self.confirmButton.alpha = 0
            self.registerWithGoogleButton.alpha = 0
            self.registerWithfacebookButton.alpha = 0
            self.orLabel.alpha = 0
        }
        
    }
    
    @objc func keyboardWillHide(notification : Notification) {
        UIView.animate(withDuration: 0.25) {
            self.confirmButton.alpha = 1
            self.registerWithGoogleButton.alpha = 1
            self.registerWithfacebookButton.alpha = 1
            self.orLabel.alpha = 1
        }
    }
    
    func decisionTree() {
        
        if isRegistration {
            self.confirmButton.setTitle("Confirm", for: .normal)
            self.heightLayoutConstraint?.constant = 60
            self.fullNameTextfield.isHidden = false
            self.welcomeBackLabel.text = "Registration is simple"
            self.forgotPasswordButton.isHidden = true
            self.confirmButtonLayoutConstraint?.constant = -20
        } else {
            self.confirmButton.setTitle("Login", for: .normal)
            self.heightLayoutConstraint?.constant = 10
            self.fullNameTextfield.isHidden = true
            self.welcomeBackLabel.text = "Welcome Back"
            self.confirmButtonLayoutConstraint?.constant = -100
        }
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.dsCompanyLogoImage)
        self.view.addSubview(self.welcomeBackLabel)
        
        self.view.addSubview(self.registerWithfacebookButton)
        self.view.addSubview(self.registerWithGoogleButton)
        self.view.addSubview(self.orLabel)
        self.view.addSubview(self.confirmButton)
        
        self.view.addSubview(self.inputContainer)
        
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.fullNameTextfield)
        self.view.addSubview(self.passwordTextfield)
        self.view.addSubview(self.forgotPasswordButton)
        self.view.addSubview(self.errorLabel)
        
        self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 2).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 12).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.dsCompanyLogoImage.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 10).isActive = true
        self.dsCompanyLogoImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
        self.dsCompanyLogoImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
        self.dsCompanyLogoImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.welcomeBackLabel.topAnchor.constraint(equalTo: self.dsCompanyLogoImage.bottomAnchor, constant: -10).isActive = true
        self.welcomeBackLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.welcomeBackLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.welcomeBackLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        self.registerWithfacebookButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        self.registerWithfacebookButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.registerWithfacebookButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.registerWithfacebookButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.registerWithGoogleButton.bottomAnchor.constraint(equalTo: self.registerWithfacebookButton.topAnchor, constant: -2).isActive = true
        self.registerWithGoogleButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.registerWithGoogleButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.registerWithGoogleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.orLabel.bottomAnchor.constraint(equalTo: self.registerWithGoogleButton.topAnchor, constant: 0).isActive = true
        self.orLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.orLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.orLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.confirmButtonLayoutConstraint = self.confirmButton.bottomAnchor.constraint(equalTo: self.orLabel.topAnchor, constant: -20)
        self.confirmButtonLayoutConstraint?.isActive = true
        self.confirmButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.confirmButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.confirmButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.inputContainer.topAnchor.constraint(equalTo: self.welcomeBackLabel.bottomAnchor, constant: 20).isActive = true
        self.inputContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.inputContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.inputContainer.bottomAnchor.constraint(equalTo: self.confirmButton.topAnchor, constant: -70).isActive = true
        
        self.fullNameTextfield.centerYAnchor.constraint(equalTo: self.inputContainer.centerYAnchor).isActive = true
        self.fullNameTextfield.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.fullNameTextfield.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.heightLayoutConstraint = self.fullNameTextfield.heightAnchor.constraint(equalToConstant: 60)
        self.heightLayoutConstraint?.isActive = true
        
        self.emailTextField.bottomAnchor.constraint(equalTo: self.fullNameTextfield.topAnchor, constant: -10).isActive = true
        self.emailTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.emailTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.passwordTextfield.topAnchor.constraint(equalTo: self.fullNameTextfield.bottomAnchor, constant: 10).isActive = true
        self.passwordTextfield.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.passwordTextfield.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.passwordTextfield.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.forgotPasswordButton.bottomAnchor.constraint(equalTo: self.orLabel.topAnchor, constant: -10).isActive = true
        self.forgotPasswordButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.forgotPasswordButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.errorLabel.topAnchor.constraint(equalTo: self.passwordTextfield.bottomAnchor, constant: 5).isActive = true
        self.errorLabel.leftAnchor.constraint(equalTo: self.confirmButton.leftAnchor, constant: 0).isActive = true
        self.errorLabel.rightAnchor.constraint(equalTo: self.confirmButton.rightAnchor, constant: 0).isActive = true
        self.errorLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
    }
    
    @objc func handleFacebookRegistration() {
        print("fb")
    }
    
    @objc func handleGoogleRegistration() {
        print("fb")
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      
      if let error = error {
         print("error occured here signing in with google sign in. \(error)")
        return
      }

      guard let authentication = user.authentication else {
        print("Authentication error. \(error?.localizedDescription as Any)")
        return
      }
        
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Service.shared.firebaseGoogleSignIn(credentials: credential) { (hasSuccess, response) in
            
            if hasSuccess {
                self.presentHomeController()
            } else {
                print("Failed to authenticate with error: \(response)")
            }
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("bailed from the google sign in process")
    }
    
    @objc func handleConfirmButton() {
        
        //MARK: - Register User
        if self.isRegistration {
            
            guard let safeEmail = self.emailTextField.text else {return}
            guard let safeFullName = self.fullNameTextfield.text else {return}
            guard let safepassword = self.passwordTextfield.text else {return}
            
            let emailTrim = safeEmail.trimmingCharacters(in: .whitespacesAndNewlines)
            let fullNametrim = safeFullName.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordTrim = safepassword.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if emailTrim.contains("@") && emailTrim.contains(".") && emailTrim.count > 3 {
                if fullNametrim.count > 3 {
                    if passwordTrim.count > 3 {
                        
                        self.errorLabel.text = ""
                        UIDevice.vibrateLight()
                        
                        self.emailTextField.layer.borderWidth = 0
                        self.fullNameTextfield.layer.borderWidth = 0
                        self.passwordTextfield.layer.borderWidth = 0
                        
                        self.mainLoadingScreen.callMainLoadingScreen()
                        print("I am here...")
                        print(safeEmail)
                        print(safepassword)
                        print(safeFullName)
                        self.registerUser(usersEmailAddress: safeEmail, usersPassword: safepassword, fullName: safeFullName, signInMethod: "email")
                        
                    } else {
                        self.errorLabel.text = "Password minimum: 4 characters"
                        self.emailTextField.layer.borderWidth = 0
                        self.fullNameTextfield.layer.borderWidth = 0
                        self.passwordTextfield.layer.borderWidth = 0.5
                        UIDevice.vibrateHeavy()
                    }
                    
                } else {
                    self.errorLabel.text = "Full name minimum: 4 characters"
                    self.emailTextField.layer.borderWidth = 0
                    self.fullNameTextfield.layer.borderWidth = 0.5
                    self.passwordTextfield.layer.borderWidth = 0
                    UIDevice.vibrateHeavy()
                    
                }
            } else {
                
                self.errorLabel.text = "Invalid Email"
                self.emailTextField.layer.borderWidth = 0.5
                self.fullNameTextfield.layer.borderWidth = 0
                self.passwordTextfield.layer.borderWidth = 0
                UIDevice.vibrateHeavy()
                
            }
            
        //MARK: - Log User In
        } else {
            
            guard let safeEmail = self.emailTextField.text else {return}
            guard let safepassword = self.passwordTextfield.text else {return}
            
            let emailTrim = safeEmail.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordTrim = safepassword.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            if emailTrim.contains("@") && emailTrim.contains(".") && emailTrim.count > 3 {
                if passwordTrim.count > 3 {
                    
                    self.errorLabel.text = ""
                    self.emailTextField.layer.borderWidth = 0
                    self.passwordTextfield.layer.borderWidth = 0
                    
                    UIDevice.vibrateLight()
                    mainLoadingScreen.callMainLoadingScreen()
                    self.logUserIn(usersEmailAddress: emailTrim, usersPassword: passwordTrim)
                    
                } else {
                    self.errorLabel.text = "Password minimum: 4 characters"
                    self.emailTextField.layer.borderWidth = 0
                    self.passwordTextfield.layer.borderWidth = 0.5
                    UIDevice.vibrateHeavy()
                    
                }
                
            } else {
                
                self.errorLabel.text = "Invalid Email"
                self.emailTextField.layer.borderWidth = 0.5
                self.passwordTextfield.layer.borderWidth = 0
                UIDevice.vibrateHeavy()
                
            }
        }
    }
    
    func registerUser(usersEmailAddress : String, usersPassword : String, fullName : String, signInMethod : String) {
        
        Service.shared.FirebaseRegistrationAndLogin(usersEmailAddress: usersEmailAddress, usersPassword: usersPassword, fullName: fullName, signInMethod: signInMethod) { isSuccess, response, responseCode in
            
            if isSuccess {
                self.mainLoadingScreen.cancelMainLoadingScreen()
                self.presentHomeController()
            } else {
                self.mainLoadingScreen.cancelMainLoadingScreen()
                AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Seems we had an error registering. Please try again.") { complete in
                    print("user had an error registering...")
                }
            }
        }
    }
    
    func logUserIn(usersEmailAddress : String, usersPassword : String) {
        
        Service.shared.FirebaseLogin(usersEmailAddress: usersEmailAddress, usersPassword: usersPassword) { isSuccess, response, responseCode in
            
            if isSuccess {
                self.mainLoadingScreen.cancelMainLoadingScreen()
                self.presentHomeController()
                
            } else {
                self.mainLoadingScreen.cancelMainLoadingScreen()
                AlertControllerCompletion.handleAlertWithCompletion(title: "Error", message: "Seems we had an error logging in. Check your credentials and try again.") { complete in
                    print("user had an error logging in...")
                }
            }
        }
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func presentHomeController() {
        
        let homeController = HomeController()
        let nav = UINavigationController(rootViewController: homeController)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @objc func handleForgotPasswordButton() {
        print("forgot pw")
    }
}
