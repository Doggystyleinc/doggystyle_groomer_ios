//
//  UserProfileStruc.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//


import Foundation

//MARK: - USED FOR ONBOARDING ONLY
var groomerOnboardingStruct = GroomerOnboardingStruct()

//MARK: - USED FOR APPLICATION USE ONLY
var groomerUserStruct = GroomerUserStruct()

struct GroomerOnboardingStruct {
    
    //PERSONAL  DATA
    var groomers_phone_number : String?
    var groomers_area_code : String?
    var groomers_complete_phone_number : String?
    
    //LOCATION DATA
    var groomers_location_latitude : Double?
    var groomers_location_longitude : Double?
    
    //PERSONAL  DATA
    var groomers_first_name : String?
    var groomers_last_name : String?
    var groomers_email : String?
    var groomers_city : String?
    var groomers_city_place_id : String?
    var groomers_referral_code : String?
    
    //TERMS OF SERVICE
    var groomer_accepted_terms_of_service : Bool?
    var groomer_enable_notifications : Bool?
    
    // UNIQUE KEY
    var groomer_child_key : String?
    var groomers_password : String?
    
}

struct GroomerUserStruct {
    
    //PERSONAL  DATA
    var groomers_phone_number : String?
    var groomers_area_code : String?
    var groomers_complete_phone_number : String?
    var users_sign_up_date : Double?
    var groomer_child_key_from_playbook : String?
    var profile_image_url: String?
    var drivers_license_image_url : String?

    //LOCATION DATA
    var groomers_location_latitude : Double?
    var groomers_location_longitude : Double?
    
    //PERSONAL  DATA
    var groomers_first_name : String?
    var groomers_last_name : String?
    var groomers_email : String?
    var groomers_city : String?
    var groomers_city_place_id : String?
    var groomers_referral_code : String?
    
    //TERMS OF SERVICE
    var groomer_enable_notifications : Bool?
    var users_ref_key : String?
    
}
