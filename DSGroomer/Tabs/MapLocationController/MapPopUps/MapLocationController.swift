//
//  MapLocationController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 10/9/21.
//

import Foundation
import UIKit

class MapLocationController : UIViewController {
    
    var isWarningPresented : Bool = false
    var isActivePopupPresented : Bool = false

    let headerContainer : UIView = {
        
        let hc = UIView()
        hc.translatesAutoresizingMaskIntoConstraints = false
        hc.backgroundColor = coreBackgroundWhite
        hc.isUserInteractionEnabled = true
        
       return hc
    }()
    
    let bottomContainer : UIView = {
        
        let hc = UIView()
        hc.translatesAutoresizingMaskIntoConstraints = false
        hc.backgroundColor = coreBackgroundWhite
        hc.isUserInteractionEnabled = true
        
       return hc
    }()
    
    lazy var notificationIcon : UIButton = {
        
        let dcl = UIButton(type: .system)
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = true
        dcl.clipsToBounds = false
        dcl.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        dcl.setTitle(String.fontAwesomeIcon(name: .bell), for: .normal)
        dcl.tintColor = bellgrey
        dcl.addTarget(self, action: #selector(self.handleNotificationsController), for: .touchUpInside)
        
        return dcl
    }()
    
    let notificationBubble : UILabel = {
        
        let nb = UILabel()
        nb.backgroundColor = UIColor.red
        nb.translatesAutoresizingMaskIntoConstraints = false
        nb.isUserInteractionEnabled = false
        nb.layer.masksToBounds = true
        nb.font = UIFont(name: dsHeaderFont, size: 11)
        nb.textAlignment = .center
        nb.layer.borderColor = coreWhiteColor.cgColor
        nb.layer.borderWidth = 1.5
        nb.text = "4"
        nb.textColor = coreWhiteColor
        nb.isHidden = true
        
        return nb
    }()
    
    lazy var warningIcon : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .exclamationTriangle), for: .normal)
        cbf.setTitleColor(dsFlatBlack.withAlphaComponent(0.4), for: .normal)
        cbf.addTarget(self, action: #selector(self.handleWarningIcon), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    let navigateLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .center
        thl.text = "Navigate to location"
        thl.font = UIFont(name: rubikMedium, size: 18)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let minuteAndMileLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "4 min - 1.1 mi"
        thl.font = UIFont(name: dsHeaderFont, size: 22)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let addressLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Brickhouse Building 132 NE 30th Ave Toronto, ON 66777"
        thl.font = UIFont(name: rubikRegular, size: 18)
        thl.numberOfLines = -1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    lazy var mapView : MapNavigateLocationSubview = {
        
        let mv = MapNavigateLocationSubview(frame: .zero)
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.backgroundColor = .red
        mv.mapLocationController = self

       return mv
    }()
    
    lazy var sendButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = coreOrangeColor.withAlphaComponent(0.2)
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .paperPlane), for: .normal)
        cbf.setTitleColor(coreOrangeColor, for: .normal)
        cbf.layer.masksToBounds = true
        cbf.addTarget(self, action: #selector(self.handleWarningIcon), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    lazy var slideToConfirmComponent : SwipeToConfirmSubview = {
        
       let sc = SwipeToConfirmSubview()
       sc.mapLocationController = self
        return sc
    }()
    
    lazy var issueReportingPopup : IssueReportingPopup = {
        
        let rp = IssueReportingPopup(frame: .zero)
        rp.mapLocationController = self
        
        return rp
    }()
    
   lazy var activeDogPickup : ActiveDogPickupPopup = {
        
        let adpu = ActiveDogPickupPopup(frame: .zero)
        adpu.mapLocationController = self
            
       return adpu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        self.perform(#selector(self.handleActiveApt), with: nil, afterDelay: 1.0)
        
    }
    
    func addViews() {
        
        //MARK: - HEADER CONTAINER
        self.view.addSubview(self.headerContainer)
        self.headerContainer.addSubview(self.notificationIcon)
        self.headerContainer.addSubview(self.notificationBubble)
        self.headerContainer.addSubview(self.warningIcon)
        self.headerContainer.addSubview(self.navigateLabel)
        
        //MARK: - BOTTOM CONTAINER
        self.view.addSubview(self.bottomContainer)
        
        //MARK: - MAPVIEW CONTAINER
        self.bottomContainer.addSubview(self.mapView)
        self.bottomContainer.addSubview(self.minuteAndMileLabel)
        self.bottomContainer.addSubview(self.addressLabel)
        self.bottomContainer.addSubview(self.sendButton)
        
        //MARK: - SLIDE TO CONFIRM COMPONENT
        self.bottomContainer.addSubview(self.slideToConfirmComponent)
        
        //MARK: - REPORTINGPOP UP
        self.view.addSubview(self.issueReportingPopup)
        self.view.addSubview(self.activeDogPickup)

        self.headerContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.headerContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.headerContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.headerContainer.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        self.notificationIcon.centerYAnchor.constraint(equalTo: self.headerContainer.centerYAnchor, constant: 0).isActive = true
        self.notificationIcon.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        self.notificationIcon.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.notificationIcon.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.notificationBubble.topAnchor.constraint(equalTo: self.notificationIcon.topAnchor, constant: 7).isActive = true
        self.notificationBubble.rightAnchor.constraint(equalTo: self.notificationIcon.rightAnchor, constant: -7).isActive = true
        self.notificationBubble.heightAnchor.constraint(equalToConstant: 23).isActive = true
        self.notificationBubble.widthAnchor.constraint(equalToConstant: 23).isActive = true
        self.notificationBubble.layer.cornerRadius = 23/2
        
        self.warningIcon.centerYAnchor.constraint(equalTo: self.headerContainer.centerYAnchor, constant: 0).isActive = true
        self.warningIcon.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        self.warningIcon.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.warningIcon.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.navigateLabel.centerYAnchor.constraint(equalTo: self.notificationIcon.centerYAnchor, constant: 0).isActive = true
        self.navigateLabel.leftAnchor.constraint(equalTo: self.warningIcon.rightAnchor, constant: 10).isActive = true
        self.navigateLabel.rightAnchor.constraint(equalTo: self.notificationIcon.leftAnchor, constant: -10).isActive = true
        self.navigateLabel.sizeToFit()
        
        self.bottomContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.bottomContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.bottomContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.bottomContainer.heightAnchor.constraint(equalToConstant: 292).isActive = true
        
        self.mapView.topAnchor.constraint(equalTo: self.headerContainer.bottomAnchor, constant: 0).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.bottomContainer.topAnchor, constant: 0).isActive = true
        self.mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        self.minuteAndMileLabel.topAnchor.constraint(equalTo: self.bottomContainer.topAnchor, constant: 35).isActive = true
        self.minuteAndMileLabel.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 35).isActive = true
        self.minuteAndMileLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
        self.minuteAndMileLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.addressLabel.topAnchor.constraint(equalTo: self.minuteAndMileLabel.bottomAnchor, constant: 5).isActive = true
        self.addressLabel.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 35).isActive = true
        self.addressLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
        self.addressLabel.sizeToFit()
        
        self.sendButton.centerYAnchor.constraint(equalTo: self.minuteAndMileLabel.centerYAnchor, constant: 0).isActive = true
        self.sendButton.rightAnchor.constraint(equalTo: self.bottomContainer.rightAnchor, constant: -30).isActive = true
        self.sendButton.heightAnchor.constraint(equalToConstant: 41).isActive = true
        self.sendButton.widthAnchor.constraint(equalToConstant: 41).isActive = true
        self.sendButton.layer.cornerRadius = 41/2
        
        self.slideToConfirmComponent.bottomAnchor.constraint(equalTo: self.bottomContainer.bottomAnchor, constant: -44).isActive = true
        self.slideToConfirmComponent.leftAnchor.constraint(equalTo: self.bottomContainer.leftAnchor, constant: 30).isActive = true
        self.slideToConfirmComponent.rightAnchor.constraint(equalTo: self.bottomContainer.rightAnchor, constant: -30).isActive = true
        self.slideToConfirmComponent.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    @objc func handleSwipeToComplete() {
    }
    
    @objc func handleNotificationsController() {
    }
    
    @objc func handleWarningIcon() {
        
        if self.isWarningPresented {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                self.issueReportingPopup.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
                self.view.layoutIfNeeded()
                self.issueReportingPopup.layoutIfNeeded()
            } completion: { complete in 
                self.isWarningPresented = false
                self.issueReportingPopup.issueReportingCollectionView.clearData()
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                self.issueReportingPopup.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 1.5)), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
                self.view.layoutIfNeeded()
                self.issueReportingPopup.layoutIfNeeded()
            } completion: { complete in
                self.isWarningPresented = true
            }
        }
    }
    
    @objc func handleActiveApt() {
        
        if self.isActivePopupPresented {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                self.activeDogPickup.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
                self.view.layoutIfNeeded()
                self.activeDogPickup.layoutIfNeeded()
            } completion: { complete in
                self.isActivePopupPresented = false
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                self.activeDogPickup.frame = CGRect(x: 0, y: (UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 1.5)), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
                self.view.layoutIfNeeded()
                self.activeDogPickup.layoutIfNeeded()
            } completion: { complete in
                self.isActivePopupPresented = true
            }
        }
    }
    
    @objc func presentChatController() {
        
        let supportChatController = SupportChatController()
        supportChatController.navigationController?.navigationBar.isHidden = true
        supportChatController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(supportChatController, animated: true)
        
    }
}
