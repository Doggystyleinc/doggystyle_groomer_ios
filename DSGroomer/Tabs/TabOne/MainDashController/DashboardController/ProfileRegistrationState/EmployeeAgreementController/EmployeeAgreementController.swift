//
//  EmployeeAgreementController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//


import Foundation
import UIKit
import FontAwesome_swift
import Firebase

class EmployeeAgreementController : UIViewController, UITextFieldDelegate, CustomAlertCallBackProtocol {
    
    let mainLoadingScreen = MainLoadingScreen(),
        databaseRef = Database.database().reference()
    
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
    
    let headerLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "Employee Agreement"
        hl.font = UIFont(name: dsHeaderFont, size: 24)
        hl.numberOfLines = 2
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsFlatBlack
        
        return hl
    }()
    
    lazy var agreeButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Agree", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleAgreeButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    let termsTextView : UITextView = {
        
        let tv = UITextView()
        tv.backgroundColor = coreWhiteColor
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = coreBlackColor
        tv.textAlignment = .left
        tv.isUserInteractionEnabled = true
        tv.isScrollEnabled = true
        tv.alwaysBounceVertical = true
        tv.alwaysBounceHorizontal = false
        tv.text = "I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. You probably haven't heard of them cred hammock, fingerstache freegan iceland qui fanny pack dolore. Activated charcoal fingerstache eu et craft beer pug semiotics subway tile af. Jianbing cronut stumptown aesthetic sriracha artisan post-ironic snackwave sustainable consectetur blog chicharrones gentrify. Wolf DIY pork belly vaporware man braid mlkshk velit."
        tv.font = UIFont(name: rubikRegular, size: 13)
        tv.isUserInteractionEnabled = true
        tv.isScrollEnabled = true
        tv.isEditable = false
        tv.isSelectable = true
        tv.layer.masksToBounds = true
        tv.layer.cornerRadius = 10
        tv.contentInset = UIEdgeInsets(top: 24, left: 24, bottom: 200, right: 24)
        
       return tv
    }()
    
    let clickToSignContiner : UIView = {
        
        let ctsc = UIView()
        ctsc.translatesAutoresizingMaskIntoConstraints = false
        ctsc.isUserInteractionEnabled = true
        ctsc.backgroundColor = signatureGrey
        
       return ctsc
        
    }()
    
    let signatureLine : UIView = {
        
        let sl = UIView()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.backgroundColor = dsFlatBlack
        
        
       return sl
    }()
    
    lazy var signatureTextField : UITextField = {
        
        let etfc = UITextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        let placeholder = NSAttributedString(string: "Click to sign", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack.withAlphaComponent(0.4)])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .left
        etfc.textColor = dsFlatBlack
        etfc.font = UIFont(name: rubikMedium, size: 16)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.keyboardAppearance = UIKeyboardAppearance.default
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.layer.masksToBounds = true
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 0))
        etfc.isUserInteractionEnabled = true
        etfc.clipsToBounds = false
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.1
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.backgroundColor = .red
        etfc.layer.cornerRadius = 15

        return etfc
        
    }()
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
       
    }
  
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.agreeButton)
        self.view.addSubview(self.signatureTextField)
        self.view.addSubview(self.termsTextView)

        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 63).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 53).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.signatureTextField.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 50).isActive = true
        self.signatureTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.signatureTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.signatureTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.agreeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -63).isActive = true
        self.agreeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.agreeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.agreeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.termsTextView.topAnchor.constraint(equalTo: self.signatureTextField.bottomAnchor, constant: 22).isActive = true
        self.termsTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.termsTextView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.termsTextView.bottomAnchor.constraint(equalTo: self.agreeButton.topAnchor, constant: -29).isActive = true
        
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        self.signatureTextField.resignFirstResponder()
        return false
    }
   
   @objc func handleAgreeButton() {
        
        guard let groomerKey = groomerUserStruct.groomer_child_key_from_playbook else {
            self.mainLoadingScreen.cancelMainLoadingScreen()
            self.handleCustomPopUpAlert(title: "ERROR", message: "Seems to be a systems error. Reach out to support @ \(Statics.SUPPORT_EMAIL_ADDRESS)", passedButtons: [Statics.GOT_IT])
            return
        }
        
        self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.LOADING_ANIMATION_GENERAL)

        let screenShotAsImage = self.view.takeScreenshotOfView()
        let timeStamp : Double = Date().timeIntervalSince1970
        var ipAddress : String = ""
        
        if let addr = getWiFiAddress() {
            ipAddress = addr
        } else {
            ipAddress = "nil"
        }
        
            Service.shared.uploadEmployeeAgreementPhoto(imageToUpload: screenShotAsImage) { isComplete, photoURL in
                
                if isComplete {
                    
                    let ref = self.databaseRef.child("play_books").child(groomerKey).child("employee_agreement_trace")
                    
                    let valuesArray : [String : Any] = ["employee_signature_screenshot" : photoURL, "employee_signature_time_stamp" : timeStamp, "ip_address" : ipAddress]

                    ref.updateChildValues(valuesArray) { err, ref in
                        
                        if err != nil {
                            self.mainLoadingScreen.cancelMainLoadingScreen()
                            self.handleCustomPopUpAlert(title: "ERROR", message: "Seems to be a systems error. Reach out to support @ \(Statics.SUPPORT_EMAIL_ADDRESS)", passedButtons: [Statics.GOT_IT])
                        } else {
                            
                            let values : [String : Any] = ["groomer_has_completed_employee_agreement" : true]
                            
                            let refTwo = self.databaseRef.child("play_books").child(groomerKey)
                            
                            refTwo.updateChildValues(values) { error, ref in
                                
                                //MARK: - SUCCESS
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Statics.RUN_DATA_ENGINE), object: self)
                                self.mainLoadingScreen.cancelMainLoadingScreen()
                                self.handleBackButton()
                                
                            }
                        }
                    }
                } else {
                    self.mainLoadingScreen.cancelMainLoadingScreen()
                    self.handleCustomPopUpAlert(title: "ERROR", message: "Seems to be a systems error. Reach out to support @ \(Statics.SUPPORT_EMAIL_ADDRESS)", passedButtons: [Statics.GOT_IT])
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

        case "\(Statics.GOT_IT)": self.handleBackButton()
        case "\(Statics.OK)": print("do nothing here")

        default: print("never")
            
        }
    }
    
    
    @objc func handleBackButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNextButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
}
