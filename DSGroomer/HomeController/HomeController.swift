//
//  HomeController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/25/21.
//

import Foundation
import UIKit
import Firebase
import Lottie
import AudioToolbox
import AVFoundation

class HomeController : UITabBarController {
    
    let databaseRef = Database.database().reference(),
        dashboardController = DashboardController(),
        historyController = HistoryController(),
        profileController = ProfileController(),
        storageRef = Storage.storage().reference()
    
    var statusBarHeight : CGFloat = 0.0,
        keyWindow : UIWindow = UIWindow(),
        viewHasBeenLaidOut : Bool = false,
        startingVerticalConstant: CGFloat  = 0.0,
        startingHorizontalConstant: CGFloat  = 0.0
    
    var successFailureView : UIView = {
        
        let lv = UIView()
        lv.translatesAutoresizingMaskIntoConstraints = true
        lv.backgroundColor = coreWhiteColor
        lv.isUserInteractionEnabled = true
        lv.layer.zPosition = 91
        
        return lv
        
    }()
    
    let failLabel : UILabel = {
        
        let fl = UILabel()
        fl.translatesAutoresizingMaskIntoConstraints = false
        fl.backgroundColor = .clear
        fl.font = UIFont(name: dsSubHeaderFont, size: 20)
        fl.textColor = coreWhiteColor
        fl.textAlignment = .left
        fl.numberOfLines = 1
        fl.adjustsFontSizeToFitWidth = true
        
        return fl
    }()
    
    let systemIcon : UIImageView = {
        
        let si = UIImageView()
        si.translatesAutoresizingMaskIntoConstraints = false
        si.backgroundColor = .clear
        let config = UIImage.SymbolConfiguration(pointSize: 17, weight: .ultraLight)
        let image = UIImage(named: "nudge_icon")?.withRenderingMode(.alwaysOriginal)
        si.image = image
        si.tintColor = coreWhiteColor
        si.contentMode = .scaleAspectFit
        
        return si
    }()
    
    let selectionDot : UIView = {
        
        let sd = UIView()
        sd.translatesAutoresizingMaskIntoConstraints = true
        sd.backgroundColor = .systemRed
        sd.isUserInteractionEnabled = false
        
        return sd
    }()
    
    lazy var timerCountDownBubble : UIView = {
        
        let tcdb = UIView()
        tcdb.translatesAutoresizingMaskIntoConstraints = false
        tcdb.backgroundColor = coreRedColor
        tcdb.isUserInteractionEnabled = true
        tcdb.layer.masksToBounds = true
        tcdb.isHidden = true
        tcdb.isUserInteractionEnabled = true
        
        return tcdb
    }()
    
    var countDownTimerLabel : UILabel = {
        
        let cdtl = UILabel()
        cdtl.translatesAutoresizingMaskIntoConstraints = false
        cdtl.backgroundColor = .clear
        cdtl.text = "..."
        cdtl.textColor = coreWhiteColor
        cdtl.textAlignment = .center
        cdtl.adjustsFontSizeToFitWidth = true
        cdtl.font = UIFont(name: dsSubHeaderFont, size: 22)
        cdtl.isHidden = false
        cdtl.isUserInteractionEnabled = false
        return cdtl
    }()
    
    let tappableView : UIView = {
        
        let tv = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreWhiteColor
        self.tabBar.backgroundColor = coreWhiteColor
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        self.tabBar.itemPositioning = .fill
        
        NetworkMonitor.shared.startMonitoring()
        
        let ratingLibrary = RatingLibraryExtension()
        ratingLibrary.checkForRating()
        
        self.addTabsAndCustomCenterCircle {
            self.addViews()
            self.switchTabs(tabIndex: 0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarItem.image?.withAlignmentRectInsets(UIEdgeInsets(top: 1440, left: 45, bottom: 0, right: 0))//Give your left alignment number
        
        //one more way
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 140, left: 45, bottom: 0, right: 0)
        
        self.updateUserProfileStructure { success in
            if success {
                print("Updated the users data source")
            } else {
                print("Failed to update the users data source")
            }
        }
    }
    
    @objc func handleDoubleTap() {
        
        UIDevice.vibrateLight()
        
        if self.timerCountDownBubble.isHidden {
            self.timerCountDownBubble.isHidden = false
        } else {
            self.timerCountDownBubble.isHidden = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let insetsTop = self.view.window?.safeAreaInsets.top else {return}
        guard let insetsBottom = self.view.window?.safeAreaInsets.bottom else {return}
        
        globalStatusBarHeight = insetsTop
        globalFooterHeight = insetsBottom
        
        if insetsTop > CGFloat(30.0) {
            self.statusBarHeight = insetsTop
        } else {
            self.statusBarHeight = 30
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if self.viewHasBeenLaidOut == true {return}
        self.viewHasBeenLaidOut = true
        
        guard let insets = self.view.window?.safeAreaInsets.top else {return}
        
        if insets > CGFloat(30.0) {
            self.statusBarHeight = insets
        } else {
            self.statusBarHeight = 30
        }
        
        self.successFailureView.frame = CGRect(x: 0, y: -self.statusBarHeight * 2, width: UIScreen.main.bounds.width, height: statusBarHeight * 2)
        self.successFailureView.isHidden = false
        
        self.systemIcon.bottomAnchor.constraint(equalTo: self.successFailureView.bottomAnchor, constant: -5).isActive = true
        self.systemIcon.leftAnchor.constraint(equalTo: self.successFailureView.leftAnchor, constant: 20).isActive = true
        self.systemIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.systemIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.failLabel.centerYAnchor.constraint(equalTo: self.systemIcon.centerYAnchor, constant: 0).isActive = true
        self.failLabel.leftAnchor.constraint(equalTo: self.systemIcon.rightAnchor, constant: 10).isActive = true
        self.failLabel.rightAnchor.constraint(equalTo: self.successFailureView.rightAnchor, constant: -45).isActive = true
        self.failLabel.sizeToFit()
        
        self.timerCountDownBubble.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.statusBarHeight - 10).isActive = true
        self.timerCountDownBubble.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.timerCountDownBubble.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.timerCountDownBubble.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.timerCountDownBubble.layer.cornerRadius = 15
        
        self.countDownTimerLabel.topAnchor.constraint(equalTo: self.timerCountDownBubble.topAnchor, constant: 3).isActive = true
        self.countDownTimerLabel.leftAnchor.constraint(equalTo: self.timerCountDownBubble.leftAnchor, constant: 5).isActive = true
        self.countDownTimerLabel.rightAnchor.constraint(equalTo: self.timerCountDownBubble.rightAnchor, constant: -5).isActive = true
        self.countDownTimerLabel.bottomAnchor.constraint(equalTo: self.timerCountDownBubble.bottomAnchor, constant: -3).isActive = true
        
        self.tappableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tappableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tappableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        if statusBarHeight == 30 {
            self.tappableView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        } else {
            self.tappableView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
    func addViews() {
        
        self.view.addSubview(self.successFailureView)
        self.view.addSubview(self.tappableView)
        self.view.addSubview(self.timerCountDownBubble)
        self.timerCountDownBubble.addSubview(self.countDownTimerLabel)
        
        self.successFailureView.addSubview(systemIcon)
        self.successFailureView.addSubview(failLabel)
        self.successFailureView.isHidden = true
        
    }
    
    func switchTabs(tabIndex : Int) {
        self.selectedIndex = tabIndex
    }
    
    func animateSuccessFailureViewView(directionUp up : Bool, isFailed : Bool, passedText : String) {
        
        if isFailed {
            self.successFailureView.backgroundColor = coreWhiteColor
            self.failLabel.text = passedText
            self.failLabel.textColor = coreBlackColor
        } else {
            self.successFailureView.backgroundColor = coreWhiteColor
            self.failLabel.text = passedText
            self.failLabel.textColor = coreBlackColor
        }
        
        if up == true {
            
            UIView.animate(withDuration: 0.7) {
                
                self.successFailureView.frame = CGRect(x: 0, y: -self.statusBarHeight * 2, width: UIScreen.main.bounds.width, height: self.statusBarHeight * 2)
            }
            
        } else if up == false {
            
            UIView.animate(withDuration: 0.7) {
                
                self.successFailureView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.statusBarHeight * 2)
                self.perform(#selector(self.handleSuccessFailureView), with: nil, afterDelay: 1.5)
                
            }
        }
    }
    
    @objc func handleSuccessFailureView() {
        
        UIView.animate(withDuration: 0.4) {
            
            self.successFailureView.frame = CGRect(x: 0, y: -self.statusBarHeight * 2, width: UIScreen.main.bounds.width, height: self.statusBarHeight * 2)
            
        }
    }
    
    func addTabsAndCustomCenterCircle(completion : @escaping () -> ()) {
        
        //HOME ICONS
        let home = UIImage(named:"tab_home_deselected")?.withRenderingMode(.alwaysOriginal).withTintColor(tabBarIconGrey) ?? UIImage()
        let homeFill = UIImage(named:"tab_home_deselected")?.withRenderingMode(.alwaysOriginal).withTintColor(coreOrangeColor)
        
        //CALENDAR ICONS
        let calendar = UIImage(named:"tab_calendar_deselected")?.withRenderingMode(.alwaysOriginal).withTintColor(tabBarIconGrey)
        let calendarFill = UIImage(named:"tab_calendar_deselected")?.withRenderingMode(.alwaysOriginal).withTintColor(coreOrangeColor)
        
        //PEOPLE ICONS
        let people = UIImage(named:"tab_person_deselected")?.withRenderingMode(.alwaysOriginal).withTintColor(tabBarIconGrey)
        let peopleFill = UIImage(named:"tab_person_deselected")?.withRenderingMode(.alwaysOriginal).withTintColor(coreOrangeColor)
        
        let mainTab = UINavigationController(rootViewController: self.dashboardController)
        self.dashboardController.homeController = self
        mainTab.navigationBar.isHidden = true
        mainTab.tabBarItem = UITabBarItem(title: nil, image: home, selectedImage: homeFill)
        
        let secondarytab = UINavigationController(rootViewController: self.historyController)
        secondarytab.navigationBar.isHidden = true
        self.historyController.homeController = self
        secondarytab.tabBarItem = UITabBarItem(title: nil, image: calendar, selectedImage: calendarFill)
        
        let tertiaryTab = UINavigationController(rootViewController: self.profileController)
        tertiaryTab.navigationBar.isHidden = true
        self.profileController.homeController = self
        tertiaryTab.tabBarItem = UITabBarItem(title: nil, image: people, selectedImage: peopleFill)
        
        viewControllers = [mainTab, secondarytab, tertiaryTab]
        
        completion()
        
    }
    
    
    func updateUserProfileStructure(completion : @escaping (_ isComplete : Bool)->()) {
        
        let user_uid = Auth.auth().currentUser?.uid ?? "nil"
        
        let ref = self.databaseRef.child("all_users").child(user_uid)
        
        ref.observeSingleEvent(of: .value) { (snap : DataSnapshot) in
            
            if let JSON = snap.value as? [String : AnyObject] {
                
                let profile_image = JSON["profile_image_url"] as? String ?? "nil"
                let users_name = JSON["users_name"] as? String ?? "nil"
                let groomers_name = JSON["groomers_full_name"] as? String ?? "nil"
                let email = JSON["users_email"] as? String ?? "nil"
                let push_token = JSON["push_token"] as? String ?? "nil"
                let firebase_uid = JSON["firebase_uid"] as? String ?? "nil"
                let is_groomer = JSON["is_groomer"] as? Bool ?? false
                
                userProfileStruct.userProfileImageURL = profile_image
                userProfileStruct.usersName = users_name
                userProfileStruct.usersEmail = email
                userProfileStruct.usersPushToken = push_token
                userProfileStruct.usersFirebaseUID = firebase_uid
                userProfileStruct.is_groomer = is_groomer
                userProfileStruct.groomers_full_name = groomers_name
                
                completion(true)
                
            } else {
                completion(false)
            }
        }
    }
    
    func uploadProfileImage(imageToUpload : UIImage, completion : @escaping (_ isComplete : Bool) -> ()) {
        
        guard let userUid = Auth.auth().currentUser?.uid else {return}
        guard let imageDataToUpload = imageToUpload.jpegData(compressionQuality: 0.15) else {return}
        
        let randomString = NSUUID().uuidString
        let imageRef = self.storageRef.child("imageSubmissions").child(userUid).child(randomString)
        
        imageRef.putData(imageDataToUpload, metadata: nil) { (metaDataPass, error) in
            
            if error != nil {
                completion(false);
                return
            }
            
            imageRef.downloadURL(completion: { (urlGRab, error) in
                
                if error != nil {
                    completion(false);
                    return
                }
                
                if let uploadUrl = urlGRab?.absoluteString {
                    
                    let values : [String : Any] = ["profile_image_url" : uploadUrl]
                    let refUploadPath = self.databaseRef.child("all_users").child(userUid)
                    
                    userProfileStruct.userProfileImageURL = uploadUrl
                    
                    refUploadPath.updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            completion(false);
                            return
                        } else {
                            completion(true);
                        }
                    })
                }
            })
        }
    }
}
