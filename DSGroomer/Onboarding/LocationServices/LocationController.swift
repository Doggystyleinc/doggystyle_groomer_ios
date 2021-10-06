//
//  LocationController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/10/21.
//

import Foundation
import UIKit

class LocationController : UIViewController {
    
    var phoneNumber : String?
    var countryCode : String?
    var groomersFirstName : String?
    var groomersLastName : String?
    var groomersEmail : String?
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.tintColor = coreOrangeColor
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 22, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        cbf.isHidden = true
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
        hl.text = "Enable location"
        hl.font = UIFont(name: dsHeaderFont, size: 24)
        hl.numberOfLines = 1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsFlatBlack
        
        return hl
    }()
    
    let subHeaderLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.text = "We use your precise location to schedule your groomz, pickups, and drop offs. Location data is collected only when you’re logged in for a session or otherwise active within the app, even when the app is not visible on your screen."
        hl.font = UIFont(name: rubikRegular, size: 16)
        hl.numberOfLines = -1
        hl.adjustsFontSizeToFitWidth = true
        hl.textAlignment = .left
        hl.textColor = dsLightBlack
        
        return hl
    }()
    
    lazy var enableLocationButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Enable location", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleEnableLocationServices), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var notNowButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Not now", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreOrangeColor
        cbf.addTarget(self, action: #selector(self.handleNotNowButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var mapView : MapsSubview = {
        
        let mv = MapsSubview(frame: .zero)
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.backgroundColor = coreOrangeColor
        mv.isUserInteractionEnabled = true
        mv.layer.masksToBounds = true
        mv.layer.cornerRadius = 12
        mv.locationController = self
        
       return mv
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
        
        self.view.addSubview(self.enableLocationButton)
        self.view.addSubview(self.notNowButton)
        self.view.addSubview(self.mapView)

        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 63).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 11).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.dsCompanyLogoImage.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.dsCompanyLogoImage.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        self.headerLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 62).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerLabel.sizeToFit()
        
        self.subHeaderLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 14).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.subHeaderLabel.sizeToFit()
        
        self.notNowButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
        self.notNowButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.notNowButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.notNowButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.enableLocationButton.bottomAnchor.constraint(equalTo: self.notNowButton.topAnchor, constant: -20).isActive = true
        self.enableLocationButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.enableLocationButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.enableLocationButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.mapView.topAnchor.constraint(equalTo: self.subHeaderLabel.bottomAnchor, constant: 30).isActive = true
        self.mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 28).isActive = true
        self.mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -28).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.enableLocationButton.topAnchor, constant: -62).isActive = true

    }
    
    @objc func handleEnableLocationServices() {
        self.mapView.handleLocationServicesAuthorization()
    }
    
    @objc func handleNotNowButton() {
        self.handleNextButton()
    }
    
    @objc func handleNextScreen() {
        self.handleNextButton()
    }
    
    @objc func handleNextButton() {
        
        let registrationController = RegistrationController()
        
        registrationController.phoneNumber = self.phoneNumber
        registrationController.countryCode = self.countryCode
        registrationController.groomersFirstName = self.groomersFirstName
        registrationController.groomersLastName = self.groomersLastName
        registrationController.groomersEmail = self.groomersEmail
        
        registrationController.modalPresentationStyle = .fullScreen
        registrationController.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(registrationController, animated: true)
        
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

