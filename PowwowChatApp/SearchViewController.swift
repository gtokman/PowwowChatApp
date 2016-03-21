//
//  SearchViewController.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/19/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView?
    
    // MARK: Constants
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: Properties
    
    var filteredUsers = [User]()
    var users = [User]()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add scope to searchBar
        searchController.searchBar.scopeButtonTitles = ["All", "Online", "Offline"]
        searchController.searchBar.delegate = self
        
        
        // Sample users
        users = [
            
            User(uid: "Online", email: "g.tok138@gmail.com"),
            User(uid: "Offline", email: "tokman@gmail.com"),
            User(uid: "Online", email: "tester@gmail.com"),
            User(uid: "Offline", email: "sma@gmail.com"),
            User(uid: "Online", email: "hello@gmail.com")
        
        ]
        
        
        searchDesignProperties()
        // Do any additional setup after loading the view.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
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
    
    @IBAction func dismissViewButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }


}
