//
//  MasterTableViewController.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Firebase
import CircleMenu

class MasterTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var circleMenuButton: CircleMenu?
    
    // Properties
    
    var user: User?
    var buttons = [UIImage?]()
    
    // MARK: TableViewController lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("the new user is")
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addUserToFirebase()
        circleMenuButton?.delegate = self
        
    }
    
    // MARK: Helper
    
    func addUserToFirebase() {
        
        baseURL.observeAuthEventWithBlock { (let authData) in
            
            guard authData != nil else {
                print("auth data is nil \(authData.description)")
                
                return
                
            }
            
            // Load model
            self.user = User(auth: authData)
            
            // Add email to Firebase
            let currentUserRef = baseURL.childByAppendingPath("Users")
            currentUserRef.childByAppendingPath(self.user?.uid).setValue(self.user?.email)
            
        }
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = "Group Powwow"
        cell.imageView?.image = UIImage(named: "Profile")
        cell.detailTextLabel?.text = "Public"
        
        
        return cell
        
    }
    
    // MARK: Actions
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "MessageViewController" {
            
            guard let messageViewController = segue.destinationViewController as? MessageViewController else {
                print("messageViewController failed")
                return
            }
            
            print(user?.email)
            messageViewController.senderId = baseURL.authData.uid
            messageViewController.senderDisplayName = ""
            
        }
    }
    
}
