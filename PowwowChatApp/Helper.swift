//
//  Helper.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/16/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

typealias CreatedUserCompletion = () -> Void

func createAlertController( alertMessage message: String, alertTitle title: String) throws -> UIAlertController  {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    
    /*Alert design*/
    let subview = alert.view.subviews.first! as UIView
    let alertView = subview.subviews.first! as UIView
    alertView.backgroundColor = UIColor.whiteColor()
    alert.view.tintColor = UIColor.redColor()
    alertView.layer.cornerRadius = 0
    
    
    /*Save user action*/
    let saveAction = UIAlertAction(title: title, style: .Default) { (action) in
        
        /*Text fields*/
        guard let textField = alert.textFields else {
            return
        }
        
        guard let textField2 = alert.textFields else {
            return
        }
        
        let userEmail = textField.first?.text
        let userPassword =  textField2.last?.text
        
        guard userPassword?.characters.count > 0 && userPassword?.characters.count >= 5 else {
            print("Enter a password that is valid")
            newAlert.showAlert("Enter a valid password")
            
            return
            
        }
        
        /*Create the user*/
        firebaseRef.createUser(userEmail, password: userPassword) { (error, auth) in
            
            /*GUARD ERROR creating account*/
            guard error == nil else {
                do {
                try userErrors(error)
                } catch {
                    print("asdffas\(error)")
                }
                
                return
                
            }
            
            /*Add user*/
            firebaseRef.authUser(userEmail, password: userPassword, withCompletionBlock: { (error, auth) in
                
                print("user added")
                newAlert.showAlert("Success", subTitle: "Account created", style: AlertStyle.Success)
                
            })
        }
    }
    
    /* Cancel */
    let cancelSignUp = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (let action) in
        print("Sign up canceled")
    })
    
    alert.addTextFieldWithConfigurationHandler { (userEmail) in
        userEmail.placeholder = "Email"
    }
    
    alert.addTextFieldWithConfigurationHandler { (userPassword) in
        userPassword.placeholder = "Password"
        userPassword.secureTextEntry = true
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelSignUp)
    
    return alert
}

func userErrors(error: NSError!) throws -> String {
   
    switch error.code {
    case User.Error.InvalidPassword.rawValue:
        print("Invalid password")
        newAlert.showAlert("Invalid password", subTitle: "Password does not match", style: .Error)
    case User.Error.InvalidUser.rawValue:
        print("Invalid User")
        newAlert.showAlert("Invalid user", subTitle: "User does not exist", style: .Error)
    case User.Error.InvalidEmail.rawValue:
        print("Invalid email")
        newAlert.showAlert("Invalid email", subTitle: "Please chech the email and try again", style: .Error)
    case User.Error.EmailTaken.rawValue:
        print("Email taken")
        newAlert.showAlert("Email taken", subTitle: "Email is registered", style: .Error)
    default:
        throw User.Error.NetworkError
    }
    
    return "\(error.code)"
    
}
