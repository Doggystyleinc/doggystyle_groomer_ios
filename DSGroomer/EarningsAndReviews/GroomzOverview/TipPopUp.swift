//
//  TipPopUp.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/17/21.
//

import Foundation
import UIKit


class TipPopUp : UIView {
    
    var groomzOverview : GroomzOverview?
    
    lazy var cancelButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .timesCircle), for: .normal)
        cbf.setTitleColor(dsFlatBlack.withAlphaComponent(0.4), for: .normal)
        cbf.addTarget(self, action: #selector(self.handleCancelButton), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    let thanksLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Thanks sent!"
        thl.font = UIFont(name: dsHeaderFont, size: 24)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreBlackColor
        return thl
        
    }()
    
    var thankYouContainerView : UIView = {
        
        let tyc = UIView()
        tyc.translatesAutoresizingMaskIntoConstraints = false
        tyc.backgroundColor = notificationGrey
        tyc.isUserInteractionEnabled = false
        tyc.layer.masksToBounds = true
        tyc.layer.cornerRadius = 7
        
       return tyc
    }()
    
    let dsLogoImage : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .red
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = false
        let image = UIImage(named: "AppIcon")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        dcl.layer.masksToBounds = true
        dcl.layer.cornerRadius = 4
        
        return dcl
    }()
    
    let doggystylistLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "DOGGYSTYLIST"
        thl.font = UIFont(name: rubikRegular, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = softGrey
        return thl
        
    }()
    
    let responseLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "McLovin says thanks for the tip! 🐶"
        thl.font = UIFont(name: rubikRegular, size: 13)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsLightBlack
        return thl
        
    }()
    
    let notificationSentLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "We sent a notification to the\nowner to thank them!"
        thl.font = UIFont(name: rubikMedium, size: 20)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    lazy var backToGroomzButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Back to Groomz", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleCancelButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = true
        self.backgroundColor = coreWhiteColor
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 463)
        self.addViews()
        
    }
   
    func addViews() {
        
        self.addSubview(self.cancelButton)
        self.addSubview(self.thanksLabel)
        self.addSubview(self.thankYouContainerView)
        
        self.thankYouContainerView.addSubview(self.dsLogoImage)
        self.thankYouContainerView.addSubview(self.doggystylistLabel)
        self.thankYouContainerView.addSubview(self.responseLabel)
        self.addSubview(self.notificationSentLabel)
        self.addSubview(self.backToGroomzButton)

        self.cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.cancelButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.thanksLabel.topAnchor.constraint(equalTo: self.cancelButton.bottomAnchor, constant: 20).isActive = true
        self.thanksLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.thanksLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.thanksLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.thankYouContainerView.topAnchor.constraint(equalTo: self.thanksLabel.bottomAnchor, constant: 35).isActive = true
        self.thankYouContainerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
        self.thankYouContainerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        self.thankYouContainerView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        
        self.dsLogoImage.topAnchor.constraint(equalTo: self.thankYouContainerView.topAnchor, constant: 14).isActive = true
        self.dsLogoImage.leftAnchor.constraint(equalTo: self.thankYouContainerView.leftAnchor, constant: 19).isActive = true
        self.dsLogoImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.dsLogoImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.doggystylistLabel.centerYAnchor.constraint(equalTo: self.dsLogoImage.centerYAnchor, constant: 0).isActive = true
        self.doggystylistLabel.leftAnchor.constraint(equalTo: self.dsLogoImage.rightAnchor, constant: 10).isActive = true
        self.doggystylistLabel.rightAnchor.constraint(equalTo: self.thankYouContainerView.rightAnchor, constant: -20).isActive = true
        self.doggystylistLabel.sizeToFit()
        
        self.responseLabel.topAnchor.constraint(equalTo: self.dsLogoImage.bottomAnchor, constant: 15).isActive = true
        self.responseLabel.leftAnchor.constraint(equalTo: self.dsLogoImage.rightAnchor, constant: 10).isActive = true
        self.responseLabel.rightAnchor.constraint(equalTo: self.thankYouContainerView.rightAnchor, constant: -20).isActive = true
        self.responseLabel.sizeToFit()
        
        self.notificationSentLabel.topAnchor.constraint(equalTo: self.thankYouContainerView.bottomAnchor, constant: 26).isActive = true
        self.notificationSentLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.notificationSentLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.notificationSentLabel.sizeToFit()
        
        self.backToGroomzButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        self.backToGroomzButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.backToGroomzButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.backToGroomzButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    @objc func handleCancelButton() {
        self.groomzOverview?.handleWarningIcon()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        DispatchQueue.main.async {
            self.layer.cornerRadius  = 20
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
