//
//  User.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import Firebase

let firebaseRef = Firebase(url: "https://powwowchat.firebaseio.com")
var newAlert = SweetAlert()
struct User {
    
    // Hand Error
  
    enum Error: Int, ErrorType {
        case InvalidPassword = -6
        case InvalidUser = -8
        case InvalidEmail = -5
        case NetworkError = -15
        case EmailTaken = -9
        
    }
    
    enum PasswordError: ErrorType {
        case Empty
        case Short
    }

    // Stored properties
    let uid: String
    let email: String
    
  
}

extension User {
    
    // Initialize
    init(auth: FAuthData) {
        uid = auth.uid
        email = auth.providerData["email"] as! String
    }
}

