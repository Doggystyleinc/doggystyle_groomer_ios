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
    
    let databaseRef = Database.database().reference(),
        mainLoadingScreen = MainLoadingScreen()
    
    let backDrop : UIImageView = {
        
        let bd = UIImageView()
        bd.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "splash_screen")?.withRenderingMode(.alwaysOriginal)
        bd.image = image
        bd.contentMode = .scaleAspectFit
        bd.backgroundColor = coreWhiteColor
        
        return bd
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreWhiteColor
        userProfileStruct = UserProfileStruct()
        
        self.addViews()
        self.authenticationCheck()
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.backDrop)
        
        self.backDrop.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.backDrop.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        self.backDrop.heightAnchor.constraint(equalToConstant: 208).isActive = true
        self.backDrop.widthAnchor.constraint(equalToConstant: 206).isActive = true
        
        self.backDrop.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.5) {
            self.backDrop.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    func authenticationCheck() {
        
        //USER IS NOT AUTHENTICATED
        if Auth.auth().currentUser?.uid == nil {
            self.perform(#selector(self.handleWelcomeController), with: nil, afterDelay: 1.0)
            
        //USER IS AUTHENTICATED
        } else if Auth.auth().currentUser?.uid != nil {
            
            AuthCheckUsers.authCheck { (hasAuth) in
                
                if hasAuth {
                    self.perform(#selector(self.handleHomeController), with: nil, afterDelay: 1.0)
                } else {
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
