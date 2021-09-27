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
                self.checkGroomerChecklistCompletion(groomerKey: returnedKey) { hasCompletedProfileManagement, hasCompletedBiographyManagement, keyCompletionBooleanArray in
                    
                    if hasCompletedBiographyManagement {
                  
                          self.mainLoadingScreen.cancelMainLoadingScreen()
                          self.setupTheUsersDashboard()
  
                      //MARK: - GROOMER HAS TO COMPLETE HIS BIOGRAPHY
                      } else if hasCompletedProfileManagement {
  
                          self.mainLoadingScreen.cancelMainLoadingScreen()
                          self.handleProfileManagementCompletionSetup()
  
                      } else {
                        
                        print("AM I IN HERE?")
                        self.mainLoadingScreen.cancelMainLoadingScreen()
                        self.groomerChecklistCollection.checkListBooleanArray = keyCompletionBooleanArray
                        self.unhideGroomerProfileSetup()
                        self.handleGroomerCollectionReload()
  
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
    
    func checkGroomerChecklistCompletion(groomerKey : String, completion : @escaping (_ hasCompletedProfileManagement : Bool, _ hasCompletedBiographyManagement : Bool, _ booleanKeyValue : [Bool])->()) {
        
        let ref = self.databaseRef.child("play_books").child(groomerKey)
        
        ref.observeSingleEvent(of: .value) { snap in
            
            guard let JSON = snap.value as? [String : Any] else {
                completion(false, false, [false, false, false, false, false])
                return
            }
            
            //MARK: - THESE KEYS ARE FOR COMPLETION STATUS
            let groomer_has_completed_groomer_profile_management = JSON["groomer_has_completed_groomer_profile_management"] as? Bool ?? false
            let groomer_has_completed_biography_management = JSON["groomer_has_completed_biography_management"] as? Bool ?? false
            
            //MARK: - THESE KEYS ARE FOR BOOLEAN AND TASK COMPLETION
            let groomer_has_completed_profile_photo_management = JSON["groomer_has_completed_profile_photo_management"] as? Bool ?? false
            let groomer_has_completed_driver_license_management = JSON["groomer_has_completed_driver_license_management"] as? Bool ?? false
            let groomer_has_completed_background_check_management = JSON["groomer_has_completed_background_check_management"] as? Bool ?? false
            let groomer_has_completed_payment_preferences = JSON["groomer_has_completed_payment_preferences"] as? Bool ?? false
            let groomer_has_completed_employee_agreement = JSON["groomer_has_completed_employee_agreement"] as? Bool ?? false
            
            print("\(groomer_has_completed_groomer_profile_management), \(groomer_has_completed_biography_management)\n\n\(groomer_has_completed_profile_photo_management), \(groomer_has_completed_driver_license_management), \(groomer_has_completed_background_check_management), \(groomer_has_completed_payment_preferences), \(groomer_has_completed_employee_agreement)")

            //MARK:- FIRST CHECK TO SEE IF THE WHOLE PROCESS IS COMPLETE
            if groomer_has_completed_groomer_profile_management == false {
                
            //MARK: IF THE PROCESS IS NOT COMPLETE, CHECK FOR AN UPDATE
            if groomer_has_completed_profile_photo_management == true &&
               groomer_has_completed_driver_license_management == true &&
               groomer_has_completed_background_check_management == true &&
               groomer_has_completed_payment_preferences == true &&
               groomer_has_completed_employee_agreement == true {
                
                let ref = self.databaseRef.child("play_books").child(groomerKey)
                
                  let values : [String : Any] = ["groomer_has_completed_groomer_profile_management" : true]

                  ref.updateChildValues(values) { error, ref in
                      completion(true, groomer_has_completed_biography_management, [groomer_has_completed_profile_photo_management, groomer_has_completed_driver_license_management, groomer_has_completed_background_check_management, groomer_has_completed_payment_preferences, groomer_has_completed_employee_agreement])
                    return
                  }
            } else {
                completion(groomer_has_completed_groomer_profile_management, groomer_has_completed_biography_management, [groomer_has_completed_profile_photo_management, groomer_has_completed_driver_license_management, groomer_has_completed_background_check_management, groomer_has_completed_payment_preferences, groomer_has_completed_employee_agreement])
            }
                
            } else if groomer_has_completed_groomer_profile_management == true {
                
                completion(groomer_has_completed_groomer_profile_management, groomer_has_completed_biography_management, [groomer_has_completed_profile_photo_management, groomer_has_completed_driver_license_management, groomer_has_completed_background_check_management, groomer_has_completed_payment_preferences, groomer_has_completed_employee_agreement])
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









//    func checkProfileManagentCompletion(groomerKey : String, completion : @escaping (_ hasCompletedProfileManagement : Bool, _ hasCompletedBiographyManagement : Bool, _ hasCompletedBackgroundCheckManagement : Bool, _ hasCompletedPaymentPreferencesManagement : Bool, _ hasCompletedEmployeeAgreementManagement : Bool)->()) {
//
//        let ref = self.databaseRef.child("play_books").child(groomerKey)
//
//        ref.observeSingleEvent(of: .value) { snap in
//
//            guard let JSON = snap.value as? [String : Any] else {
//                completion(false, false, false, false, false)
//                return
//            }
//
//            let groomer_has_completed_groomer_profile_management = JSON["groomer_has_completed_groomer_profile_management"] as? Bool ?? false
//            let groomer_has_completed_biography_management = JSON["groomer_has_completed_biography_management"] as? Bool ?? false
//            let groomer_has_completed_profile_photo_management = JSON["groomer_has_completed_profile_photo_management"] as? Bool ?? false
//            let groomer_has_completed_driver_license_management = JSON["groomer_has_completed_driver_license_management"] as? Bool ?? false
//            let groomer_has_completed_background_check_management = JSON["groomer_has_completed_background_check_management"] as? Bool ?? false
//            let groomer_has_completed_payment_preferences = JSON["groomer_has_completed_payment_preferences"] as? Bool ?? false
//            let groomer_has_completed_employee_agreement = JSON["groomer_has_completed_employee_agreement"] as? Bool ?? false
//
//                 if groomer_has_completed_profile_photo_management == true &&
//                    groomer_has_completed_driver_license_management == true &&
//                    groomer_has_completed_background_check_management == true &&
//                    groomer_has_completed_payment_preferences == true &&
//                    groomer_has_completed_employee_agreement == true {
//
//                let ref = self.databaseRef.child("play_books").child(groomerKey)
//                let values : [String : Any] = ["groomer_has_completed_groomer_profile_management" : true]
//
//                ref.updateChildValues(values) { error, ref in
//                    completion(true, groomer_has_completed_biography_management, groomer_has_completed_background_check_management, groomer_has_completed_payment_preferences, groomer_has_completed_employee_agreement)
//                }
//
//            } else {
//
//                completion(groomer_has_completed_groomer_profile_management, groomer_has_completed_biography_management, groomer_has_completed_background_check_management, groomer_has_completed_payment_preferences, groomer_has_completed_employee_agreement)
//            }
//        }
//    }




//
//
//let keyArray : [String] = ["groomer_has_completed_profile_photo_management", "groomer_has_completed_driver_license_management", "groomer_has_completed_background_check_management", "groomer_has_completed_payment_preferences", "groomer_has_completed_employee_agreement"]
//                        var counter : Int = 0

//                        for i in 0..<keyArray.count {
//
//                            let key = keyArray[i]
//
//                            self.runProfileIndividualChecker(groomerKey: returnedKey, passedDatabaseKey: key) { isComplete, userHasManagementStep in
//
//                                if isComplete {
//
//                                    if userHasManagementStep {
//
//                                        switch counter {
//
//                                        case 0: self.groomerChecklistCollection.checkListBooleanArray[counter] = true
//                                        case 1: self.groomerChecklistCollection.checkListBooleanArray[counter] = true
//                                        case 2: self.groomerChecklistCollection.checkListBooleanArray[counter] = true
//                                        case 3: self.groomerChecklistCollection.checkListBooleanArray[counter] = true
//                                        case 4: self.groomerChecklistCollection.checkListBooleanArray[counter] = true
//
//                                        default:print("never")
//
//                                        }
//
//                                        self.handleGroomerCollectionReload()
//
//                                    } else {
//
//                                        switch counter {
//
//                                        case 0: self.groomerChecklistCollection.checkListBooleanArray[counter] = false
//                                        case 1: self.groomerChecklistCollection.checkListBooleanArray[counter] = false
//                                        case 2: self.groomerChecklistCollection.checkListBooleanArray[counter] = false
//                                        case 3: self.groomerChecklistCollection.checkListBooleanArray[counter] = false
//                                        case 4: self.groomerChecklistCollection.checkListBooleanArray[counter] = false
//
//                                        default:print("never")
//
//                                        }
//
//                                        self.handleGroomerCollectionReload()
//
//                                    }
//
//                                    self.mainLoadingScreen.cancelMainLoadingScreen()
//                                    self.unhideGroomerProfileSetup()
//                                    counter += 1
//
//                                    for i in self.groomerChecklistCollection.checkListBooleanArray {
//                                        print(i)
//                                    }
//
//                                } else {
//
//                                    AlertControllerCompletion.handleAlertWithCompletion(title: "FATAL ERROR", message: "Please reach out to HQ @ \(Statics.SUPPORT_EMAIL_ADDRESS) and let them know your account needs attention. Please append this unique ID to the email as well: \(user_uid) - thank you.") { isComplete in
//                                        self.homeController?.handleLogout()
//                                    }
//                                }
//                            }
//                        }










//                self.checkProfileManagentCompletion(groomerKey: returnedKey) { hasCompletedProfileManagement, hasCompletedBiographyManagement, hasCompletedBackgroundCheckManagement, hasCompletedPaymentPreferencesManagement, groomer_has_completed_employee_agreement   in
//
//                    //MARK: - GROOMER HAS COMPLETED EVERY PROFILE SETUP, TAKE THEM TO THE DASHBOARD
//                    if hasCompletedBiographyManagement {
//
//                        self.mainLoadingScreen.cancelMainLoadingScreen()
//                        self.setupTheUsersDashboard()
//
//                    //MARK: - GROOMER HAS TO COMPLETE HIS BIOGRAPHY
//                    } else if hasCompletedProfileManagement {
//
//                        self.mainLoadingScreen.cancelMainLoadingScreen()
//                        self.handleProfileManagementCompletionSetup()
//
//                    } else {
//
//
//                    }
//                }
