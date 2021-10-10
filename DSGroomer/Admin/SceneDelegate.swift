//
//  SceneDelegate.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/25/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?,
        counter : Int = 0

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //MARK: - INITIAL ENTRY INTO THE APPLICATION
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        
        //MARK: - WINDOW INIT
        let window = UIWindow(windowScene: sceneWindow)
        window.makeKeyAndVisible()
        
        let decisionController = MapLocationController(),
            navigationController = UINavigationController(rootViewController: decisionController)
        navigationController.navigationBar.isHidden = true
        navigationController.modalPresentationStyle = .fullScreen
        window.rootViewController = navigationController
        
        self.window = window
   
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {

        self.counter += 1
        
        if self.counter > 1 {
        //APPLICATION - IS PUSHED TO THE FOREGROUND FROM ANY STATE
        NotificationCenter.default.post(name: NSNotification.Name(Statics.RUN_LOCATION_CHECKER), object: nil)
            
        }
    }
}

