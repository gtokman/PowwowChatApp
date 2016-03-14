//
//  User.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation
import Firebase

struct User {
    // Stored properties
    let uid: String
    let email: String
    
    // Instance methods
}

extension User {
    
    // Initialize
    init(auth: FAuthData) {
        uid = auth.uid
        email = auth.providerData["email"] as! String
    }
}