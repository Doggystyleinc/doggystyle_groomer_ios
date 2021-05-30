//
//  DecisionController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/25/21.
//

import Foundation
import Firebase
import UIKit

class DecisionController : UIViewController {
    
    let databaseRef = Database.database().reference()
    
    let mainLoadingScreen = MainLoadingScreen()
    
    let backDrop : UIImageView = {
        
        let bd = UIImageView()
        bd.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "splash_screen")?.withRenderingMode(.alwaysOriginal)
        bd.image = image
        bd.contentMode = .scaleAspectFill
        bd.backgroundColor = coreWhiteColor
        
        return bd
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authenticationCheck()
        self.view.backgroundColor = coreWhiteColor
        self.addViews()
        
        userProfileStruct = UserProfileStruct()
        FontLister.enumerateFonts()
    }
    
    func addViews() {
        
        self.view.addSubview(self.backDrop)
        
        self.backDrop.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.backDrop.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.backDrop.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.backDrop.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
    }
    
    func authenticationCheck() {
        
        //USER IS NOT AUTHENTICATED
        if Auth.auth().currentUser?.uid == nil {
            
            self.perform(#selector(self.handleWelcomeController), with: nil, afterDelay: 1.0)
            
            //USER IS AUTHENTICATED
        } else if Auth.auth().currentUser?.uid != nil {
            
            AuthCheckUsers.authCheck { (hasAuth) in
                
                if hasAuth {
                    self.perform(#selector(self.handleMainController), with: nil, afterDelay: 1.0)
                } else {
                    self.perform(#selector(self.handleWelcomeController), with: nil, afterDelay: 1.0)
                }
            }
        }
    }
    
    func grabLoginDataForQuickblox(completion : @escaping (_ countryCode : String, _ phoneNumber : String)->()) {
        
        guard let user_uid = Auth.auth().currentUser?.uid else {return}
        let ref = self.databaseRef.child("all_users").child(user_uid)
        ref.observeSingleEvent(of: .value) { (snap : DataSnapshot) in
            
            if let JSON = snap.value as? [String : AnyObject] {
                
                let country_code = JSON["country_code"] as? String ?? "nil"
                let phone_number = JSON["phone_number"] as? String ?? "nil"
                let profile_image = JSON["profile_image"] as? String ?? "nil"
                let users_name = JSON["users_name"] as? String ?? "nil"
                let email = JSON["email"] as? String ?? "nil"
                let profile_hex_color = JSON["profile_hex_color"] as? String ?? "nil"
                let push_token = JSON["push_token"] as? String ?? "nil"
                let firebase_uid = JSON["firebase_uid"] as? String ?? "nil"
                let quickblox_user_id = JSON["quickblox_user_id"] as? UInt ?? 0
                let device_UDID = JSON["device_UDID"] as? String ?? "nil"
                
                userProfileStruct.usersCountryCode = country_code
                userProfileStruct.usersPhoneNumber = phone_number
                userProfileStruct.userProfileImageURL = profile_image
                userProfileStruct.usersName = users_name
                userProfileStruct.usersEmail = email
                userProfileStruct.usersProfileHexColor = profile_hex_color
                userProfileStruct.usersPushToken = push_token
                userProfileStruct.usersFirebaseUID = firebase_uid
                userProfileStruct.usersQuickBloxID = quickblox_user_id
                userProfileStruct.deviceUDID = device_UDID
                
                completion(country_code, phone_number)
                
            } else {
                completion("","")
            }
        }
    }
    
    //GO TO THE LOGIN SCREEN, USER IS NOT AUTHENTICATED - FADING THE LOGO SMOOOTHED THE TRANSITION
    @objc func handleWelcomeController() {
        
        let tutorialClass = TutorialClass()
        let nav = UINavigationController(rootViewController: tutorialClass)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }
    
    //GO TO THE LOGIN SCREEN, USER IS NOT AUTHENTICATED - FADING THE LOGO SMOOOTHED THE TRANSITION
    @objc func handleMainController() {
        
        let mainController = MainController()
        let nav = UINavigationController(rootViewController: mainController)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(nav, animated: false, completion: nil)
    }
    
}
