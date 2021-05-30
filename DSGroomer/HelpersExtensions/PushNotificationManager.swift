//
//  PushNotificationManager.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//
//
//import Foundation
//import UIKit
//import Firebase
//import Alamofire
//
//class PushNotificationManager : NSObject {
//    
//    static func sendPushNotification(body : String, user_uid : String, is_group : Bool, groupName : String, completion : @escaping (_ success : Any?, _ error : Any?) -> ()) {
//        
//        var titleGrab : String = ""
//        var bodyGrab : String = ""
//        
//        let databaseRef = Database.database().reference()
//        
//        guard let user_uid_fetch = Auth.auth().currentUser?.uid else {return}
//        
//        databaseRef.child("all_users").child(user_uid).observeSingleEvent(of: .value, with: { (snap : DataSnapshot) in
//            
//            guard let dic = snap.value as? [String : AnyObject] else {return}
//            
//            let pushToken = dic["push_token"] as? String ?? "nil"
//            
//            databaseRef.child("all_users").child(user_uid_fetch).observeSingleEvent(of: .value) { (snapName : DataSnapshot) in
//                
//                guard let dicTwo = snapName.value as? [String : AnyObject] else {return}
//                
//                let sendersName = dicTwo["users_name"] as? String ?? "Incognito"
//                
//                let token = pushToken
//                
//                if is_group == false {
//                    
//                    titleGrab = sendersName
//                    
//                    bodyGrab = body
//                    
//                } else {
//                    
//                    titleGrab = "\(sendersName) @ \(groupName)"
//                    
//                    bodyGrab = body
//                }
//                
//                let url = "https://fcm.googleapis.com/fcm/send"
//                
//                var secretKey = ""
//                
//                if EnvironemntModeHelper.isCurrentEnvironmentDebug() == true {
//                    
//                    secretKey = "key = AAAAqbyindo:APA91bGQ_VsY8ki4WyKM-tqaNBpzYi1_COroXBGntsUtHTLMZKTe9_kqmBEQfuLIDwqKr1yznKcHmzhHYMh2qkNMABjLXBmWFld8hdA0TZr4-hbLfZ--UR679oaj2t9PoUD1HXBdJtDg"
//                    
//                } else {
//                    
//                    secretKey = "key = AAAAqbyindo:APA91bGQ_VsY8ki4WyKM-tqaNBpzYi1_COroXBGntsUtHTLMZKTe9_kqmBEQfuLIDwqKr1yznKcHmzhHYMh2qkNMABjLXBmWFld8hdA0TZr4-hbLfZ--UR679oaj2t9PoUD1HXBdJtDg"
//                    
//                }
//                
//                let headers : HTTPHeaders = ["Content-Type" : "application/json",
//                                             "Authorization" : secretKey]
//                
//                let notificationsParameters: Parameters = [
//                    
//                    "to": token,
//                    "content-available":true,
//                    "priority":"high",
//                    "notification" : [
//                        "title" : titleGrab,
//                        "body" : bodyGrab,
//                    ],
//                    
//                ]
//                
//                AF.request(url, method: .post, parameters: notificationsParameters, encoding : JSONEncoding.default, headers: headers).responseJSON { response in
//                    
//                    switch response.result {
//                    
//                    case .success:
//                        
//                        let data = response.value
//                        print(data as Any)
//                        completion(data, nil)
//                        
//                    case .failure(let error):
//                        
//                        completion(nil, error)
//                        
//                    }
//                }
//                
//            }
//            
//        }) { (true) in
//            
//        }
//        
//    }
//    
//}
