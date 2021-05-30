//
//  SMSMessageExt.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//
//
//
//import Foundation
//import UIKit
//import Firebase
//import Alamofire
//
////sid : SKac385a8ad64d5ce84f0efdf91d18d76b
////secret: pzECFL976NEtYl3QhkLRnAVxZ1PMXPLU
//class SendSMSMessage : NSObject {
//    
//    static func send(toPhoneNumber : String, dynamicUrl: URL, stringMessage : String, completion : @escaping (_ success : String, _ error : Any?) -> ()) {
//        
//        let account_sid = "ACaa014cd54a034795ffbb29905c3c4bc9"
//        
//        let access_token = "f1567af86e8428bf5a36b4ae1020296b"
//        
//        let from_number = "+12056065550"
//        let to_number = "+18455581855"
//        
//        let url = "https://api.twilio.com/2010-04-01/Accounts/\(access_token)/Messages"
//        
//        let parameters : Parameters = ["To": to_number, "From" : from_number, "Body" : stringMessage]
//        
//        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
//            .authenticate(username: access_token, password: account_sid)
//            .response { response in
//                
//                if response.error != nil {
//                    
//                    completion("error", response.error)
//                    
//                } else {
//                    
//                    completion("success", nil)
//                    
//                }
//            }
//    }
//}
//
