//
//  LinkBankSuccessController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//


import Foundation
import UIKit


class LinkBankSuccessController : UIViewController {
    
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
    
    lazy var badgeIcon : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 55, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .checkCircle), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        return cbf
        
    }()
    
    let mainHeaderLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Thank you, your payment information has been securely submitted"
        thl.font = UIFont(name: dsHeaderFont, size: 18)
        thl.numberOfLines = -1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        
        return thl
        
    }()
   
    lazy var goToDashButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Go to dashboard", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 20
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleGoToDashButton), for: .touchUpInside)
        
        return cbf
        
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.badgeIcon)
        self.view.addSubview(self.mainHeaderLabel)
        self.view.addSubview(self.goToDashButton)

        self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 17).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.badgeIcon.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150).isActive = true
        self.badgeIcon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.badgeIcon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.badgeIcon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.mainHeaderLabel.topAnchor.constraint(equalTo: self.badgeIcon.bottomAnchor, constant: 23).isActive = true
        self.mainHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.mainHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.mainHeaderLabel.sizeToFit()
        
        self.goToDashButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.goToDashButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.goToDashButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -53).isActive = true
        self.goToDashButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    @objc func handleGoToDashButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
