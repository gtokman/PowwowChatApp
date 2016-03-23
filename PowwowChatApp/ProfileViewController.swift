//
//  ProfileViewController.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/19/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var profileImageView: UIImageView?
    @IBOutlet weak var profileEmailLabel: UILabel?
    var user: User?
    
    
    // MARK: Life Cyle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        displayUserEmail()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: Helper
    
    func displayUserEmail() {
        
        baseURL.childByAppendingPath("Users").observeEventType(.ChildAdded, withBlock: { snapshot in
        
           // Check email is users
            if baseURL.authData.uid == snapshot.key {
                
                print("Email is \(snapshot.value)")
                let email = snapshot.value
                self.profileEmailLabel?.text = email as? String
            }
        })
        
    }
    
    // MARK: Actions
    
    @IBAction func dismissViewAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func profileLogoutButton(sender: UIButton) {
        
        let alert = UIAlertController(title: "Please select", message: "Are you sure you want to log out?", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        
        let logoutAction = UIAlertAction(title: "Logout", style: .Default ) { action -> Void in
            print("Logout")
            self.performSegueWithIdentifier("logout", sender: nil)
        }
        
        alert.view.tintColor = UIColor.redColor()
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
}
