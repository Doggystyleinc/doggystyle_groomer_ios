//
//  SceneDelegate.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/25/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //MARK: - INITIAL ENTRY INTO THE APPLICATION
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        
        //MARK: - WINDOW INIT
        let window = UIWindow(windowScene: sceneWindow)
        window.makeKeyAndVisible()

        let decisionController = DecisionController(),
            navigationController = UINavigationController(rootViewController: decisionController)
            navigationController.navigationBar.isHidden = true
            navigationController.modalPresentationStyle = .fullScreen
        
        window.rootViewController = navigationController
        self.window = window
        
        //MARK: - NOTIFICATION PROMPT/ALERT
        UNUserNotificationCenter.current().requestAuthorization(options: .badge) { (granted, error) in
            if error != nil {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

