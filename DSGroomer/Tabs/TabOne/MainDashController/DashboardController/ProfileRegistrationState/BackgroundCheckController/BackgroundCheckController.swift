//
//  BackgroundCheckController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/20/21.
//

import Foundation
import UIKit


class BackgroundCheckController : UIViewController {
    
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
        hl.text = "Background check"
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
        hl.text = "For the safety of our fellow team members and clients, background checks are required"
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = 2
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    let disclosureLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "DISCLOSURES FINE PRINT HERE:"
        hl.font = UIFont(name: rubikBold, size: 13)
        hl.numberOfLines = 1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    let disclosureDescriptionLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. You probably haven't heard of them cred hammock, fingerstache freegan iceland qui fanny pack dolore. Activated charcoal fingerstache eu et craft beer pug semiotics subway tile af.\n\nYou probably haven't heard of them cred hammock, fingerstache freegan iceland qui fanny pack dolore. Activated charcoal fingerstache eu et craft beer pug semiotics subway tile af."
        hl.font = UIFont(name: rubikRegular, size: 13)
        hl.numberOfLines = -1
        hl.adjustsFontSizeToFitWidth = false
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    let authLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "BACKGROUND CHECK AUTHORIZIATION: "
        hl.font = UIFont(name: rubikBold, size: 13)
        hl.numberOfLines = 1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    let authDescriptionLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "I'm baby stumptown tilde chartreuse yr, irure gochujang laborum YOLO plaid. Ramps irure semiotics occaecat dolore health goth cillum ut. You probably haven't heard of them cred hammock, fingerstache freegan iceland qui fanny pack dolore. Activated charcoal fingerstache eu et craft beer pug semiotics subway tile af. "
        hl.font = UIFont(name: rubikRegular, size: 13)
        hl.numberOfLines = -1
        hl.adjustsFontSizeToFitWidth = false
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    lazy var agreeButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("I agree", for: UIControl.State.normal)
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
        self.view.addSubview(self.authLabel)
        self.view.addSubview(self.authDescriptionLabel)
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
        self.disclosureDescriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.disclosureDescriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.disclosureDescriptionLabel.sizeToFit()
        
        self.authLabel.topAnchor.constraint(equalTo: self.disclosureDescriptionLabel.bottomAnchor, constant: 20).isActive = true
        self.authLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.authLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.authLabel.sizeToFit()
        
        self.authDescriptionLabel.topAnchor.constraint(equalTo: self.authLabel.bottomAnchor, constant: 5).isActive = true
        self.authDescriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.authDescriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.authDescriptionLabel.sizeToFit()
        
        self.agreeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.agreeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.agreeButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -53).isActive = true
        self.agreeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    @objc func handleNextButton() {
        
        let criminalRecordController = CriminalRecordController()
        criminalRecordController.navigationController?.navigationBar.isHidden = true
        criminalRecordController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(criminalRecordController, animated: true)
       
    }
    
    @objc func handleBackButton() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
