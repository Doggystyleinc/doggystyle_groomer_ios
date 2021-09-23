//
//  CriminalRecordControllers.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//


import Foundation
import UIKit


class CriminalRecordController : UIViewController {
    
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
        hl.text = "Criminal Record Check"
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
        hl.text = "For the safety of our fellow team members and clients, Criminal Record checks are required.\n\nYou’ll receive an email to complete your Criminal Record Check. You’ll need the following:"
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = -1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    let disclosureLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "• Current Driver’s Licence\n• One of the following:"
        hl.font = UIFont(name: rubikBold, size: 16)
        hl.numberOfLines = 2
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    let disclosureDescriptionLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "• Passport\n• Canadian Citizenship Card\n• Permanent Resident Card\n• Birth Certificate\n• Health Card\n• Government Employment Card\n• Student Card\n• Indian Status Card\n• Hospital Card\n• Credit Card or Debit Card"
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = -1
        hl.adjustsFontSizeToFitWidth = false
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    lazy var agreeButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("I understand", for: UIControl.State.normal)
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
        cbf.addTarget(self, action: #selector(self.handleNextButton), for: .touchUpInside)
        
        return cbf
        
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
        self.view.addSubview(self.disclosureLabel)
        self.view.addSubview(self.disclosureDescriptionLabel)
        self.view.addSubview(self.agreeButton)

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
        
        self.disclosureLabel.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 30).isActive = true
        self.disclosureLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.disclosureLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.disclosureLabel.sizeToFit()
        
        self.disclosureDescriptionLabel.topAnchor.constraint(equalTo: self.disclosureLabel.bottomAnchor, constant: 5).isActive = true
        self.disclosureDescriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        self.disclosureDescriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.disclosureDescriptionLabel.sizeToFit()
      
        self.agreeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.agreeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.agreeButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -53).isActive = true
        self.agreeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    @objc func handleNextButton() {
        
        let socialSecurityController = SocialSecurityController()
        socialSecurityController.navigationController?.navigationBar.isHidden = true
        socialSecurityController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(socialSecurityController, animated: true)
       
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
