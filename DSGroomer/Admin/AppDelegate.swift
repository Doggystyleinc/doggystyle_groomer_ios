//
//  AppDelegate.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/25/21.
//

import UIKit
import Firebase
import GoogleSignIn
import GooglePlaces
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //FIREBASE CONFIGURATION
        FirebaseApp.configure()
        
        //GOOGLE-OAUTH SIGN IN
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        //GOOGLE PLACES KEY
        GMSPlacesClient.provideAPIKey("AIzaSyCfb7KxeoO6WSfQ7jpcBbykiMvyRHv6zaw")
        
        //GOOGLE MAPS KEY
        GMSServices.provideAPIKey("AIzaSyD0QooK2JJuDUBU0MSlRBLU0FT3STJoFVw")
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
}

