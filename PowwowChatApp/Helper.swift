//
//  Helper.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/16/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

/** Create alert */
func createAlertController(alertMessage message: String, alertTitle title: String, actionTitle actionTitl: String, resetPassword reset: Bool) -> UIAlertController  {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    
    // Alert design
    let subview = alert.view.subviews.first! as UIView
    let alertView = subview.subviews.first! as UIView
    alertView.backgroundColor = UIColor.whiteColor()
    alert.view.tintColor = UIColor.redColor()
    alertView.layer.cornerRadius = 0
    
    // Create alert action
    let saveAction = alertUserAction(actionTitle: actionTitl, alertController: alert, resetUserPassword: reset)
    
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

// TODO: Catch errors for textfields
/** Create sign up fields */
func createSignUpFields(signUpAlert alert: UIAlertController, resetPassword reset: Bool) throws -> (email: String?, password: String?) {
    
    /*Text fields*/
    guard let textField = alert.textFields else {
        print("")
        throw User.Error.TextFieldNotFound
    }
    
    guard let textField2 = alert.textFields else {
        print("")
        throw User.Error.TextFieldNotFound
    }
    
    // If reseting password
    if reset {
        
        let userEmail = textField.first?.text
        
        return (userEmail, nil)
        
    }
    
    let userEmail = textField.first?.text
    let userPassword =  textField2.last?.text
    
    guard userPassword?.characters.count > 0 && userPassword?.characters.count >= 5 else {
        print("Enter a password that is valid")
        
        print("")
        throw User.Error.InvalidPassword
        
    }
    
    print("good")
    
    return (userEmail, userPassword)
    
}

/** Add action to alert controller */
func alertUserAction(actionTitle title: String, alertController alert: UIAlertController, resetUserPassword reset: Bool) -> UIAlertAction {
    
    /*Save user action*/
    let action = UIAlertAction(title: title, style: .Default) { (action) in
        
        do {
            // Create user
            let userSignUp = try createSignUpFields(signUpAlert: alert, resetPassword: reset)
            
            if reset {
                // Reset password
                userForgotPassword(userEmail: userSignUp.email)
            } else {
                // Auth
                createUser(userEmail: userSignUp.email, userPassword: userSignUp.password)
            }
        } catch User.Error.TextFieldNotFound {
            print("Textfield is not found")
        } catch User.Error.InvalidPassword {
            newAlert.showAlert("Enter a valid password")
        } catch {
            print("Failed to reset/create user: \(error)")
        }
        
    }
    
    return action
    
}

/** Reset the users password */
func userForgotPassword(userEmail email: String?) {
    
    baseURL.resetPasswordForUser(email) { (error: NSError!) in
        guard error == nil else {
            do {
                try userErrors(error)
            } catch User.Error.InvalidEmail {
                newAlert.showAlert("Invalid email", subTitle: "Please chech the email and try again", style: .Error)
            } catch User.Error.InvalidUser {
                newAlert.showAlert("Invalid user", subTitle: "User does not exist", style: .Error)
            } catch {
                print("Error reseting the password: \(error)")
            }
            
            return
            
        }
        
        // Email Sent to user
        print("Reset email sent!")
        SweetAlert().showAlert("Success", subTitle: "Email sent successfully", style: AlertStyle.Success)
    }
}

/** Create Firebase user */
func createUser(userEmail email: String?, userPassword password: String?) {
    
    // Create the user
    baseURL.createUser(email, password: password) { (error, auth) in
        
        /*GUARD ERROR creating account*/
        guard error == nil else {
            
            do {
                try userErrors(error)
            } catch User.Error.InvalidPassword {
                newAlert.showAlert("Invalid password", subTitle: "Password does not match", style: .Error)
            } catch User.Error.InvalidEmail {
                newAlert.showAlert("Invalid email", subTitle: "Please check the email and try again", style: .Error)
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
        baseURL.authUser(email, password: password, withCompletionBlock: { (error, auth) in
            
            print("user added")
            newAlert.showAlert("Success", subTitle: "Account created", style: AlertStyle.Success)
            
        })
    }
}
