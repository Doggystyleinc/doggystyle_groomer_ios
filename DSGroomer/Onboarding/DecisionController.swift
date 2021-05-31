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
        
        self.view.backgroundColor = coreWhiteColor
        userProfileStruct = UserProfileStruct()

        self.addViews()
        self.authenticationCheck()
        
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
                    print("User currently has Auth")
                    self.perform(#selector(self.handleHomeController), with: nil, afterDelay: 1.0)
                } else {
                    print("User does NOT currently have Auth")
                    self.perform(#selector(self.handleWelcomeController), with: nil, afterDelay: 1.0)
                }
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
    @objc func handleHomeController() {
     
        let homeController = HomeController()
        let nav = UINavigationController(rootViewController: homeController)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(nav, animated: false, completion: nil)
        
    }
    
}
