//
//  MainController.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//

import Foundation
import Firebase

class MainController : UIViewController {
    
    var homeController : HomeController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreWhiteColor
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.handleLogout))
        self.view.addGestureRecognizer(gesture)
        
    }
    
    @objc func handleLogout() {
        
        print("called")
        
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
