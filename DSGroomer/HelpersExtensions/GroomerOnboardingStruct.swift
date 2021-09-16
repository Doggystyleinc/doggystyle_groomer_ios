//
//  UserProfileStruc.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//


import Foundation

var groomerOnboardingStruct = GroomerOnboardingStruct()

struct GroomerOnboardingStruct {
    
    //PERSONAL  DATA
    var groomers_phone_number : String? //DONE
    var groomers_area_code : String? //DONE
    var groomers_complete_phone_number : String? //DONE
    
    //LOCATION DATA
    var groomers_location_latitude : Double? //DONE
    var groomers_location_longitude : Double? //DONE
    
    //PERSONAL  DATA
    var groomers_first_name : String? //DONE
    var groomers_last_name : String? //DONE
    var groomers_email : String? //DONE
    var groomers_city : String? //DONE
    var groomers_referral_code : String? //DONE
    
    //TERMS OF SERVICE
    var groomer_accepted_terms_of_service : Bool? //DONE
    var groomer_enable_notifications : Bool? //DONE
    
    // UNIQUE KEY
    var groomer_child_key : String?
    var groomers_password : String?
    
}
