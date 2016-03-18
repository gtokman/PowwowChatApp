//
//  Helper.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/16/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

typealias CreatedUserCompletion = () -> Void

/** Create alert */
func createAlertController(alertMessage message: String, alertTitle title: String) -> UIAlertController  {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    
    // Alert design
    let subview = alert.view.subviews.first! as UIView
    let alertView = subview.subviews.first! as UIView
    alertView.backgroundColor = UIColor.whiteColor()
    alert.view.tintColor = UIColor.redColor()
    alertView.layer.cornerRadius = 0
    
    // Create alert action
    let saveAction = alertUserAction(actionTitle: "Sign up", alertController: alert)
    
    // Cancel
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

/** Handles user errors */
func userErrors(error: NSError!) throws -> String {
    
    switch error.code {
    case -6:
        print("Invalid password")
        throw User.Error.InvalidPassword
    case -5:
        print("Invalid email")
        throw User.Error.InvalidEmail
    case -8:
        print("Invalid User")
        throw User.Error.InvalidUser
    case -9:
        print("Email taken")
        throw User.Error.EmailTaken
    default:
        throw User.Error.NetworkError
    }
    
}

// TODO: Add errors for textfields
/** Create sign up fields */
func createSignUpFields(signUpAlert alert: UIAlertController) throws -> (email: String?, password: String?) {
    
    /*Text fields*/
    guard let textField = alert.textFields else {
        print("")
        throw User.Error.InvalidPassword
    }
    
    guard let textField2 = alert.textFields else {
        print("")
        throw User.Error.InvalidPassword
    }
    
    let userEmail = textField.first?.text
    let userPassword =  textField2.last?.text
    
    guard userPassword?.characters.count > 0 && userPassword?.characters.count >= 5 else {
        print("Enter a password that is valid")
        newAlert.showAlert("Enter a valid password")
        
        print("")
        throw User.Error.InvalidPassword
        
    }
    
    return (userEmail, userPassword)
    
}

/** Add action to alert controller */
func alertUserAction(actionTitle title: String, alertController alert: UIAlertController) -> UIAlertAction {
    
    /*Save user action*/
    let saveAction = UIAlertAction(title: title, style: .Default) { (action) in
        
        do {
            
            // Create user
            let userSignUp = try createSignUpFields(signUpAlert: alert)
            
            // Auth
            createUser(userEmail: userSignUp.email, userPassword: userSignUp.password)
        } catch {
            print(error)
        }
        
    }
    
    return saveAction
    
}

/** Create Firebase user */
func createUser(userEmail email: String?, userPassword password: String?) {
    
    // Create the user
    firebaseRef.createUser(email, password: password) { (error, auth) in
        
        /*GUARD ERROR creating account*/
        guard error == nil else {
            
            do {
                try userErrors(error)
            } catch User.Error.InvalidPassword {
                newAlert.showAlert("Invalid password", subTitle: "Password does not match", style: .Error)
            } catch User.Error.InvalidEmail {
                newAlert.showAlert("Invalid email", subTitle: "Please chech the email and try again", style: .Error)
            } catch User.Error.InvalidUser {
                newAlert.showAlert("Invalid user", subTitle: "User does not exist", style: .Error)
            } catch User.Error.EmailTaken {
                newAlert.showAlert("Email taken", subTitle: "Email is registered", style: .Error)
            } catch {
                newAlert.showAlert("Network error", subTitle: "Please check your network connection", style: .Error)
            }
            
            return
            
        }
        
        // Add user
        firebaseRef.authUser(email, password: password, withCompletionBlock: { (error, auth) in
            
            print("user added")
            newAlert.showAlert("Success", subTitle: "Account created", style: AlertStyle.Success)
            
        })
    }
}