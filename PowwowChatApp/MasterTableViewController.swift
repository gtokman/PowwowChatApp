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
    
    // MARK: Constants
    let firebaseRef = Firebase(url: "https://powwowchat.firebaseio.com")
    
    
    var user: User?
    var buttons = [UIImage?]()
  
    
    // MARK: TableViewController lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        firebaseRef.observeAuthEventWithBlock { (let auth) in
//            
//            guard auth != nil else {
//                print("User did not segue to table: \(auth.uid)")
//                
//                return
//                
//            }
//        
//            // Success
//            print("user successfully logined in \(auth.uid)")
//            self.user = User(auth: auth)
//            
//            // Monitor user online status
//            let currentUserRef = self.firebaseRef.childByAppendingPath(self.user?.uid)
//            currentUserRef.setValue(self.user?.email)
//            print(self.user?.email)
//           // currentUserRef.onDisconnectRemoveValue()
//            
//        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("USER: \(userFirebaseRef.authData.uid)")
        circleMenuButton?.delegate = self
        
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
        cell.textLabel?.text = "Powwow"
        cell.imageView?.image = UIImage(named: "Profile")
        cell.detailTextLabel?.text = "Public chat room"
        
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
        messageViewController.senderId = firebaseRef.authData.uid
        messageViewController.senderDisplayName = ""
    
        }
    }
    
}
