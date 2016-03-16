//
//  MasterTableViewController.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import Firebase

class MasterTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView?
    
    // MARK: Constants
    let firebaseRef = Firebase(url: "https://powwowchat.firebaseio.com")
    let userFirebaseRef = Firebase(url: "https://powwowchat.firebaseio.com/online")
    var user: User?
    
    // MARK: TableViewController lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        firebaseRef.observeAuthEventWithBlock { (let auth) in
            
            guard auth != nil else {
                print("User did not segue to table: \(auth.uid)")
                
                return
                
            }
            
            // Success
            print("user successfully logined in \(auth.uid)")
            self.user = User(auth: auth)
            
            // Monitor user online status
            let currentUserRef = self.userFirebaseRef.childByAppendingPath(self.user?.uid)
            currentUserRef.setValue(self.user?.email)
            currentUserRef.onDisconnectRemoveValue()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("userMessages", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = "Hello"
        
        return cell
        
    }
    
    // MARK: Actions

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
