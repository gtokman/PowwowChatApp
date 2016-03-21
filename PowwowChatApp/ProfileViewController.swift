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
    let userFirebaseRef = Firebase(url: "https://powwowchat.firebaseio.com/online")
    
    
    // MARK: Life Cyle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func dismissViewAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
