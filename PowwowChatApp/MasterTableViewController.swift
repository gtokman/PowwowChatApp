//
//  MasterTableViewController.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    // MARK: Outlets

    
    // MARK: TableViewController lifecycle
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "Hello"
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
