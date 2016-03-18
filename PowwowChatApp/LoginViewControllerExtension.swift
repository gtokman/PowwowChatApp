//
//  LoginViewControllerExtension.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

extension LoginViewController: UITextFieldDelegate {
    
    // MARK: Keyboard cycle
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().height {
            
            guard let bottomConstraint = bottomConstraint else {
                print("Could not find bottom constraint!")
                
                return
                
            }
            
            bottomConstraint.constant = keyboardSize
        }
        
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let bottomConstraintStart: CGFloat = 150
        
        guard let bottomConstraint = bottomConstraint else {
            print("Could not find bottom constraint!")
            
            return
            
        }
        
        bottomConstraint.constant = bottomConstraintStart
        
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Login in user
        userLogin()
        
        return true
    }
    
    
    /** Log user into Powwow */
    func userLogin() {
        
        userNameTextField?.resignFirstResponder()
        passwordTextField?.becomeFirstResponder()
        
        firebaseRef.authUser(userNameTextField?.text, password: passwordTextField?.text, withCompletionBlock: { (let error, let auth) in
            
            guard error == nil else {
                // handle errors
                do {
                    try userErrors(error)
                } catch User.Error.InvalidPassword {
                    self.newAlert.showAlert("Invalid password", subTitle: "Password does not match", style: .Error)
                } catch User.Error.InvalidEmail {
                    self.newAlert.showAlert("Invalid email", subTitle: "Please check the email and try again", style: .Error)
                } catch User.Error.NetworkError {
                    self.newAlert.showAlert("Network error", subTitle: "Please check your network connection", style: .Error)
                } catch {
                    self.newAlert.showAlert("Please try agian")
                }
                
                return
                
            }
            
            // Login user
            print("User logined in successfully \(auth.uid)")
            self.performSegueWithIdentifier("sendUserData", sender: auth)
            
        })
    }
    
    /** User login with facebook */
    func signInWithFacebook() {
        
        let facebookLogin = FBSDKLoginManager()
        print("Logging into Facebook")
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self, handler: { (let result, let error) in
            
            guard error == nil else {
                print("Error logging in to facebook: \(error)")
                do {
                    try userErrors(error)
                } catch {
                    print("Facebook failed with Error: \(error)")
                }
                return
                
            }
            
            print("User logging in with Facebook: \(result.description)")
            
            // Guard invalid token
            guard let accessToken = FBSDKAccessToken.currentAccessToken() else {
                print("access token is not found: user canceled login: \(result.description)")
                
                return
                
            }
            
            // Add to Firebase
            self.firebaseRef.authWithOAuthProvider("facebook", token: accessToken.tokenString, withCompletionBlock: { (let error, let auth) in
                
                guard error == nil else {
                    // Handle error
                    do {
                        try userErrors(error)
                    } catch {
                        print("Facebook OAuth failed Error: \(error)")
                    }
                    self.newAlert.showAlert("Error", subTitle: "Please try again, authentication failed", style: AlertStyle.Error)
                    
                    return
                }
                
                // User logged in
                self.performSegueWithIdentifier("sendUserData", sender: auth)
                
            })
            
        })
        
    }
   
}














