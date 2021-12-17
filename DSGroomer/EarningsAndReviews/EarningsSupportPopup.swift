//
//  EarningsSupportPopup.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/16/21.
//


import Foundation
import UIKit

class EarningsSupportPopup : UIView, CustomAlertCallBackProtocol {
    
    var earningsAndReviews : EarningsAndReviews?
    var groomzDetailsController : GroomzDetailsController?
    
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
    
    let problemLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "What’s the problem?"
        thl.font = UIFont(name: dsHeaderFont, size: 24)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreBlackColor
        return thl
        
    }()
    
    let descriptionLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Payments can take up to 4 business days to show up in your account"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = -1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreBlackColor.withAlphaComponent(0.6)
        return thl
        
    }()
    
    lazy var callHQButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Call HQ", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreOrangeColor
        cbf.addTarget(self, action: #selector(self.handlePhoneCall), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var submitButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Submit", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleSubmitButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var earningsReportingCollection : EarningsSupportCollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let ir = EarningsSupportCollectionView(frame: .zero, collectionViewLayout: layout)
        ir.translatesAutoresizingMaskIntoConstraints = false
        ir.earningsSupportPopup = self
        
        return ir
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreWhiteColor
        self.translatesAutoresizingMaskIntoConstraints = true
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        self.layer.cornerRadius = 20
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.cancelButton)
        self.addSubview(self.problemLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.callHQButton)
        self.addSubview(self.submitButton)
        self.addSubview(self.earningsReportingCollection)
        
        self.cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.cancelButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.problemLabel.topAnchor.constraint(equalTo: self.cancelButton.bottomAnchor, constant: 20).isActive = true
        self.problemLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.problemLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.problemLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.descriptionLabel.topAnchor.constraint(equalTo: self.problemLabel.bottomAnchor, constant: 10).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.problemLabel.leftAnchor).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.problemLabel.rightAnchor, constant: 0).isActive = true
        self.descriptionLabel.sizeToFit()
        
        self.callHQButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
        self.callHQButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.callHQButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.callHQButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.submitButton.bottomAnchor.constraint(equalTo: self.callHQButton.topAnchor, constant: -10).isActive = true
        self.submitButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.submitButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.submitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.earningsReportingCollection.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 10).isActive = true
        self.earningsReportingCollection.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.earningsReportingCollection.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.earningsReportingCollection.bottomAnchor.constraint(equalTo: self.submitButton.topAnchor, constant: -10).isActive = true
    }
    
    @objc func handleCancelButton() {
        self.earningsAndReviews?.handleWarningIcon()
        self.groomzDetailsController?.handleWarningIcon()
    }
    
    @objc func handlePhoneCall() {
        
        UIDevice.vibrateLight()
        
        if let url = URL(string: "tel://\(Statics.SUPPORT_PHONE_NUMBER)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            self.handleCustomPopUpAlert(title: "Restriction", message: "This device is unable to make phone calls.", passedButtons: [Statics.GOT_IT])
        }
    }
    
    @objc func handleCustomPopUpAlert(title : String, message : String, passedButtons: [String]) {
        
        let alert = AlertController()
        alert.passedTitle = title
        alert.passedMmessage = message
        alert.passedButtonSelections = passedButtons
        alert.customAlertCallBackProtocol = self
        alert.passedIconName = .infoCircle
        alert.modalPresentationStyle = .overCurrentContext
        self.earningsAndReviews?.present(alert, animated: true, completion: nil)
        
    }
    
    func onSelectionPassBack(buttonTitleForSwitchStatement type: String) {
        
        switch type {
        case Statics.GOT_IT: print("Tapped Got it")
        default: print("Should not hit")
            
        }
    }
    
    @objc func handleSubmitButton() {
        self.earningsAndReviews?.handleSubmitButton()
        self.groomzDetailsController?.handleSubmitButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
