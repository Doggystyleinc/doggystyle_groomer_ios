//
//  RegistrationController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/11/21.
//

import UIKit
import PhoneNumberKit

class RegistrationController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UITextViewDelegate {
    
    var screenHeight = UIScreen.main.bounds.height,
        isKeyboardPresented : Bool = false,
        phoneNumber : String?,
        countryCode : String?,
        groomersFirstName : String?,
        groomersLastName : String?,
        groomersEmail : String?,
        lastKeyboardHeight : CGFloat = 0.0,
        contentOffSet : CGFloat = 0.0,
        contentHeight : CGFloat = 845.0,
        isKeyboardShowing : Bool = false
    
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.tintColor = coreOrangeColor
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: UIControl.Event.touchUpInside)
        cbf.isHidden = true
        return cbf
        
    }()
    
    let logo : UIImageView = {
        
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
        hl.text = "Hi! Let’s verify and complete your registration"
        hl.font = UIFont(name: dsHeaderFont, size: 24)
        hl.numberOfLines = -1
        hl.adjustsFontSizeToFitWidth = false
        hl.textAlignment = .left
        
        return hl
    }()
    
    lazy var firstNameTextField: CustomTextField = {
        
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
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.isUserInteractionEnabled = true
        etfc.isEnabled = false
        etfc.addTarget(self, action: #selector(self.handleFirstNameTextFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handleFirstNameTextFieldBegin), for: .touchDown)
        
        return etfc
        
    }()
    
    let typingFirstNameLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = coreWhiteColor
        tel.text = "First name"
        tel.font = UIFont(name: rubikBold, size: 13)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = true
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    let placeHolderFirstNameLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "First name"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    lazy var lastNameTextField: CustomTextField = {
        
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
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.isUserInteractionEnabled = true
        etfc.isEnabled = false
        etfc.addTarget(self, action: #selector(self.handleLastNameTextFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handleLastNameTextFieldBegin), for: .touchDown)
        
        return etfc
        
    }()
    
    let typingLastNameLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = coreWhiteColor
        tel.text = "Last name"
        tel.font = UIFont(name: rubikBold, size: 13)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = true
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    let placeHolderLastNameLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "Last name"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    lazy var referralTextField: CustomTextField = {
        
        let etfc = CustomTextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: rubikRegular, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .alphabet
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 8
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
        etfc.addTarget(self, action: #selector(self.handleReferralTextFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handleReferralTextFieldBegin), for: .touchDown)
        
        return etfc
        
    }()
    
    let typingReferralLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = coreWhiteColor
        tel.text = "Referral code (optional)"
        tel.font = UIFont(name: rubikBold, size: 13)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = true
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    let placeHolderReferralLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "Referral code"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
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
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.isUserInteractionEnabled = true
        etfc.isEnabled = false
        etfc.addTarget(self, action: #selector(self.handleEmailTextFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handleEmailTextFieldBegin), for: .touchDown)
        
        return etfc
        
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
    
    let placeHolderEmailLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "Email"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    lazy var passwordTextField: CustomPasswordTextField = {
        
        let etfc = CustomPasswordTextField()
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
        etfc.layer.masksToBounds = false
        etfc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        etfc.layer.shadowOpacity = 0.05
        etfc.layer.shadowOffset = CGSize(width: 2, height: 3)
        etfc.layer.shadowRadius = 9
        etfc.layer.shouldRasterize = false
        etfc.isSecureTextEntry = true
        etfc.setRightPaddingPoints(50)
        etfc.addTarget(self, action: #selector(self.handlePasswordTextFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handlePasswordTextFieldBegin), for: .touchDown)
        etfc.isMultipleTouchEnabled = true
        
        return etfc
        
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
        tel.isMultipleTouchEnabled = true
        
        return tel
    }()
    
    let placeHolderPasswordLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "Create password"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        tel.isMultipleTouchEnabled = true
        
        return tel
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
    
    lazy var cityTextField: CustomTextField = {
        
        let etfc = CustomTextField()
        etfc.translatesAutoresizingMaskIntoConstraints = false
        etfc.textAlignment = .left
        etfc.textColor = coreBlackColor
        etfc.font = UIFont(name: rubikRegular, size: 18)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = coreWhiteColor
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .alphabet
        etfc.layer.masksToBounds = true
        etfc.layer.cornerRadius = 8
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
        etfc.addTarget(self, action: #selector(self.handleCityTextFieldChange), for: .editingChanged)
        etfc.addTarget(self, action: #selector(self.handleCityTextFieldBegin), for: .touchDown)
        
        return etfc
        
    }()
    
    let typingCityLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = coreWhiteColor
        tel.text = "City"
        tel.font = UIFont(name: rubikBold, size: 13)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = true
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    let placeHolderCityLabel : UILabel = {
        
        let tel = UILabel()
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.backgroundColor = .clear
        tel.text = "City"
        tel.font = UIFont(name: rubikRegular, size: 18)
        tel.textAlignment = .left
        tel.translatesAutoresizingMaskIntoConstraints = false
        tel.isHidden = false
        tel.textColor = dsFlatBlack.withAlphaComponent(0.4)
        
        return tel
    }()
    
    lazy var confirmButton: UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Confirm", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.layer.cornerRadius = 18
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.backgroundColor = coreOrangeColor
        cbf.addTarget(self, action: #selector(self.handleConfirmButton), for: .touchUpInside)
        
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
    
    let timeCover : UIView = {
        
        let tc = UIView()
        tc.translatesAutoresizingMaskIntoConstraints = false
        tc.isUserInteractionEnabled = false
        tc.backgroundColor = coreBackgroundWhite
        
        return tc
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
        self.navigationController?.navigationBar.isHidden = true
        
        self.addViews()
        self.consumeAndSetData()
        self.setupObserversAndContentTypes()
        self.handleFirstNameTextFieldBegin()
        self.handleLastNameTextFieldBegin()
        self.handleEmailTextFieldBegin()
        
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
        self.view.addSubview(self.timeCover)
        
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.backButton)
        self.contentView.addSubview(self.dsCompanyLogoImage)
        self.contentView.addSubview(self.headerLabel)
        
        self.contentView.addSubview(self.firstNameTextField)
        self.contentView.addSubview(self.lastNameTextField)
        self.contentView.addSubview(self.referralTextField)
        self.contentView.addSubview(self.emailTextField)
        self.contentView.addSubview(self.showHideEyeButton)
        
        self.contentView.addSubview(self.placeHolderFirstNameLabel)
        self.contentView.addSubview(self.typingFirstNameLabel)
        
        self.contentView.addSubview(self.placeHolderLastNameLabel)
        self.contentView.addSubview(self.typingLastNameLabel)
        
        self.contentView.addSubview(self.placeHolderReferralLabel)
        self.contentView.addSubview(self.typingReferralLabel)
        
        self.contentView.addSubview(self.placeHolderEmailLabel)
        self.contentView.addSubview(self.typingEmailLabel)
        
        self.contentView.addSubview(self.passwordTextField)
        self.contentView.addSubview(self.placeHolderPasswordLabel)
        self.contentView.addSubview(self.typingPasswordLabel)
        
        self.contentView.addSubview(self.cityTextField)
        self.contentView.addSubview(self.typingCityLabel)
        self.contentView.addSubview(self.placeHolderCityLabel)
        
        self.contentView.addSubview(self.confirmButton)
        
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
        self.contentView.heightAnchor.constraint(equalToConstant: 835).isActive = true
        
        self.timeCover.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.timeCover.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.timeCover.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.timeCover.heightAnchor.constraint(equalToConstant: globalStatusBarHeight).isActive = true
        
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
        
        self.firstNameTextField.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 15).isActive = true
        self.firstNameTextField.leftAnchor.constraint(equalTo: self.headerLabel.leftAnchor, constant: 0).isActive = true
        self.firstNameTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.firstNameTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderFirstNameLabel.leftAnchor.constraint(equalTo: self.firstNameTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderFirstNameLabel.centerYAnchor.constraint(equalTo: self.firstNameTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderFirstNameLabel.sizeToFit()
        
        self.typingFirstNameLabel.leftAnchor.constraint(equalTo: self.firstNameTextField.leftAnchor, constant: 25).isActive = true
        self.typingFirstNameLabel.topAnchor.constraint(equalTo: self.firstNameTextField.topAnchor, constant: 14).isActive = true
        self.typingFirstNameLabel.sizeToFit()
        
        self.lastNameTextField.topAnchor.constraint(equalTo: self.firstNameTextField.bottomAnchor, constant: 20).isActive = true
        self.lastNameTextField.leftAnchor.constraint(equalTo: self.firstNameTextField.leftAnchor, constant: 0).isActive = true
        self.lastNameTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.lastNameTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderLastNameLabel.leftAnchor.constraint(equalTo: self.lastNameTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderLastNameLabel.centerYAnchor.constraint(equalTo: self.lastNameTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderLastNameLabel.sizeToFit()
        
        self.typingLastNameLabel.leftAnchor.constraint(equalTo: self.lastNameTextField.leftAnchor, constant: 25).isActive = true
        self.typingLastNameLabel.topAnchor.constraint(equalTo: self.lastNameTextField.topAnchor, constant: 14).isActive = true
        self.typingLastNameLabel.sizeToFit()
        
        self.emailTextField.topAnchor.constraint(equalTo: self.lastNameTextField.bottomAnchor, constant: 20).isActive = true
        self.emailTextField.leftAnchor.constraint(equalTo: self.firstNameTextField.leftAnchor, constant: 0).isActive = true
        self.emailTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderEmailLabel.leftAnchor.constraint(equalTo: self.emailTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderEmailLabel.centerYAnchor.constraint(equalTo: self.emailTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderEmailLabel.sizeToFit()
        
        self.typingEmailLabel.leftAnchor.constraint(equalTo: self.emailTextField.leftAnchor, constant: 25).isActive = true
        self.typingEmailLabel.topAnchor.constraint(equalTo: self.emailTextField.topAnchor, constant: 14).isActive = true
        self.typingEmailLabel.sizeToFit()
        
        self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 20).isActive = true
        self.passwordTextField.leftAnchor.constraint(equalTo: self.firstNameTextField.leftAnchor, constant: 0).isActive = true
        self.passwordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderPasswordLabel.leftAnchor.constraint(equalTo: self.passwordTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderPasswordLabel.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderPasswordLabel.sizeToFit()
        
        self.typingPasswordLabel.leftAnchor.constraint(equalTo: self.passwordTextField.leftAnchor, constant: 25).isActive = true
        self.typingPasswordLabel.topAnchor.constraint(equalTo: self.passwordTextField.topAnchor, constant: 14).isActive = true
        self.typingPasswordLabel.sizeToFit()
        
        self.showHideEyeButton.rightAnchor.constraint(equalTo: self.passwordTextField.rightAnchor, constant: -10).isActive = true
        self.showHideEyeButton.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor, constant: 0).isActive = true
        self.showHideEyeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.showHideEyeButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.cityTextField.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20).isActive = true
        self.cityTextField.leftAnchor.constraint(equalTo: self.firstNameTextField.leftAnchor, constant: 0).isActive = true
        self.cityTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.cityTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderCityLabel.leftAnchor.constraint(equalTo: self.cityTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderCityLabel.centerYAnchor.constraint(equalTo: self.cityTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderCityLabel.sizeToFit()
        
        self.typingCityLabel.leftAnchor.constraint(equalTo: self.cityTextField.leftAnchor, constant: 25).isActive = true
        self.typingCityLabel.topAnchor.constraint(equalTo: self.cityTextField.topAnchor, constant: 14).isActive = true
        self.typingCityLabel.sizeToFit()
        
        self.referralTextField.topAnchor.constraint(equalTo: self.cityTextField.bottomAnchor, constant: 20).isActive = true
        self.referralTextField.leftAnchor.constraint(equalTo: self.firstNameTextField.leftAnchor, constant: 0).isActive = true
        self.referralTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.referralTextField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.placeHolderReferralLabel.leftAnchor.constraint(equalTo: self.referralTextField.leftAnchor, constant: 30).isActive = true
        self.placeHolderReferralLabel.centerYAnchor.constraint(equalTo: self.referralTextField.centerYAnchor, constant: 0).isActive = true
        self.placeHolderReferralLabel.sizeToFit()
        
        self.typingReferralLabel.leftAnchor.constraint(equalTo: self.referralTextField.leftAnchor, constant: 25).isActive = true
        self.typingReferralLabel.topAnchor.constraint(equalTo: self.referralTextField.topAnchor, constant: 14).isActive = true
        self.typingReferralLabel.sizeToFit()
        
        self.confirmButton.leftAnchor.constraint(equalTo: self.referralTextField.leftAnchor, constant: 0).isActive = true
        self.confirmButton.rightAnchor.constraint(equalTo: self.referralTextField.rightAnchor, constant: 0).isActive = true
        self.confirmButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        self.confirmButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
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
    
    func consumeAndSetData() {
        
        let groomersFirstName = self.groomersFirstName ?? "Incognito"
        let groomersLastName = self.groomersLastName ?? "Incognito"
        let groomersEmail = self.groomersEmail ?? "Incognito"
        
        self.firstNameTextField.text = "\(groomersFirstName)"
        self.lastNameTextField.text = "\(groomersLastName)"
        self.emailTextField.text = "\(groomersEmail)"
        
        self.headerLabel.text = "Hi \(groomersFirstName)! Let’s verify and complete your registration"
        
    }
    
    func setupObserversAndContentTypes() {
        
        self.firstNameTextField.textContentType = UITextContentType(rawValue: "")
        self.lastNameTextField.textContentType = UITextContentType(rawValue: "")
        self.referralTextField.textContentType = UITextContentType(rawValue: "")
        self.emailTextField.textContentType = UITextContentType(rawValue: "")
        self.passwordTextField.textContentType = UITextContentType(rawValue: "")
        
        self.scrollView.keyboardDismissMode = .interactive
        
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
    
    @objc func resignation() {
        
        self.firstNameTextField.resignFirstResponder()
        self.lastNameTextField.resignFirstResponder()
        self.referralTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.cityTextField.resignFirstResponder()
        
    }
    
    @objc func handleFirstNameTextFieldChange() {
        if self.firstNameTextField.text != "" {
            typingFirstNameLabel.isHidden = false
            placeHolderFirstNameLabel.isHidden = true
        }
    }
    
    @objc func handleFirstNameTextFieldBegin() {
        self.typingFirstNameLabel.isHidden = false
        self.placeHolderFirstNameLabel.isHidden = true
    }
    
    @objc func handleLastNameTextFieldChange() {
        if self.lastNameTextField.text != "" {
            typingLastNameLabel.isHidden = false
            placeHolderLastNameLabel.isHidden = true
        }
    }
    
    @objc func handleLastNameTextFieldBegin() {
        self.typingLastNameLabel.isHidden = false
        self.placeHolderLastNameLabel.isHidden = true
    }
    
    @objc func handleReferralTextFieldChange() {
        if self.referralTextField.text != "" {
            typingReferralLabel.isHidden = false
            placeHolderReferralLabel.isHidden = true
        }
    }
    
    @objc func handleReferralTextFieldBegin() {
        self.typingReferralLabel.isHidden = false
        self.placeHolderReferralLabel.isHidden = true
    }
    
    @objc func handleCityTextFieldChange() {
        if self.cityTextField.text != "" {
            typingCityLabel.isHidden = false
            placeHolderCityLabel.isHidden = true
        }
    }
    
    @objc func handleCityTextFieldBegin() {
        self.typingCityLabel.isHidden = false
        self.placeHolderCityLabel.isHidden = true
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
    
    @objc func handlePasswordTextFieldChange() {
        
        if self.passwordTextField.text != "" {
            typingPasswordLabel.isHidden = false
            placeHolderPasswordLabel.isHidden = true
        }
    }
    
    @objc func handlePasswordTextFieldBegin() {
        self.typingPasswordLabel.isHidden = false
        self.placeHolderPasswordLabel.isHidden = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.handleConfirmButton()
        return false
        
    }
    
    @objc func handleConfirmButton() {
        
        self.resignation()
        UIDevice.vibrateLight()
        self.scrollView.scrollToTop()
        self.handleValidationChecks()
    }
    
    func handleValidationChecks() {
        
        guard let firstNameTextField = self.firstNameTextField.text else {return}
        guard let lastNameTextField = self.lastNameTextField.text else {return}
        guard let emailNameTextField = self.emailTextField.text else {return}
        guard let passwordNameTextField = self.passwordTextField.text else {return}
        guard let cityTextField = self.cityTextField.text else {return}
        
        let cleanFirstName = firstNameTextField.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanLastName = lastNameTextField.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanEmail = emailNameTextField.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = passwordNameTextField.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanCity = cityTextField.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanFirstName.count > 2 {
            self.firstNameTextField.layer.borderColor = UIColor .clear.cgColor
            if cleanLastName.count > 4 {
                self.lastNameTextField.layer.borderColor = UIColor .clear.cgColor
                if cleanEmail.count > 2 && cleanEmail.contains("@") && cleanEmail.contains(".") {
                    self.emailTextField.layer.borderColor = UIColor .clear.cgColor
                    if cleanPassword.count > 3 {
                        self.passwordTextField.layer.borderColor = UIColor .clear.cgColor
                        if cleanCity.count > 2 {
                            
                            self.firstNameTextField.layer.borderColor = UIColor .clear.cgColor
                            self.lastNameTextField.layer.borderColor = UIColor .clear.cgColor
                            self.emailTextField.layer.borderColor = UIColor .clear.cgColor
                            self.passwordTextField.layer.borderColor = UIColor .clear.cgColor
                            self.cityTextField.layer.borderColor = UIColor .clear.cgColor
                            
                            //all systems go here! - check the referral code
                            
                            let referralCode = self.referralTextField.text ?? "nil"
                            
                            if referralCode.count > 0 && referralCode != "nil" {
                                
                                print("USER HAS A REFERRAL CODE")
                                groomerOnboardingStruct.groomers_city = cleanCity
                                groomerOnboardingStruct.groomers_referral_code = referralCode
                                groomerOnboardingStruct.groomers_password = cleanPassword

                                self.handleCompleteButton()
                                
                            } else {
                                
                                print("USER DOES NOT HAVE A REFERRAL CODE")
                                groomerOnboardingStruct.groomers_city = cleanCity
                                groomerOnboardingStruct.groomers_referral_code = "nil"
                                groomerOnboardingStruct.groomers_password = cleanPassword
                               
                                self.handleCompleteButton()
                                
                            }
                            
                        } else {
                            self.cityTextField.layer.borderColor = coreRedColor.cgColor
                        }
                        
                    } else {
                        self.passwordTextField.layer.borderColor = coreRedColor.cgColor
                    }
                    
                } else {
                    self.emailTextField.layer.borderColor = coreRedColor.cgColor
                }
                
            } else {
                self.lastNameTextField.layer.borderColor = coreRedColor.cgColor
            }
            
        } else {
            self.firstNameTextField.layer.borderColor = coreRedColor.cgColor
        }
    }
    
    @objc func handleCompleteButton() {
        
        let termsOfServiceController = TermsOfServiceController()
        termsOfServiceController.modalPresentationStyle = .fullScreen
        termsOfServiceController.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(termsOfServiceController, animated: true)
        
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
