//
//  SMSMessageExt.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.

import Foundation
import UIKit
import Firebase
import Alamofire

class SendSMSMessage : NSObject {
    
    static func send(toPhoneNumber : String, dynamicUrl: URL, stringMessage : String, completion : @escaping (_ success : String, _ error : Any?) -> ()) {
        
        let database = Database.database().reference()
        let ref = database.child("api_keys").child("twilio")
        
        ref.observeSingleEvent(of: .value) { snap in
            
            guard let JSON = snap.value as? [String : Any] else {
                completion("error", nil)
                return
            }
            
            let account_sid_grab = JSON["account_sid"] as? String ?? "nil"
            let auth_token_grab  = JSON["auth_token"] as? String ?? "nil"
            let from_number_grab  = JSON["from_number"] as? String ?? "nil"
            
            if account_sid_grab == "nil" || auth_token_grab == "nil" || from_number_grab == "nil" {
            completion("error", nil)
            return
            }
            
            let account_sid = account_sid_grab,
                access_token = auth_token_grab,
                from_number = from_number_grab,
                to_number = toPhoneNumber,
                url = "https://api.twilio.com/2010-04-01/Accounts/\(access_token)/Messages"
            
            let parameters : Parameters = ["To": to_number, "From" : from_number, "Body" : stringMessage]
            
            AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
                .authenticate(username: access_token, password: account_sid)
                .response { response in
                    
                    if response.error != nil {
                        
                        completion("error", response.error)
                        
                    } else {
                        
                        completion("success", nil)
                        
                }
            }
        }
    }
}

