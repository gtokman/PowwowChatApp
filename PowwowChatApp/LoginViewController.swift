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

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var userNameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    @IBOutlet weak var appDescriptionLabel: UILabel?
    
    // MARK: Constants
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
    }
    
    @IBAction func signUpButton(sender: UIButton) {
        
        let alert = UIAlertController(title: "Sign up", message: "Please enter a email and password.", preferredStyle: .Alert)
        
        let saveUserAction = UIAlertAction(title: "Sign up", style: .Default) { (let action) in
            
            // Create email and password fields
            let userEmail = alert.textFields![0]
            let userPassword = alert.textFields![1]
            
            self.firebaseRef.createUser(userEmail.text, password: userPassword.text) { (error: NSError!) in
                
                if error == nil {
                    
                    // Add user 
                    self.firebaseRef.authUser(userEmail.text, password: userPassword.text, withCompletionBlock: { (let error, let auth) in
                        print("User added!")
                    })
                }
            }
        }
        
        let cancelSignUp = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (let action) in
          print("Sign up canceled")
        })
        
        alert.addTextFieldWithConfigurationHandler { (userEmail) in
            userEmail.placeholder = "Email"
        }
        
        alert.addTextFieldWithConfigurationHandler { (userPassword) in
            userPassword.placeholder = "Password"
        }
        
        alert.addAction(saveUserAction)
        alert.addAction(cancelSignUp)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func facebookButton(sender: UIButton) {
    }
}

