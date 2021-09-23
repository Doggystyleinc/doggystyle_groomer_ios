//
//  DashboardEngine.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/23/21.
//

import Foundation
import UIKit
import Firebase

extension DashboardController {
    
    @objc func runDataEngine() {
        
        self.mainLoadingScreen.callMainLoadingScreen(lottiAnimationName: Statics.LOADING_ANIMATION_GENERAL)
        
        //MARK: - GRAB THE PLAYBOOK KEY FROM THE ALL USERS NODE FOR PLAYBOOKS REFERENCE
        self.grabPlayBookKey { doesKeyExist, returnedKey, user_uid in
            
            if doesKeyExist {
                
                //MARK: - CHECK TO SEE IF THE GROOMER HAS COMPLETED THEIR PROFILE MANAGEMENT
                self.checkProfileManagentCompletion(groomerKey: returnedKey) { hasCompletedProfileManagement in
                    
                    if hasCompletedProfileManagement {
                        self.mainLoadingScreen.cancelMainLoadingScreen()
                        self.handleProfileManagementCompletionSetup()
                    } else {

                        var counter : Int = 0
                        
                        let keyArray : [String] = ["groomer_has_completed_profile_photo_management", "groomer_has_completed_driver_license_management", "groomer_has_completed_background_check_management", "groomer_has_completed_payment_preferences", "groomer_has_completed_employee_agreement"]
                        
                        for i in 0..<keyArray.count {
                         
                            let key = keyArray[i]

                            self.runProfileIndividualChecker(groomerKey: returnedKey, passedDatabaseKey: key) { isComplete, userHasManagementStep in

                                if isComplete {
                                    
                                    if userHasManagementStep {
                                        
                                        switch counter {
                                        
                                        case 0: self.groomerChecklistCollection.checkListBooleanArray[counter] = true
                                        case 1: self.groomerChecklistCollection.checkListBooleanArray[counter] = true
                                        case 2: self.groomerChecklistCollection.checkListBooleanArray[counter] = true
                                        case 3: self.groomerChecklistCollection.checkListBooleanArray[counter] = true
                                        case 4: self.groomerChecklistCollection.checkListBooleanArray[counter] = true
                                            
                                        default:print("never")
                                        
                                        }
                                        
                                        self.handleGroomerCollectionReload()
                                        
                                    } else {

                                        switch counter {
                                        
                                        case 0: self.groomerChecklistCollection.checkListBooleanArray[counter] = false
                                        case 1: self.groomerChecklistCollection.checkListBooleanArray[counter] = false
                                        case 2: self.groomerChecklistCollection.checkListBooleanArray[counter] = false
                                        case 3: self.groomerChecklistCollection.checkListBooleanArray[counter] = false
                                        case 4: self.groomerChecklistCollection.checkListBooleanArray[counter] = false
                                            
                                        default:print("never")
                                        
                                        }
                                        
                                        self.handleGroomerCollectionReload()

                                    }
                                    
                                    self.mainLoadingScreen.cancelMainLoadingScreen()
                                    self.unhideGroomerProfileSetup()
                                    counter += 1
                                    
                                    for i in self.groomerChecklistCollection.checkListBooleanArray {
                                        print(i)
                                    }

                                } else {
                                    
                                    AlertControllerCompletion.handleAlertWithCompletion(title: "FATAL ERROR", message: "Please reach out to HQ @ \(Statics.SUPPORT_EMAIL_ADDRESS) and let them know your account needs attention. Please append this unique ID to the email as well: \(user_uid) - thank you.") { isComplete in
                                        self.homeController?.handleLogout()
                                    }
                                }
                            }
                        }
                    }
                }
                
            } else {
                self.mainLoadingScreen.cancelMainLoadingScreen()
                AlertControllerCompletion.handleAlertWithCompletion(title: "FATAL ERROR", message: "Please reach out to HQ @ \(Statics.SUPPORT_EMAIL_ADDRESS) and let them know your account needs attention. Please append this unique ID to the email as well: \(user_uid) - thank you.") { isComplete in
                    self.homeController?.handleLogout()
                }
            }
        }
    }
    
    @objc func grabPlayBookKey(completion : @escaping (_ keyExists : Bool, _ returnedKey : String, _ userUID : String) -> () ) {
        
        guard let user_uid = Auth.auth().currentUser?.uid else {
            self.homeController?.handleLogout()
            completion(false, "nil", "nil")
            return
        }
        
        let ref = self.databaseRef.child("all_users").child(user_uid).child("groomer_child_key_from_playbook")
        
        ref.observeSingleEvent(of: .value) { snap in
            
            let value = snap.value as? String ?? "nil"
            
            if value == "nil" {
                completion(false, value, user_uid)
            } else {
                completion(true, value, user_uid)
            }
        }
    }
    
    func checkProfileManagentCompletion(groomerKey : String, completion : @escaping (_ hasCompletedProfileManagement : Bool)->()) {
        
        let ref = self.databaseRef.child("play_books").child(groomerKey).child("groomer_has_completed_groomer_profile_management")
        
        ref.observeSingleEvent(of: .value) { snap in
            
            let groomer_has_completed_groomer_profile_management = snap.value as? Bool ?? false
            
            if groomer_has_completed_groomer_profile_management == false {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    @objc func runProfileIndividualChecker(groomerKey : String, passedDatabaseKey : String, completion : @escaping (_ isComplete : Bool, _ hasManagementFeature : Bool)->()) {
        
        let ref = self.databaseRef.child("play_books").child(groomerKey)
        
        ref.observeSingleEvent(of: .value) { snap in
            
            guard let JSON = snap.value as? [String : Any] else {
                completion(false, false)
                return
            }
            
            let value = JSON[passedDatabaseKey] as? Bool ?? false
            
            if value == true {
                
                completion(true, true)
                
            } else {
                
                completion(true, false)
                
            }
        }
    }
}
