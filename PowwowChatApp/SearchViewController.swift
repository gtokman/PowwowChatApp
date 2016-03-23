//
//  SearchViewController.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/19/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView?
    
    // MARK: Constants
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: Properties
    
    var filteredUsers = [User]()
    var users = [User]()
    
    // MARK: View Life Cycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
         getGurrentUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        searchDesignProperties()
    }
    
    
    // MARK: Helper
    
    func getGurrentUser () {
        
        let usersRef = baseURL.childByAppendingPath("Users")
        
        usersRef.observeEventType( .ChildAdded, withBlock: { snapshot in
        
            print("The value is \(snapshot.value)")
            
           let user = User(uid: "", email: snapshot.value as! String, key: nil, ref: nil)
        
            self.users.append(user)
            print(self.users.count)
            self.tableView?.reloadData()
        
        })
        
        
    }
    
    // MARK: Table view data source
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active && searchController.searchBar.text != "" {
            
            return filteredUsers.count
            
        }
        
        return users.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        
        let user: User
        
        if searchController.active && searchController.searchBar.text != "" {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        
        cell.textLabel?.text = user.email
        cell.detailTextLabel?.text = user.uid
        
        return cell
        
    }
    
    // MARK: TableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedCell = indexPath.row
        
        dismissViewControllerAnimated(true, completion: {
        
            
            
        })
        
        
    }
    
    
    
    @IBAction func dismissViewButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }


}
