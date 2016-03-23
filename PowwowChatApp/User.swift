//
//  User.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import Firebase


var newAlert = SweetAlert()
struct User {
    
    // Hand Error
  
    enum Error: Int, ErrorType {
        case InvalidPassword 
        case InvalidUser
        case InvalidEmail
        case NetworkError
        case EmailTaken
        case TextFieldNotFound
        
    }
    
    enum PasswordError: ErrorType {
        case Empty
        case Short
    }

    // Stored properties
    
    var uid: String
    var email: String
    var key: String?
    let ref: Firebase?
   // var image: String
    
    init(uid: String, email: String, key: String?, ref: Firebase?) {
        self.uid = uid
        self.email = email
        self.key = key
        self.ref = ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "name": email,
            "uid": uid,
        ]
    }
    
  
}

extension User {
    
    // Initialize
    init(auth: FAuthData) {
        uid = auth.uid
        email = auth.providerData["email"] as! String
        ref = nil
        key = ""
    }
}

extension User {
    init(snapshot: FDataSnapshot) {
        self.key = snapshot.key
        self.email = snapshot.value["email"] as! String
        self.uid = snapshot.value["uid"] as! String
        ref = snapshot.ref
        
    }
}
