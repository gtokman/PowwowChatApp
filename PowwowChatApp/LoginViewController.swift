//
//  LoginViewController.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/12/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var userNameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    @IBOutlet weak var appDescriptionLabel: UILabel?
    @IBOutlet weak var constraint2: NSLayoutConstraint!
    
    // MARK: Constants
    
    var newAlert = SweetAlert()
    let firebaseRef = Firebase(url: "https://powwowchat.firebaseio.com")
    
    // MARK: LoginViewController Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adjust bottom constraint
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
        
        userNameTextField?.delegate = self
        passwordTextField?.delegate = self
        
    }
    
    // MARK: Actions
    
    @IBAction func forgotPasswordButton(sender: UIButton) {
        
        let alert = UIAlertController(title: "Reset Password", message: "Please enter your email address.", preferredStyle: .Alert)
        let subview = alert.view.subviews.first! as UIView
        let alertView = subview.subviews.first! as UIView
        alertView.backgroundColor = UIColor.whiteColor()
        alertView.layer.cornerRadius = 0
        alert.view.tintColor = UIColor.redColor()
        
        let sendEmail = UIAlertAction(title: "Send", style: .Default) { (let action) in
            
            let userEmail = alert.textFields![0]
            
            self.firebaseRef.resetPasswordForUser(userEmail.text, withCompletionBlock: { (error: NSError!) in
                
                if error == nil {
                    
                    // Success
                    print("Email sent to user!")
                    SweetAlert().showAlert("Success", subTitle: "Email sent successfully", style: AlertStyle.Success)
                    
                } else {
                    
                    // Handle error
                    switch error.code {
                    case -8:
                        print("Invalid User")
                        self.newAlert.showAlert("Invalid User", subTitle: "User does not exist", style: AlertStyle.Error)
                    case -5:
                        print("Invalid email")
                        self.newAlert.showAlert("Invalid Email", subTitle: "Email is not valid", style: AlertStyle.Error)
                    default:
                        self.newAlert.showAlert("Network Error", subTitle: "Please check your internet connection and try agian", style: AlertStyle.Error)
                    }
                    
                }
                
            })
            
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel) { (let action) in
            print("User canceled")
        }
        
        alert.addTextFieldWithConfigurationHandler { (let userEmail) in
            userEmail.placeholder = "Email"
        }
        
        alert.addAction(sendEmail)
        alert.addAction(cancelButton)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func signUpButton(sender: UIButton) {
        
        do {
            
       let alert = try createAlertController(alertMessage: "Sign up please", alertTitle: "Sign Up")
            presentViewController(alert, animated: true, completion: nil)
            
        } catch {
            print("faild with error: \(error)")
        }
       // presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func facebookButton(sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        print("Logging into Facebook")
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self, handler: { (let result, let error) in
            
            guard error == nil else {
                print("Error logging in to facebook: \(error)")
                return
            }
            
            print("User logging in with Facebook: \(result.description)")
            
            /*
                GUARD invalid access token
            */
            guard let accessToken = FBSDKAccessToken.currentAccessToken() else {
                print("access token is not found: user canceled login: \(result.description)")
                return
            }
            
            self.firebaseRef.authWithOAuthProvider("facebook", token: accessToken.tokenString, withCompletionBlock: { (let error, let auth) in
                
                // Check user is authenticated
                if let userAuthenticated = auth {
                    
                    print("User found: \(userAuthenticated.uid)")
                    self.newAlert.showAlert("Success", subTitle: "Logged in with Facebook", style: AlertStyle.Success)
                    self.performSegueWithIdentifier("sendUserData", sender: auth)
                    
                } else {
                    
                    print("Error authenticating the user: \(error.code)")
                    self.newAlert.showAlert("Error", subTitle: "Please try again, authentication failed", style: AlertStyle.Error)
                    
                }
                
            })
            
        })
        
    }
}


