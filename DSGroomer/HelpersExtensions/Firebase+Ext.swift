//
//  Firebase+Ext.swift
//  Project Doggystyle
//
//  Created by Charlie Arcodia on 5/11/21.

//Apple Auth: https://firebase.google.com/docs/auth/ios/apple
//Google Auth: https://firebase.google.com/docs/auth/ios/google-signin
//Email Auth: https://firebase.google.com/docs/auth/ios/password-auth

import Foundation
import UIKit
import Firebase

//MARK:- SERVICE SINGLETON FOR CRUD OPERATIONS
class Service : NSObject {
  
    static let shared = Service()
    
    func uploadProfileImage(imageToUpload : UIImage, completion : @escaping (_ isComplete : Bool, _ imageURL : String) -> ()) {
        
        guard let userUid = Auth.auth().currentUser?.uid else {return}
        guard let imageDataToUpload = imageToUpload.jpegData(compressionQuality: 0.15) else {return}
        
        let storageRef = Storage.storage().reference()
        let databaseRef = Database.database().reference()
        
        let randomString = NSUUID().uuidString
        let imageRef = storageRef.child("groomer_profile_photos").child(userUid).child(randomString)
        
        imageRef.putData(imageDataToUpload, metadata: nil) { (metaDataPass, error) in
            
            if error != nil {
                completion(false, "nil")
                return
            }
            
            imageRef.downloadURL(completion: { (urlGRab, error) in
                
                if error != nil {
                    completion(false, "nil")
                    return
                }
                
                if let uploadUrl = urlGRab?.absoluteString {
                    
                    let values : [String : Any] = ["profile_image_url" : uploadUrl]
                    let refUploadPath = databaseRef.child("all_users").child(userUid)
                    
                    refUploadPath.updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            completion(false, "nil")
                            return
                        } else {
                            
                        let groomerKey = groomerUserStruct.groomer_child_key_from_playbook ?? "nil"
                        let playbookRef = databaseRef.child("play_books").child(groomerKey)
                            
                        let playbookValues : [String : Any] = ["groomer_has_completed_profile_photo_management" : true]
                            playbookRef.updateChildValues(playbookValues) { error, ref in
                                
                                completion(true, uploadUrl)

                            }
                        }
                    })
                }
            })
        }
    }
    
    func uploadDriversLicenseImage(imageToUpload : UIImage, completion : @escaping (_ isComplete : Bool, _ driversImageURL : String) -> ()) {
        
        guard let userUid = Auth.auth().currentUser?.uid else {return}
        guard let imageDataToUpload = imageToUpload.jpegData(compressionQuality: 0.15) else {return}
        let storageRef = Storage.storage().reference()
        let databaseRef = Database.database().reference()
        
        let randomString = NSUUID().uuidString
        let imageRef = storageRef.child("groomers_driver_license").child(userUid).child(randomString)
        
        imageRef.putData(imageDataToUpload, metadata: nil) { (metaDataPass, error) in
            
            if error != nil {
                completion(false, "nil")
                return
            }
            
            imageRef.downloadURL(completion: { (urlGRab, error) in
                
                if error != nil {
                    completion(false, "nil")
                    return
                }
                
                if let uploadUrl = urlGRab?.absoluteString {
                    
                    let values : [String : Any] = ["drivers_license_image_url" : uploadUrl]
                    let refUploadPath = databaseRef.child("all_users").child(userUid)
                    
                    refUploadPath.updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            completion(false, "nil")
                            return
                        } else {
                            
                        let groomerKey = groomerUserStruct.groomer_child_key_from_playbook ?? "nil"
                        let playbookRef = databaseRef.child("play_books").child(groomerKey)
                            
                        let playbookValues : [String : Any] = ["groomer_has_completed_driver_license_management" : true]
                            playbookRef.updateChildValues(playbookValues) { error, ref in
                                
                                completion(true, uploadUrl)

                            }
                        }
                    })
                }
            })
        }
    }
    
    func uploadDriversLicenseDocumentFile(localFilePath : URL, completion : @escaping (_ isComplete : Bool, _ driversLicenseImageURL : String)->()) {
        
        let storageRef = Storage.storage().reference()
        let databaseRef = Database.database().reference()
        guard let user_uid = Auth.auth().currentUser?.uid else {return}
        
        let randomUUID = NSUUID().uuidString
        
        let storageReference = storageRef.child("groomers_driver_license").child(user_uid).child(randomUUID)
        
        let uploadTask = storageReference.putFile(from: localFilePath, metadata: nil)
        
        uploadTask.observe(.failure) { snapshot in
            completion(false, "nil")
            return
        }
        
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print("PROGRESS: ", CGFloat(percentComplete))
        }
        
        uploadTask.observe(.success) { snapshot in
            
            storageReference.downloadURL { (url, error) in
                
                if error != nil {
                    completion(false, "nil")
                    return
                }
                
                if let uploadUrl = url?.absoluteString {
                    
                    let values : [String : Any] = ["drivers_license_image_url" : uploadUrl]
                    let refUploadPath = databaseRef.child("all_users").child(user_uid)
                    
                    refUploadPath.updateChildValues(values, withCompletionBlock: { (error, ref) in
                        
                        if error != nil {
                            completion(false, "nil")
                            return
                            
                        } else {
                            
                        let groomerKey = groomerUserStruct.groomer_child_key_from_playbook ?? "nil"
                        let playbookRef = databaseRef.child("play_books").child(groomerKey)
                            
                        let playbookValues : [String : Any] = ["groomer_has_completed_driver_license_management" : true]
                            playbookRef.updateChildValues(playbookValues) { error, ref in
                                
                                completion(true, uploadUrl)

                            }
                        }
                    })
                }
            }
        }
    }
   
    //MARK:- DOUBLE CHECK FOR AUTH SO WE CAN MAKE SURE THERE ALL USERS NODE IS CURRENT
    func authCheck(completion : @escaping (_ hasAuth : Bool)->()) {
        
        if let user_uid = Auth.auth().currentUser?.uid {
            
            let ref = Database.database().reference().child("all_users").child(user_uid).child("users_firebase_uid")
            
            ref.observeSingleEvent(of: .value) { (snap : DataSnapshot) in
                
                if snap.exists() {
                    print(snap.value as? String ?? "none-here")
                    completion(true)
                } else {
                    completion(false)
                }
                
            } withCancel: { (error) in
                completion(false)
            }
        } else {
            completion(false)
        }
    }
    
    func handlePlaybookChecker(phoneNumber : String, areaCode : String, completion : @escaping (_ isComplete : Bool, _ message : String, _ groomersFirstName : String, _ groomersLastName : String, _ groomersEmail : String, _ groomerChildKey : String) -> ()) {
        
        let databaseRef = Database.database().reference()
        
        var observingRefOne = Database.database().reference(),
            handleOne = DatabaseHandle()
        
        let ref = databaseRef.child("play_books")
        
        observingRefOne = databaseRef.child("play_books")
        
        var counter : Int = 0
        
        ref.observeSingleEvent(of: .value) { snapShot in
          
            if snapShot.exists() {
                
                let childrenCount = Int(snapShot.childrenCount)
                
                handleOne = observingRefOne.observe(.childAdded) { snapLoop in
                  
                    counter += 1;

                    if let JSON = snapLoop.value as? [String : Any] {
                        
                        let groomers_phone_number = JSON["groomers_phone_number"] as? String ?? "nil"
                        
                        if groomers_phone_number == phoneNumber {
                            
                            observingRefOne.removeObserver(withHandle: handleOne)
                          
                            let groomer_has_registered = JSON["groomer_has_registered"] as? Bool ?? false
                            let groomers_first_name = JSON["groomers_first_name"] as? String ?? "Incognito"
                            let groomers_last_name = JSON["groomers_last_name"] as? String ?? "Incognito"
                            let groomers_email = JSON["groomers_email"] as? String ?? "Incognito"
                            let groomer_child_key = JSON["groomer_child_key"] as? String ?? "nil"
                            
                            if groomer_has_registered == false {
                             
                                observingRefOne.removeObserver(withHandle: handleOne)
                                
                                completion(true, "ok", groomers_first_name, groomers_last_name, groomers_email, groomer_child_key)
                                return
                                
                            } else {

                                observingRefOne.removeObserver(withHandle: handleOne)
                                completion(false, "Hello \(groomers_first_name.capitalizingFirstLetter()), you already have an existing account inside the Doggystyle Admin Portal. Please tap Login and enter your associated phone #. Further assistance can be found at: \(Statics.SUPPORT_EMAIL_ADDRESS)", groomers_first_name, groomers_last_name, groomers_email, groomer_child_key)
                                return
                            }
                            
                        } else {
                            
                            if counter == childrenCount {

                                observingRefOne.removeObserver(withHandle: handleOne)
                                completion(false, "Hello! We cannot find you in the Doggystyle Portal. Please check your phone number and try again. For further assistance, please contact: \(Statics.SUPPORT_EMAIL_ADDRESS)", "nil", "nil", "nil", "nil")
                                return
                            }
                            
                        }
                        
                    } else {
                        
                        observingRefOne.removeObserver(withHandle: handleOne)
                        completion(false, "Please contact: \(Statics.SUPPORT_EMAIL_ADDRESS)", "nil", "nil", "nil", "nil")
                        return
                    }
                }
                
            } else {
                
                observingRefOne.removeObserver(withHandle: handleOne)
                completion(false, "Seems we cannot find you in our system. Please check the phone number and try again. For further assistance, please contact: \(Statics.SUPPORT_EMAIL_ADDRESS)", "nil", "nil", "nil", "nil")
                return
            }
        }
    }
    
    
    //MARK:- REGISTRATION: ERROR CODE 200 PROMPTS REGISTRATION SUCCESS WITH LOGIN FAILURE, SO CALL LOGIN FUNCTION AGAIN INDEPENDENTLY. 500 = REGISTRATION FAILED, CALL THIS FUNCTION AGAIN FROM SCRATCH.
    func FirebaseRegistrationAndLogin(completion : @escaping (_ registrationSuccess : Bool, _ response : String, _ responseCode : Int, _ errorMessage : String)->()) {
        
        guard let groomers_phone_number = groomerOnboardingStruct.groomers_phone_number else {return}
        guard let groomers_area_code = groomerOnboardingStruct.groomers_area_code else {return}
        guard let groomers_complete_phone_number = groomerOnboardingStruct.groomers_complete_phone_number else {return}
        
        guard let groomers_location_latitude = groomerOnboardingStruct.groomers_location_latitude else {return}
        guard let groomers_location_longitude = groomerOnboardingStruct.groomers_location_longitude else {return}
        
        guard let groomers_first_name = groomerOnboardingStruct.groomers_first_name else {return}
        guard let groomers_last_name = groomerOnboardingStruct.groomers_last_name else {return}
        guard let groomers_email = groomerOnboardingStruct.groomers_email else {return}
        guard let groomers_city = groomerOnboardingStruct.groomers_city else {return}
        guard let groomers_referral_code = groomerOnboardingStruct.groomers_referral_code else {return}
        
        guard let groomer_accepted_terms_of_service = groomerOnboardingStruct.groomer_accepted_terms_of_service else {return}
        guard let groomer_enable_notifications = groomerOnboardingStruct.groomer_enable_notifications else {return}
        guard let groomer_child_key = groomerOnboardingStruct.groomer_child_key else {return}
        guard let groomers_password = groomerOnboardingStruct.groomers_password else {return}
        
        //MARK: - AUTHENTICATE A NEW ACCOUNT ON BEHALF OF THE GROOMER
        Auth.auth().createUser(withEmail: groomers_email, password: groomers_password) { (result, error) in
            
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    
                    switch errCode {
                    case .emailAlreadyInUse: completion(false, "\(errCode)", 500, "Email: \(groomers_email) is already in use by another groomer. If this is not you, please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS).")
                    case .accountExistsWithDifferentCredential: completion(false, "\(errCode)", 501, "Account already exists with different credentials. Please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS) for further assistance.")
                    case .credentialAlreadyInUse: completion(false, "\(errCode)", 502, "Credentials already in use. Please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS) for further assistance. ")
                    case .emailChangeNeedsVerification: completion(false, "\(errCode)", 503, "Email change needs verification. Please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS) for further assistance.")
                    case .expiredActionCode: completion(false, "\(errCode)", 504, "Registration code has expired. Please try again. If this issue persists, please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS) for further assistance.")
                    default: completion(false, "Registration Error: \(error?.localizedDescription as Any).", 505, "This one may be on us. If this issue persists, please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS) for further assistance.")
                    }
                    
                    return
                    
                } else {
                    completion(false, "Registration Error: \(error?.localizedDescription as Any).", 500, "This one may be on us. If this issue persists, please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS) for further assistance.")
                }
                
            } else {
                
                //MARK: - SIGN IN ON BEHALF OF THE GROOMER
                Auth.auth().signIn(withEmail: groomers_email, password: groomers_password) { (user, error) in
                    
                    if error != nil {
                        completion(false, "Login Error: \(error?.localizedDescription as Any).", 200, "Hello! Okay, here’s what happened. We were able to complete your account, but we were unable to sign you in. Please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS). Thank you.")
                        return
                    }
                    
                    //MARK: - UPDATE THE DATABASE ON BEHALF OF THE GROOMER
                    guard let firebase_uid = user?.user.uid else {
                        completion(false, "UID Error: \(error?.localizedDescription as Any).", 200, "Hello! Okay, here’s what happened. We were able to complete your account, but we were unable to sign you in. Please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS). Thank you.")
                        return
                    }
                    
                    let databaseRef = Database.database().reference()
                    
                    let ref = databaseRef.child("all_users").child(firebase_uid)
                    
                    let timeStamp : Double = NSDate().timeIntervalSince1970,
                        ref_key = ref.key ?? "nil_key"
                    
                    let values : [String : Any] = ["groomers_phone_number" : groomers_phone_number,
                                                   "groomers_area_code" : groomers_area_code,
                                                   "groomers_complete_phone_number" : groomers_complete_phone_number,
                                                   
                                                   "groomers_location_latitude" : groomers_location_latitude,
                                                   "groomers_location_longitude" : groomers_location_longitude,
                                                   
                                                   "groomers_first_name" : groomers_first_name,
                                                   "groomers_last_name" : groomers_last_name,
                                                   "groomers_email" : groomers_email,
                                                   "groomers_city" : groomers_city,
                                                   "groomers_referral_code" : groomers_referral_code,
                                                   
                                                   "groomer_accepted_terms_of_service" : groomer_accepted_terms_of_service,
                                                   "groomer_enable_notifications" : groomer_enable_notifications,
                                                   "is_groomer" : true,
                                                   "users_ref_key" : ref_key,
                                                   "users_sign_up_date" : timeStamp,
                                                   "groomer_child_key_from_playbook" : groomer_child_key
                    ]
                    
                    ref.updateChildValues(values) { (error, ref) in
                        
                        if error != nil {
                            completion(false, "Login Error: \(error?.localizedDescription as Any).", 200, "Hello! Okay, here’s what happened. We were able to complete your account and sign you in, but we were unable to complete your registration. Please reach out to HQ: \(Statics.SUPPORT_EMAIL_ADDRESS). Thank you.")
                            return
                        }
                        
                        let playbookRef = databaseRef.child("play_books").child(groomer_child_key)
                        
                        let playbookValues : [String : Any] = ["groomer_has_registered" : true]
                        
                        playbookRef.updateChildValues(playbookValues) { error, ref in
                            
                            completion(true, "Success", 200, "Registration/login/datasource account creation success.")
                            
                        }
                    }
                }
            }
        }
    }
    
    func fillGroomerDataStruct(completion : @escaping (_ isComplete : Bool)->()) {
        
        let databaseRef = Database.database().reference()
        guard let user_uid = Auth.auth().currentUser?.uid else {return}
        let path = databaseRef.child("all_users").child(user_uid)
        
        groomerUserStruct = GroomerUserStruct()
        
        path.observeSingleEvent(of: .value) { snap in
            
            if let JSON = snap.value as? [String : Any] {
                
                let groomers_phone_number = JSON["groomers_phone_number"] as? String ?? "nil"
                let groomers_area_code = JSON["groomers_area_code"] as? String ?? "nil"
                let groomers_complete_phone_number = JSON["groomers_complete_phone_number"] as? String ?? "nil"
                
                let groomers_location_latitude = JSON["groomers_location_latitude"] as? Double ?? 0.0
                let groomers_location_longitude = JSON["groomers_location_longitude"] as? Double ?? 0.0
                
                let groomers_first_name = JSON["groomers_first_name"] as? String ?? "nil"
                let groomers_last_name = JSON["groomers_last_name"] as? String ?? "nil"
                let groomers_email = JSON["groomers_email"] as? String ?? "nil"
                let groomers_city = JSON["groomers_city"] as? String ?? "nil"
                let groomers_referral_code = JSON["groomers_referral_code"] as? String ?? "nil"
                
                let groomer_enable_notifications = JSON["groomer_enable_notifications"] as? Bool ?? false
                let users_sign_up_date = JSON["users_sign_up_date"] as? Double ?? 0.0
                let groomer_child_key_from_playbook = JSON["groomer_child_key_from_playbook"] as? String ?? "nil"
                let users_ref_key = JSON["users_ref_key"] as? String ?? "nil"
                let profile_image_url = JSON["profile_image_url"] as? String ?? "nil"
                let drivers_license_image_url = JSON["drivers_license_image_url"] as? String ?? "nil"

                groomerUserStruct.groomers_phone_number = groomers_phone_number
                groomerUserStruct.groomers_area_code = groomers_area_code
                groomerUserStruct.groomers_complete_phone_number = groomers_complete_phone_number
                
                groomerUserStruct.groomers_location_latitude = groomers_location_latitude
                groomerUserStruct.groomers_location_longitude = groomers_location_longitude
                
                groomerUserStruct.groomers_first_name = groomers_first_name
                groomerUserStruct.groomers_last_name = groomers_last_name
                groomerUserStruct.groomers_email = groomers_email
                groomerUserStruct.groomers_city = groomers_city
                groomerUserStruct.groomers_referral_code = groomers_referral_code
                
                groomerUserStruct.groomer_enable_notifications = groomer_enable_notifications
                groomerUserStruct.users_sign_up_date = users_sign_up_date
                groomerUserStruct.groomer_child_key_from_playbook = groomer_child_key_from_playbook
                groomerUserStruct.users_ref_key = users_ref_key
                groomerUserStruct.profile_image_url = profile_image_url
                groomerUserStruct.drivers_license_image_url = drivers_license_image_url

                completion(true)
                
            } else {
                completion(false)
            }
        }
    }
    
    //MARK:- IN THE CASE LOGIN FAILS DURING REGISTRATION AND LOGIN, CALL LOGIN AGAIN ONLY.
    func FirebaseLogin(usersEmailAddress : String, usersPassword : String, completion : @escaping (_ loginSuccess : Bool, _ response : String, _ responseCode : Int) -> ()) {
        
        Auth.auth().signIn(withEmail: usersEmailAddress, password: usersPassword) { (user, error) in
            
            if error != nil {
                completion(false, "Login Error: \(error!.localizedDescription as Any).", 500)
                return
            }
            
            completion(true, "Success", 200)
        }
    }
    
    //MARK:- PASSWORD RESET WITH EMAIL VALIDATION (WEBVIEW)
    func firebaseForgotPassword(validatedEmail : String, completion : @escaping (_ success : Bool, _ response : String)->()) {
        Auth.auth().sendPasswordReset(withEmail: validatedEmail, completion: { (error) in
            if error != nil {
                completion(false, "Failed: \(error!.localizedDescription as Any)")
                return
            }
            completion(true, "Success")
        })
    }
    
    //MARK: - GROOMERS WILL BE ABLE TO REQUEST TIME OFF - APPROVAL CHANGES is_request_approved -> TRUE/has_request_been_satisfied -> TRUE (THIS WILL BE CONTROLLED FROM THE WEBSITE)
    func groomerRequestForScheduleChange(groomersEmail : String, groomersFirebaseUID : String, groomersName : String, groomersRequestDateAsTimeStamp : Double, completion : @escaping (_ isComplete : Bool, _ responseMessage : String)->()) {
        
        let databaseRef = Database.database().reference()
        
        let ref = databaseRef.child("groomer_liberty_requests").child(groomersFirebaseUID).childByAutoId()
        
        let parentKey = ref.parent?.key ?? "no_parent_key"
        let refKey = ref.key ?? "no_uid_key"
        
        let values : [String : Any] = ["groomers_email" : groomersEmail, "groomers_uid" : groomersFirebaseUID, "groomers_full_name" : groomersName, "request_date" : groomersRequestDateAsTimeStamp, "is_request_approved" : false, "ref_key" : refKey, "parent_key" : parentKey, "has_request_been_satisfied" : false]
        
        ref.updateChildValues(values) { error, reference in
            
            if error != nil {
                let error = (error?.localizedDescription ?? "Error trying to send up the groomers request for liberty (time off)") as String
                completion(false, error)
                return
            }
            completion(true, "success")
        }
    }
    
    //INITIAL TWILIO PING TO RECEIVE A CODE
    func twilioPinRequest(phone : String, countryCode : String,  deliveryMethod : String, completion : @escaping ( _ isComplete : Bool)->()) {
        
        let unique_key = NSUUID().uuidString
        
        GrabDeviceID.getID { (isComplete, device_id) in
            
            let ref = Database.database().reference().child("verification_requests").child(unique_key)
            let values = ["unique_key" : unique_key, "users_phone_number" : phone, "users_country_code" : countryCode, "delivery_method" : deliveryMethod, "device_id" : device_id]
            
            ref.updateChildValues(values) { (error, ref) in
                
                if error != nil {
                    completion(false)
                    return
                }
                
                //ALL CLEAR AND SUCCESSFUL
                self.twilioPinRequestListener(listeningKey: unique_key, phone: phone, countryCode: countryCode) { allSuccess in
                    
                    if allSuccess {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
    
    func twilioPinRequestListener(listeningKey : String, phone : String, countryCode : String, completion : @escaping ( _ isComplete : Bool)->()) {
        
        var observingRefOne = Database.database().reference(),
            handleOne = DatabaseHandle()
        
        observingRefOne = Database.database().reference().child("verification_responses").child(listeningKey)
        
        handleOne = observingRefOne.observe(.value) { (snap : DataSnapshot) in
            
            if snap.exists() {
                
                guard let dic = snap.value as? [String : AnyObject] else {return}
                
                let status = dic["status"] as? String ?? ""
                
                switch status {
                
                case "error" :
                    
                    observingRefOne.removeObserver(withHandle: handleOne)
                    completion(false)
                    
                default : print("Default for pin request")
                    
                    observingRefOne.removeObserver(withHandle: handleOne)
                    completion(true)
                }
                
            } else if !snap.exists() {
                
                print("nothing yet here from the doggystyle linker")
                
            }
        }
    }
    
    //TWILIO - SEND RECEIVED PIN UP FOR APPROVAL
    func twilioPinApprovalRequest(phone : String, countryCode : String, enteredCode : String, completion : @escaping ( _ isComplete : Bool)->()) {
        
        let unique_key = NSUUID().uuidString
        let ref = Database.database().reference().child("pin_verification_requests").child(unique_key)
        let values = ["unique_key" : unique_key, "users_phone_number" : phone, "users_country_code" : countryCode, "entered_code" : enteredCode]
        
        ref.updateChildValues(values) { (error, ref) in
            
            if error != nil {
                completion(false)
                return
            }
            
            //ALL CLEAR
            self.twilioPinApprovalRequestListener(listeningKey: unique_key, phone: phone, countryCode: countryCode) { isComplete in
                if isComplete {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    //TWILIO - RECEIVE TWILIO PIN RESPONSE
    func twilioPinApprovalRequestListener(listeningKey : String, phone : String, countryCode : String, completion : @escaping ( _ isComplete : Bool)->()) {
        
        var observingRefOne = Database.database().reference(),
            handleOne = DatabaseHandle()
        
        observingRefOne = Database.database().reference().child("pin_verification_responses").child(listeningKey)
        
        handleOne = observingRefOne.observe(.value) { (snap : DataSnapshot) in
            
            if snap.exists() {
                
                guard let dic = snap.value as? [String : AnyObject] else {return}
                
                let status = dic["status"] as? String ?? ""
                
                switch status {
                
                case "error" : print("Error on the listening key")
                    observingRefOne.removeObserver(withHandle: handleOne)
                    completion(false)
                    
                case "expired" : print("Verification has expired")
                    observingRefOne.removeObserver(withHandle: handleOne)
                    completion(false)
                    
                case "failed" : print("Failed Verification")
                    observingRefOne.removeObserver(withHandle: handleOne)
                    completion(false)
                    
                case "canceled" : print("Canceled Verification")
                    observingRefOne.removeObserver(withHandle: handleOne)
                    completion(false)
                    
                case "approved" : print("Verification code has been approved")
                    observingRefOne.removeObserver(withHandle: handleOne)
                    completion(true)
                    
                default : print("Default for pin approval")
                    observingRefOne.removeObserver(withHandle: handleOne)
                    completion(false)
                }
                
            } else if !snap.exists() {
                print("Waiting for pin approval response...")
            }
        }
    }
}

