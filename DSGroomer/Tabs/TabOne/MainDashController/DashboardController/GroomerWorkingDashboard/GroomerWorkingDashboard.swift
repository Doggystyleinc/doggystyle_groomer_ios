//
//  GroomerWorkingDashboard.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/24/21.
//

import Foundation
import UIKit

class GroomerWorkingDashboard : UIView {
    
    var dashboardController : DashboardController?,
        truckContainerHeightConstraint : NSLayoutConstraint?,
        selectorTopConstraint : NSLayoutConstraint?
    
    lazy var truckContainer : UIView = {
        
        let tc = UIView()
        tc.translatesAutoresizingMaskIntoConstraints = false
        tc.backgroundColor = coreOrangeColor
        tc.layer.masksToBounds = true
        tc.layer.cornerRadius = 20
        tc.isUserInteractionEnabled = true
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleTruckContainerCancel))
        swipeUp.direction = .up
        tc.addGestureRecognizer(swipeUp)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleTruckContainerCancel))
        swipeLeft.direction = .left
        tc.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleTruckContainerCancel))
        swipeRight.direction = .right
        tc.addGestureRecognizer(swipeRight)
        
       return tc
    }()
   
    let truckAssignmentLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Assigned to truck: <#ref>"
        thl.font = UIFont(name: dsHeaderFont, size: 18)
        thl.numberOfLines = 2
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreWhiteColor
        return thl
        
    }()
    
    let vanImage : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFit
        dcl.isUserInteractionEnabled = false
        let image = UIImage(named: "van_image_one")?.withRenderingMode(.alwaysOriginal)
        dcl.image = image
        
        return dcl
    }()
    
    lazy var clockInButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Clock in", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: dsHeaderFont, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.titleLabel?.textColor = coreBlackColor
        cbf.backgroundColor = coreOrangeColor
        cbf.layer.cornerRadius = 15
        cbf.layer.masksToBounds = true
        cbf.tintColor = coreWhiteColor
        cbf.addTarget(self, action: #selector(self.handleClockInButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var truckContainerCancelButton : UIButton = {
        
        let cbf = UIButton()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 15, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .times), for: .normal)
        cbf.setTitleColor(coreWhiteColor, for: .normal)
        cbf.addTarget(self, action: #selector(self.handleTruckContainerCancel), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    lazy var selectorSwitch : GroomerSelectorSwitch = {
        
        let ss = GroomerSelectorSwitch()
        ss.groomerWorkingDashboard = self
       
        return ss
    }()
    
    lazy var groomerUpcomingAppointmentCollection : GroomerUpcomingAppointmentCollection = {
        
        let layout = UICollectionViewFlowLayout()
        let ss = GroomerUpcomingAppointmentCollection(frame: .zero, collectionViewLayout: layout)
        ss.groomerWorkingDashboard = self
        return ss
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreBackgroundWhite
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addViews()
        
    }
    
    func addViews() {
        
        let width = UIScreen.main.bounds.width - 60
        
        self.addSubview(self.truckContainer)
        self.truckContainer.addSubview(self.truckAssignmentLabel)
        self.truckContainer.addSubview(self.vanImage)
        self.truckContainer.addSubview(self.truckContainerCancelButton)

        self.addSubview(self.clockInButton)
        self.addSubview(self.selectorSwitch)
        self.addSubview(self.groomerUpcomingAppointmentCollection)

        self.truckContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.truckContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.truckContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.truckContainerHeightConstraint = self.truckContainer.heightAnchor.constraint(equalToConstant: 117)
        self.truckContainerHeightConstraint?.isActive = true
        
        self.truckAssignmentLabel.leftAnchor.constraint(equalTo: self.truckContainer.leftAnchor, constant: 33).isActive = true
        self.truckAssignmentLabel.topAnchor.constraint(equalTo: self.truckContainer.topAnchor, constant: 31).isActive = true
        self.truckAssignmentLabel.bottomAnchor.constraint(equalTo: self.truckContainer.bottomAnchor, constant: -31).isActive = true
        self.truckAssignmentLabel.widthAnchor.constraint(equalToConstant: width / 2.0).isActive = true
        
        self.vanImage.rightAnchor.constraint(equalTo: self.truckContainer.rightAnchor, constant: -28).isActive = true
        self.vanImage.topAnchor.constraint(equalTo: self.truckContainer.topAnchor, constant: 17).isActive = true
        self.vanImage.bottomAnchor.constraint(equalTo: self.truckContainer.bottomAnchor, constant: -14).isActive = true
        self.vanImage.leftAnchor.constraint(equalTo: self.truckAssignmentLabel.rightAnchor, constant: -15).isActive = true
        
        self.truckContainerCancelButton.topAnchor.constraint(equalTo: self.truckContainer.topAnchor, constant: 5).isActive = true
        self.truckContainerCancelButton.rightAnchor.constraint(equalTo: self.truckContainer.rightAnchor, constant: -5).isActive = true
        self.truckContainerCancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.truckContainerCancelButton.widthAnchor.constraint(equalToConstant: 44).isActive = true

        self.clockInButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.clockInButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.clockInButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(globalFooterHeight + 65)).isActive = true
        self.clockInButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.selectorTopConstraint = self.selectorSwitch.topAnchor.constraint(equalTo: self.truckContainer.bottomAnchor, constant: 20)
        self.selectorTopConstraint?.isActive = true
        self.selectorSwitch.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.selectorSwitch.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.selectorSwitch.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        self.groomerUpcomingAppointmentCollection.topAnchor.constraint(equalTo: self.selectorSwitch.bottomAnchor, constant: 20).isActive = true
        self.groomerUpcomingAppointmentCollection.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.groomerUpcomingAppointmentCollection.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.groomerUpcomingAppointmentCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

    }
  
    @objc func handleTruckContainerCancel() {
        
        UIDevice.vibrateLight()
        
        UIView.animate(withDuration: 0.25) {
            
            self.truckContainerHeightConstraint?.constant = 0
            self.selectorTopConstraint?.constant = 0
            self.truckContainer.alpha = 0
            self.layoutIfNeeded()
            self.dashboardController?.view.layoutIfNeeded()
            
        } completion: { isComplete in
            self.truckContainer.isHidden = true
            self.dashboardController?.showTruckContainerButton.isHidden = false
        }
    }
    
    @objc func handleTruckContainerShow() {
       
        UIDevice.vibrateLight()
        self.truckContainer.isHidden = false
        
       UIView.animate(withDuration: 0.25) {
           
           self.truckContainerHeightConstraint?.constant = 117
           self.selectorTopConstraint?.constant = 20
           self.truckContainer.alpha = 1
           self.layoutIfNeeded()
           self.dashboardController?.view.layoutIfNeeded()
           
       } completion: { isComplete in
           self.truckContainer.isHidden = false
        self.dashboardController?.showTruckContainerButton.isHidden = true

       }
   }
    
    
    @objc func handleClockInButton() {
        print("handle clock in")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
