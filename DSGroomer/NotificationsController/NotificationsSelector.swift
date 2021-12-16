//
//  NotificationsSelector.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/13/21.
//

import Foundation
import UIKit

class NotificationsSelector : UIView {
    
    var yourNotificationController : YourNotificationController?,
        leftConstraint : NSLayoutConstraint?
    
    lazy var newLabel : UIButton = {
        
        let ul = UIButton(type : .system)
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.setTitle("New", for: .normal)
        ul.tintColor = coreOrangeColor
        ul.titleLabel?.font = UIFont(name: rubikBold, size: 13)
        ul.backgroundColor = .clear
        ul.layer.masksToBounds = true
        ul.layer.cornerRadius = 26 / 2
        ul.tag = 1
        ul.addTarget(self, action: #selector(self.selectorChange(sender:)), for: .touchUpInside)
        
        return ul
        
    }()
    
    lazy var readLabel : UIButton = {
        
        let ul = UIButton(type : .system)
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.setTitle("Read", for: .normal)
        ul.tintColor = coreBlackColor
        ul.titleLabel?.font = UIFont(name: rubikBold, size: 13)
        ul.backgroundColor = .clear
        ul.layer.masksToBounds = true
        ul.layer.cornerRadius = 26 / 2
        ul.tag = 2
        ul.addTarget(self, action: #selector(self.selectorChange(sender:)), for: .touchUpInside)
        
        return ul
        
    }()
    
    let orangeView : UIView = {
        
        let ov = UIView()
        ov.translatesAutoresizingMaskIntoConstraints = false
        ov.backgroundColor = coreOrangeColor.withAlphaComponent(0.1)
        ov.layer.masksToBounds = true
        ov.layer.cornerRadius = 26 / 2
        
        return ov
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreWhiteColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = coreWhiteColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 32/2
        
        self.addViews()
    }
    
    func addViews() {
        
        self.addSubview(self.newLabel)
        self.addSubview(self.readLabel)
        self.addSubview(self.orangeView)
        
        let width = UIScreen.main.bounds.width - 60
        
        self.newLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3).isActive = true
        self.newLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        self.newLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        self.newLabel.widthAnchor.constraint(equalToConstant: width / 2).isActive = true
        
        self.readLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3).isActive = true
        self.readLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        self.readLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        self.readLabel.widthAnchor.constraint(equalToConstant: width / 2).isActive = true
        
        leftConstraint = self.orangeView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3)
        self.leftConstraint?.isActive = true
        self.orangeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        self.orangeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        self.orangeView.widthAnchor.constraint(equalToConstant: width / 2).isActive = true
        
    }
    
    @objc func selectorChange(sender : UIButton) {
        
        UIDevice.vibrateLight()
        
        let width = UIScreen.main.bounds.width - 60
        
        switch sender.tag {
        
        case 1:
            
            UIView.animate(withDuration: 0.2) {
                self.leftConstraint?.constant = 3
                self.layoutIfNeeded()
            }
            
            self.newLabel.tintColor = coreOrangeColor
            self.readLabel.tintColor = coreBlackColor
            
            self.yourNotificationController?.handleSelector(isNewMessages : true)
            
        case 2:
            
            UIView.animate(withDuration: 0.2) {
                self.leftConstraint?.constant = ((width / 2) - 3)
                self.layoutIfNeeded()
            }
            
            self.newLabel.tintColor = coreBlackColor
            self.readLabel.tintColor = coreOrangeColor
            
            self.yourNotificationController?.handleSelector(isNewMessages : false)

            
        default: print("Never called")
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
