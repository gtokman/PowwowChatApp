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
 
    // MARK: Constants
    
    var newAlert = SweetAlert()
    let firebaseRef = Firebase(url: "https://powwowchat.firebaseio.com")
    
    // MARK: LoginViewController Lifecycle
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adjust bottom constraint
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        userNameTextField?.delegate = self
        passwordTextField?.delegate = self
        
    }
    
    // MARK: Actions
    
    @IBAction func forgotPasswordButton(sender: UIButton) {
        
        let alert = createAlertController(alertMessage: "Please enter your email", alertTitle: "Reset Password", actionTitle: "Send", resetPassword: true)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func signUpButton(sender: UIButton) {
        
        let alert =  createAlertController(alertMessage: "Sign up please", alertTitle: "Sign Up", actionTitle: "Sign up", resetPassword: false)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func facebookButton(sender: UIButton) {
        
       signInWithFacebook()
        
    }
    
}
