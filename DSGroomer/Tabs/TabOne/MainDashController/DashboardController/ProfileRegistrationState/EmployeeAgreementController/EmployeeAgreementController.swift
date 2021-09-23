//
//  EmployeeAgreementController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//


import Foundation
import UIKit
import FontAwesome_swift

class EmployeeAgreementController : UIViewController, UITextFieldDelegate {
    
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
        cbf.addTarget(self, action: #selector(self.handleNextButton), for: .touchUpInside)
        
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
        let placeholder = NSAttributedString(string: "X Click to sign", attributes: [NSAttributedString.Key.foregroundColor: dsFlatBlack])
        etfc.attributedPlaceholder = placeholder
        etfc.textAlignment = .left
        etfc.textColor = dsFlatBlack
        etfc.font = UIFont(name: rubikMedium, size: 16)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = UIColor .clear
        etfc.keyboardAppearance = UIKeyboardAppearance.default
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .numberPad
        etfc.layer.masksToBounds = true
        etfc.isSecureTextEntry = false
        etfc.leftViewMode = .always
        etfc.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

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
        self.view.addSubview(self.termsTextView)
        self.view.addSubview(self.clickToSignContiner)
        self.clickToSignContiner.addSubview(self.signatureLine)
        self.clickToSignContiner.addSubview(self.signatureTextField)

        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 63).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 53).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.termsTextView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 22).isActive = true
        self.termsTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.termsTextView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.termsTextView.bottomAnchor.constraint(equalTo: self.agreeButton.topAnchor, constant: -29).isActive = true
        
        self.agreeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -63).isActive = true
        self.agreeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.agreeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.agreeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.clickToSignContiner.bottomAnchor.constraint(equalTo: self.termsTextView.bottomAnchor, constant: -30).isActive = true
        self.clickToSignContiner.leftAnchor.constraint(equalTo: self.termsTextView.leftAnchor, constant: 25).isActive = true
        self.clickToSignContiner.rightAnchor.constraint(equalTo: self.termsTextView.rightAnchor, constant: -25).isActive = true
        self.clickToSignContiner.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.signatureLine.leftAnchor.constraint(equalTo: self.clickToSignContiner.leftAnchor, constant: 20).isActive = true
        self.signatureLine.rightAnchor.constraint(equalTo: self.clickToSignContiner.rightAnchor, constant: -20).isActive = true
        self.signatureLine.bottomAnchor.constraint(equalTo: self.clickToSignContiner.bottomAnchor, constant: -30).isActive = true
        self.signatureLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.signatureTextField.bottomAnchor.constraint(equalTo: self.signatureLine.topAnchor, constant: -3).isActive = true
        self.signatureTextField.leftAnchor.constraint(equalTo: self.signatureLine.leftAnchor, constant: 0).isActive = true
        self.signatureTextField.rightAnchor.constraint(equalTo: self.signatureLine.rightAnchor, constant: 0).isActive = true
        self.signatureTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    @objc func handleBackButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleNextButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
}
