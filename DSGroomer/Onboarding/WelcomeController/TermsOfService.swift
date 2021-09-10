//
//  TermsOfService.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/10/21.
//

import Foundation
import UIKit
import FontAwesome_swift

class TermsOfServiceController : UIViewController {
    
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
        hl.text = "Doggystyle’s Terms\nof Service"
        hl.font = UIFont(name: dsHeaderFont, size: 24)
        hl.numberOfLines = 2
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsFlatBlack
        
        return hl
    }()
    
    let subHeaderLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "To join the Doggystylist team, please read and agree to Doggystyle’s Terms of Service."
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = -1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
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
        tv.text = "Last Updated: August 24th, 2021\n\nI'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. You probably haven't heard of them cred hammock, fingerstache freegan iceland qui fanny pack dolore. Activated charcoal fingerstache eu et craft beer pug semiotics subway tile af. Jianbing cronut stumptown aesthetic sriracha artisan post-ironic snackwave sustainable consectetur blog chicharrones gentrify. Wolf DIY pork belly vaporware man braid mlkshk velit. Cray magna brunch keffiyeh, pok pok aute pour-over nisi distillery leggings kale chips asymmetrical. I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. Man braid kitsch you probably haven't heard of them migas keffiyeh : I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. You probably haven't heard of them cred hammock, fingerstache freegan iceland qui fanny pack dolore. Activated charcoal fingerstache eu et craft beer pug semiotics subway tile af. Jianbing cronut stumptown aesthetic sriracha artisan post-ironic snackwave sustainable consectetur blog chicharrones gentrify. Wolf DIY pork belly vaporware man braid mlkshk velit. Cray magna brunch keffiyeh, pok pok aute pour-over nisi distillery leggings kale chips asymmetrical. I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. Man braid kitsch you probably haven't heard of them migas keffiyeh : I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. You probably haven't heard of them cred hammock, fingerstache freegan iceland qui fanny pack dolore. Activated charcoal fingerstache eu et craft beer pug semiotics subway tile af. Jianbing cronut stumptown aesthetic sriracha artisan post-ironic snackwave sustainable consectetur blog chicharrones gentrify. Wolf DIY pork belly vaporware man braid mlkshk velit. Cray magna brunch keffiyeh, pok pok aute pour-over nisi distillery leggings kale chips asymmetrical. I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. Man braid kitsch you probably haven't heard of them migas keffiyeh : I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. You probably haven't heard of them cred hammock, fingerstache freegan iceland qui fanny pack dolore. Activated charcoal fingerstache eu et craft beer pug semiotics subway tile af. Jianbing cronut stumptown aesthetic sriracha artisan post-ironic snackwave sustainable consectetur blog chicharrones gentrify. Wolf DIY pork belly vaporware man braid mlkshk velit. Cray magna brunch keffiyeh, pok pok aute pour-over nisi distillery leggings kale chips asymmetrical. I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. Man braid kitsch you probably haven't heard of them migas keffiyeh : I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. You probably haven't heard of them cred hammock, fingerstache freegan iceland qui fanny pack dolore. Activated charcoal fingerstache eu et craft beer pug semiotics subway tile af. Jianbing cronut stumptown aesthetic sriracha artisan post-ironic snackwave sustainable consectetur blog chicharrones gentrify. Wolf DIY pork belly vaporware man braid mlkshk velit. Cray magna brunch keffiyeh, pok pok aute pour-over nisi distillery leggings kale chips asymmetrical. I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. Man braid kitsch you probably haven't heard of them migas keffiyeh : I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. You probably haven't heard of them cred hammock, fingerstache freegan iceland qui fanny pack dolore. Activated charcoal fingerstache eu et craft beer pug semiotics subway tile af. Jianbing cronut stumptown aesthetic sriracha artisan post-ironic snackwave sustainable consectetur blog chicharrones gentrify. Wolf DIY pork belly vaporware man braid mlkshk velit. Cray magna brunch keffiyeh, pok pok aute pour-over nisi distillery leggings kale chips asymmetrical. I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. Man braid kitsch you probably haven't heard of them migas keffiyeh"
        tv.font = UIFont(name: rubikRegular, size: 13)
        tv.isUserInteractionEnabled = true
        tv.isScrollEnabled = true
        tv.isEditable = false
        tv.isSelectable = true
        tv.layer.masksToBounds = true
        tv.layer.cornerRadius = 10
        tv.contentInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        
       return tv
    }()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.subHeaderLabel)
        self.view.addSubview(self.agreeButton)
        self.view.addSubview(self.termsTextView)

        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 63).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 53).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.subHeaderLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 14).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.subHeaderLabel.sizeToFit()
        
        self.agreeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -63).isActive = true
        self.agreeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.agreeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.agreeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.termsTextView.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 22).isActive = true
        self.termsTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.termsTextView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.termsTextView.bottomAnchor.constraint(equalTo: self.agreeButton.topAnchor, constant: -29).isActive = true

    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNextButton() {
        
        let notificationsController = NotificationsController()
        notificationsController.modalPresentationStyle = .fullScreen
        notificationsController.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(notificationsController, animated: true)
        
    }
    
}
