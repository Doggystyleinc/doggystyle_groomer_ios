//
//  NotificationManagement.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 12/13/21.
//


import Foundation
import UIKit
import Firebase

class NotificationManagement : UIViewController {
    
    let databaseRef = Database.database().reference()
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.tintColor = coreOrangeColor
        cbf.contentMode = .scaleAspectFill
        cbf.titleLabel?.font = UIFont.fontAwesome(ofSize: 24, style: .solid)
        cbf.setTitle(String.fontAwesomeIcon(name: .chevronLeft), for: .normal)
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: UIControl.Event.touchUpInside)
        return cbf
        
    }()
    
    let earnLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Notification Settings"
        thl.font = UIFont(name: dsHeaderFont, size: 24)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = true
        thl.textColor = dsFlatBlack
        return thl
        
    }()
    
    let headerViewCell : UIView = {
        
        let hvc = UIView()
        hvc.translatesAutoresizingMaskIntoConstraints = false
        hvc.backgroundColor = coreWhiteColor
        hvc.isUserInteractionEnabled = true
        hvc.clipsToBounds = false
        hvc.layer.masksToBounds = false
        hvc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        hvc.layer.shadowOpacity = 0.05
        hvc.layer.shadowOffset = CGSize(width: 2, height: 3)
        hvc.layer.shadowRadius = 9
        hvc.layer.shouldRasterize = false
        hvc.layer.cornerRadius = 15

        return hvc
    }()
    
    let bodyViewCell : UIView = {
        
        let hvc = UIView()
        hvc.translatesAutoresizingMaskIntoConstraints = false
        hvc.backgroundColor = coreWhiteColor
        hvc.isUserInteractionEnabled = true
        hvc.clipsToBounds = false
        hvc.layer.masksToBounds = false
        hvc.layer.shadowColor = coreBlackColor.withAlphaComponent(0.8).cgColor
        hvc.layer.shadowOpacity = 0.05
        hvc.layer.shadowOffset = CGSize(width: 2, height: 3)
        hvc.layer.shadowRadius = 9
        hvc.layer.shouldRasterize = false
        hvc.layer.cornerRadius = 15
        return hvc
    }()
    
    let allowNotificationsLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Allow push notifications"
        thl.font = UIFont(name: rubikRegular, size: 16)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreBlackColor
        return thl
        
    }()
    
    lazy var allowNotificationsSwitch : UISwitch = {
        
        let bs = UISwitch()
        bs.translatesAutoresizingMaskIntoConstraints = false
        bs.tintColor = UIColor .lightGray
        bs.thumbTintColor = UIColor .white
        bs.setOn(true, animated: false)
        bs.isUserInteractionEnabled = true
        bs.addTarget(self, action: #selector(self.handleToggle), for: .touchUpInside)
        return bs
        
    }()
    
    let alertMeLabel : UILabel = {
        
        let thl = UILabel()
        thl.translatesAutoresizingMaskIntoConstraints = false
        thl.textAlignment = .left
        thl.text = "Alert me:"
        thl.font = UIFont(name: rubikBold, size: 18)
        thl.numberOfLines = 1
        thl.adjustsFontSizeToFitWidth = false
        thl.textColor = coreOrangeColor
        return thl
        
    }()
    
    lazy var notificationAlertsCollectionView : NotificationAlertsCollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let nalv = NotificationAlertsCollectionView(frame: .zero, collectionViewLayout: layout)
        nalv.translatesAutoresizingMaskIntoConstraints = false
        nalv.notificationManagement = self

       return nalv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreBackgroundWhite
        self.addViews()
        self.loadToggles()
        self.allowNotificationsSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.checkForNotifications()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.earnLabel)
        self.view.addSubview(self.headerViewCell)
        self.view.addSubview(self.bodyViewCell)
        
        self.headerViewCell.addSubview(self.allowNotificationsSwitch)
        self.headerViewCell.addSubview(self.allowNotificationsLabel)
        
        self.bodyViewCell.addSubview(self.alertMeLabel)
        self.bodyViewCell.addSubview(self.notificationAlertsCollectionView)

        self.backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        
        self.earnLabel.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 18).isActive = true
        self.earnLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.earnLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.earnLabel.sizeToFit()
        
        self.headerViewCell.topAnchor.constraint(equalTo: self.earnLabel.bottomAnchor, constant: 28).isActive = true
        self.headerViewCell.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.headerViewCell.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.headerViewCell.heightAnchor.constraint(equalToConstant: 68).isActive = true
        
        self.bodyViewCell.topAnchor.constraint(equalTo: self.headerViewCell.bottomAnchor, constant: 20).isActive = true
        self.bodyViewCell.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.bodyViewCell.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.bodyViewCell.heightAnchor.constraint(equalToConstant: 330).isActive = true
        
        self.allowNotificationsSwitch.centerYAnchor.constraint(equalTo: self.headerViewCell.centerYAnchor, constant: 0).isActive = true
        self.allowNotificationsSwitch.rightAnchor.constraint(equalTo: self.headerViewCell.rightAnchor, constant: -20).isActive = true
        
        self.allowNotificationsLabel.centerYAnchor.constraint(equalTo: self.headerViewCell.centerYAnchor, constant: 0).isActive = true
        self.allowNotificationsLabel.leftAnchor.constraint(equalTo: self.headerViewCell.leftAnchor, constant: 20).isActive = true
        self.allowNotificationsLabel.rightAnchor.constraint(equalTo: self.allowNotificationsSwitch.leftAnchor, constant: -20).isActive = true
        self.allowNotificationsLabel.sizeToFit()
        
        self.alertMeLabel.topAnchor.constraint(equalTo: self.bodyViewCell.topAnchor, constant: 23).isActive = true
        self.alertMeLabel.leftAnchor.constraint(equalTo: self.bodyViewCell.leftAnchor, constant: 20).isActive = true
        self.alertMeLabel.sizeToFit()
        
        self.notificationAlertsCollectionView.topAnchor.constraint(equalTo: self.alertMeLabel.bottomAnchor, constant: 20).isActive = true
        self.notificationAlertsCollectionView.leftAnchor.constraint(equalTo: self.bodyViewCell.leftAnchor, constant: 0).isActive = true
        self.notificationAlertsCollectionView.rightAnchor.constraint(equalTo: self.bodyViewCell.rightAnchor, constant: 0).isActive = true
        self.notificationAlertsCollectionView.bottomAnchor.constraint(equalTo: self.bodyViewCell.bottomAnchor, constant: -20).isActive = true

    }
    
    func loadToggles() {

        let notificationData = groomerUserStruct.user_notification_settings ?? ["nil" : "nil"]
        
        let appointment_reminders = notificationData["available_shifts"] as? Bool ?? false
        let available_appointments = notificationData["available_appointments"] as? Bool ?? false
        let direct_messages = notificationData["direct_messages"] as? Bool ?? false
        let grooming_updates = notificationData["grooming_updates"] as? Bool ?? false
        let doggystyle_updates = notificationData["doggystyle_updates"] as? Bool ?? false
        
        let toggledArray : [Bool] = [available_appointments, grooming_updates, direct_messages, appointment_reminders, doggystyle_updates]
        self.notificationAlertsCollectionView.toggledArray = toggledArray
        
        DispatchQueue.main.async {
            self.notificationAlertsCollectionView.reloadData()
        }
    }
    
    @objc func checkForNotifications() {
        
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { (settings) in

            DispatchQueue.main.async {
            
            if (settings.authorizationStatus == .authorized) {
                self.allowNotificationsSwitch.setOn(true, animated: true)
            } else {
                self.allowNotificationsSwitch.setOn(false, animated: true)
            }
                
            }
        }
    }
    
    @objc func handleToggle(sender : UISwitch) {
        
        if sender == self.allowNotificationsSwitch {
            
            if sender.isOn {
                self.shouldEnableNotifications(shouldEnable: true)
            } else {
                self.shouldEnableNotifications(shouldEnable: false)
            }
        }
    }
    
    func shouldEnableNotifications(shouldEnable : Bool) {
        
        if shouldEnable {
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
                        
        } else {
            
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }

    func updateNotifications(selectedLabel : String, isOn : Bool) {
        
        guard let user_uid = Auth.auth().currentUser?.uid else {return}
        let ref = self.databaseRef.child("all_users").child(user_uid).child("user_notification_settings")
        
        let values : [String : Any] = [selectedLabel : isOn]
        ref.updateChildValues(values)
        
    }
    
    @objc func handleBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
