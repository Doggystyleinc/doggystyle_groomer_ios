//
//  ErrorHandlingExtension.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 9/27/21.
//

//MARK: - USAGE EXAMPLE FOR WITH AND WITHOUT AUTHENTICATION

/*
 ErrorHandlingService.shared.handleErrorLogging(user_uid: "nil", error_message: "this is my error message", error_code: "this is my error code") { response, error in

     print(response)
     print(error)
 }
 ErrorHandlingService.shared.handleErrorLogging(user_uid: auth, error_message: "this is my error message", error_code: "this is my error code") { response, error in

     print(response)
     print(error)
 }
 */


import Foundation
import UIKit
import Firebase

class ErrorHandlingService : NSObject {
    
    static let shared = ErrorHandlingService()
    
    func handleErrorLogging(user_uid : String?, error_message : String, error_code : String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        
        //MARK: - USER HAS NO AUTH, MAKE THIS ERROR REPORTING GLOBAL
        if user_uid == "nil" {
            
            let error_message = error_message
            let error_code = error_code
            let error_groomers_full_name = "nil"
            let error_groomers_user_uid = "nil"
            let error_is_groomer = true
            let random_key = NSUUID().uuidString
            let path = "error_logging_global/\(random_key)"

            let parameters : [String : Any] = ["error_message": error_message, "error_code": error_code, "error_groomers_full_name" : error_groomers_full_name, "error_groomers_user_uid" : error_groomers_user_uid, "error_is_groomer" : error_is_groomer, "random_key" : random_key, "path" : path]

            let slug = "error_logging"
            
            let url = URL(string: "https://doggystyle-dev.herokuapp.com/\(slug)")!
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
    
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request, completionHandler: { data, response, error in

               guard error == nil else {
                   completion(nil, error)
                   return
               }

               guard let data = data else {
                   completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                   return
               }

               do {
                   guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                       completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                       return
                   }
                
                   completion(json, nil)
                
               } catch let error {
                   print(error.localizedDescription)
                   completion(nil, error)
               }
           })
                
            task.resume()
       
        //MARK: - USER HAS AUTH, MAKE THIS ERROR REPORTING PERSONAL
        } else {
            
            guard let userUID = user_uid else {return}
            
            let usersFirstName = groomerUserStruct.groomers_first_name ?? "nil"
            let usersLastName = groomerUserStruct.groomers_last_name ?? "nil"
            let groomersFullName = "\(usersFirstName) \(usersLastName)"
            
            let error_message = error_message
            let error_code = error_code
            let error_groomers_full_name = groomersFullName
            let error_groomers_user_uid = userUID
            let error_is_groomer = true
            let random_key = NSUUID().uuidString
            let path = "error_logging/\(userUID)/\(random_key)"
            
            let parameters : [String : Any] = ["error_message": error_message, "error_code": error_code, "error_groomers_full_name" : error_groomers_full_name, "error_groomers_user_uid" : error_groomers_user_uid, "error_is_groomer" : error_is_groomer, "random_key" : random_key, "path" : path]

            let slug = "error_logging"
            
            let url = URL(string: "https://doggystyle-dev.herokuapp.com/\(slug)")!
            
            let session = URLSession.shared
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
    
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request, completionHandler: { data, response, error in

               guard error == nil else {
                   completion(nil, error)
                   return
               }

               guard let data = data else {
                   completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                   return
               }

               do {
                   guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                       completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                       return
                   }
                   completion(json, nil)
               } catch let error {
                   print(error.localizedDescription)
                   completion(nil, error)
               }
           })
            
            task.resume()
            
        }
    }
}
