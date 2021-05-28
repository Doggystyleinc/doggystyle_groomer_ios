//
//  RatingLibrary.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//


import Foundation
import Firebase
import StoreKit

class RatingLibraryExtension : NSObject {
    
    let databaseRef = Database.database().reference()
    var labelVersion : Double?
    
    override init() {
        super.init()
    }
    
    func checkForRating() {
        
        //Grab the Current Version From The Application
        if let version : NSString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? NSString {
            self.labelVersion = version.doubleValue
            
            //Grab the Current Version From Firebase Manually Inputted By The Developer
            guard let currentUserUid = Auth.auth().currentUser?.uid else {return}
            let versionReference = self.databaseRef.child("current_version_reference") //Manually Stored in Server prints 1
            let userCountReference = self.databaseRef.child("current_user_count_check").child(currentUserUid).child("number_for_current_version") //CreatedByTheUser
            
            versionReference.observeSingleEvent(of: .value, with: { (snapshot : DataSnapshot) in
                
                guard let dic = snapshot.value as? [String : AnyObject] else {return}
                
                guard let currentVersionGrab = dic["current_version"] as? NSNumber else {return}
                
                guard let safeVersion = self.labelVersion else {return}
                
                if self.labelVersion != nil {
                    
                    let versionConverted = currentVersionGrab.doubleValue
                    
                    if safeVersion >= versionConverted {
                        
                        userCountReference.observeSingleEvent(of: .value, with: { (snapshotTwo : DataSnapshot) in
                            
                            if snapshotTwo.exists() {
                                
                                guard let totalCurrentUses = snapshotTwo.value as? [String : AnyObject] else {return}
                                guard let totalCount = totalCurrentUses["number_for_current_version"]  as? NSNumber else {return}
                                guard let checkIfCurrentVersionExists = totalCurrentUses["rated_version_check"]  as? NSNumber else {return}
                                
                                let checkConversion = checkIfCurrentVersionExists.doubleValue
                                let incrementedValue = totalCount.intValue + 1
                                
                                if checkConversion != safeVersion {
                                    
                                    if incrementedValue == 3 { //Check after every 6 uses per Version - was 5
                                        
                                        let setToZero : NSNumber = 0
                                        let convertedSafeVersion = NSNumber(value: safeVersion)
                                        let values : [String : AnyObject] = ["number_for_current_version" : setToZero, "rated_version_check" : convertedSafeVersion]
                                        userCountReference.updateChildValues(values)
                                        
                                        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                            if #available(iOS 14.0, *) {
                                                SKStoreReviewController.requestReview(in: scene)
                                            } else {
                                                SKStoreReviewController.requestReview()
                                            }
                                        }
                                        
                                    } else if incrementedValue <= 2 {
                                        
                                        let convertedBack = NSNumber(value: incrementedValue)
                                        let values : [String : AnyObject] = ["number_for_current_version" : convertedBack]
                                        userCountReference.updateChildValues(values)
                                        
                                    }
                                }
                                
                            } else if !snapshotTwo.exists() {
                                
                                let currentCount : NSNumber = 1
                                let currentVersionNotRegistered : NSNumber = 100
                                let values : [String : AnyObject] = ["number_for_current_version" : currentCount, "rated_version_check" : currentVersionNotRegistered]
                                userCountReference.updateChildValues(values)
                                
                            }
                            
                        }, withCancel: { (error) in
                            
                            
                        })
                        
                    }
                }
                
            }, withCancel: { (error) in
                print(error)
            })
        }
    }
}

