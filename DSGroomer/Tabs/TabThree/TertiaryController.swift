//
//  TertiaryController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//

import Foundation
import Firebase

class TertiaryController : UIViewController {
    
    var homeController : HomeController?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreWhiteColor
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleLogout)))

    }
    
    @objc func handleLogout() {
      
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        Database.database().reference().removeAllObservers()
        
        let decisionController = DecisionController()
        let nav = UINavigationController(rootViewController: decisionController)
        nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.isHidden = true
        self.navigationController?.present(nav, animated: true, completion: nil)
        
    }
}
