//
//  UserProfileStruc.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//


import Foundation

var userProfileStruct = UserProfileStruct()

struct UserProfileStruct {
    
    var userProfileImageURL : String?
    var usersName : String?
    var usersEmail : String?
    var usersPushToken : String?
    var usersFirebaseUID : String?
    var is_groomer : Bool?
    var groomers_full_name : String?
}
