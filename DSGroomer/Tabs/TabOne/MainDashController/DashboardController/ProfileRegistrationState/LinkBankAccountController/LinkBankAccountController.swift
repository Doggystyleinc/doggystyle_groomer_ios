//
//  LinkBankAccountController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//

import Foundation
import UIKit
import Firebase

class LinkBankAccountController : UIViewController, UITextFieldDelegate, UIScrollViewDelegate, CustomAlertCallBackProtocol {
    
var lastKeyboardHeight : CGFloat = 0.0,
    contentHeight : CGFloat = 560,
    isKeyboardShowing : Bool = false
    
    let databaseRef = Database.database().reference(),
        mainLoadingScreen = MainLoadingScreen()
    
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
        cbf.addTarget(self, action: #selector(self.runSaveLogic), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var scrollView : UIScrollView = {
        
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = coreBackgroundWhite
        sv.isScrollEnabled = true
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 1.0
        sv.bounces = true
        sv.bouncesZoom = true
        sv.isHidden = false
        sv.delegate = self
        sv.contentMode = .scaleAspectFit
        sv.isUserInteractionEnabled = true
        sv.delaysContentTouches = true
        
        return sv
        
    }()
    
    let contentView : UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.isUserInteractionEnabled = true
        return cv
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = coreBackgroundWhite
        self.scrollView.keyboardDismissMode = .interactive
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
    
    func addViews() {
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)

        self.contentView.addSubview(self.backButton)
        self.contentView.addSubview(self.dsCompanyLogoImage)
        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.subHeaderLabel)
        self.contentView.addSubview(self.routingNumberTextField)
        self.contentView.addSubview(self.accountNumberTextField)
        self.contentView.addSubview(self.confirmAccountNumberTextField)
        self.contentView.addSubview(self.saveAndContinueButton)
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.contentHeight + self.lastKeyboardHeight)
        
        self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0).isActive = true
        self.contentView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 0).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: 0).isActive = true
        self.contentView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        self.contentView.heightAnchor.constraint(equalToConstant: 550).isActive = true

        self.backButton.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 17).isActive = true
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
        self.saveAndContinueButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.saveAndContinueButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    func resignation() {
        
        self.routingNumberTextField.resignFirstResponder()
        self.accountNumberTextField.resignFirstResponder()
        self.confirmAccountNumberTextField.resignFirstResponder()
        
    }
    
    @objc func adjustContentSize() {
        
        self.scrollView.layoutIfNeeded()
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.contentHeight + self.lastKeyboardHeight)
        self.scrollView.scrollToBottom()
        
    }
    
    @objc func handleKeyboardShow(notification : Notification) {
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        if keyboardRectangle.height > 200 {
            
            if self.isKeyboardShowing == true {return}
            self.isKeyboardShowing = true
            
            self.lastKeyboardHeight = keyboardRectangle.height
            self.perform(#selector(self.handleKeyboardMove), with: nil, afterDelay: 0.1)
            
        }
    }
    
    @objc func handleKeyboardHide(notification : Notification) {
        
        self.isKeyboardShowing = false
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        self.lastKeyboardHeight = keyboardRectangle.height
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.contentHeight)
    }
    
    @objc func handleKeyboardMove() {
        self.adjustContentSize()
    }
    
    @objc func runSaveLogic() {
         
        guard let routingNumber = self.routingNumberTextField.text else {return}
        guard let accountNumber = self.accountNumberTextField.text else {return}
        guard let confirmAccountNumber = self.confirmAccountNumberTextField.text else {return}
        
        let cleanRoutingNumber = routingNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanAccountNumber = accountNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanConfirmAccountNumber = confirmAccountNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.resignation()
        
        if cleanRoutingNumber.count >= 5 {
            self.routingNumberTextField.layer.borderColor = UIColor .clear.cgColor
            if cleanAccountNumber.count >= 5 {
                self.accountNumberTextField.layer.borderColor = UIColor .clear.cgColor
                if cleanConfirmAccountNumber.count >= 5 {
                    
                    self.routingNumberTextField.layer.borderColor = UIColor .clear.cgColor
                    self.accountNumberTextField.layer.borderColor = UIColor .clear.cgColor
                    self.confirmAccountNumberTextField.layer.borderColor = UIColor .clear.cgColor

                    self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.LOADING_ANIMATION_GENERAL)
                    let groomerKey = groomerUserStruct.groomer_child_key_from_playbook ?? "nil"
                    
                    if groomerKey == "nil" {
                        
                        self.mainLoadingScreen.cancelMainLoadingScreen()
                        self.handleCustomPopUpAlert(title: "ERROR", message: "Seems to be a systems error. Reach out to support @ \(Statics.SUPPORT_EMAIL_ADDRESS)", passedButtons: ["Got it"])
                       
                        
                    } else {

                        let ref = self.databaseRef.child("play_books").child(groomerKey)
                        let values : [String : Any] = ["groomer_has_completed_payment_preferences" : true]

                        ref.updateChildValues(values) { error, ref in

                            if error != nil {

                                self.mainLoadingScreen.cancelMainLoadingScreen()
                                self.handleCustomPopUpAlert(title: "ERROR", message: "Seems to be a systems error. Reach out to support @ \(Statics.SUPPORT_EMAIL_ADDRESS)", passedButtons: ["Got it"])

                                return
                            }

                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Statics.RUN_DATA_ENGINE), object: self)

                            self.mainLoadingScreen.cancelMainLoadingScreen()
                            self.handleSaveAndContinueButton()
                        }
                    }
                    
                } else {
                    self.confirmAccountNumberTextField.layer.borderColor = coreRedColor.cgColor
                }
            } else {
                self.accountNumberTextField.layer.borderColor = coreRedColor.cgColor
            }
        } else {
            self.routingNumberTextField.layer.borderColor = coreRedColor.cgColor
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
        
        case "Got it": self.handleBackButton()

        case "Ok": print("okay")
            
        default: print("never")
            
        }
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
