//
//  SocialSecurityController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//


class SocialSecurityController : UIViewController, UITextFieldDelegate {
    
    
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
//        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)

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
//        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)

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
//        etfc.addTarget(self, action: #selector(self.handleResponders(textField:)), for: UIControl.Event.editingChanged)

        return etfc
        
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
    
    @objc func handleAuthorizeButton() {
        
        let socialSecuritySuccessController = SocialSecuritySuccessController()
        socialSecuritySuccessController.navigationController?.navigationBar.isHidden = true
        socialSecuritySuccessController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(socialSecuritySuccessController, animated: true)
       
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
