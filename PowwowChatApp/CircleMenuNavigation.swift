//
//  CircleMenuNavigation.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/18/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import CircleMenu

extension MasterTableViewController: CircleMenuDelegate {
    
    // MARK: Circle menu delegate
    
    func circleMenu(circleMenu: CircleMenu, willDisplay button: CircleMenuButton, atIndex: Int) {
        
        let profileButton  = UIImage(named: "Profile")
        let searchButton = UIImage(named: "Search")
        let  cancelButton = UIImage(named: "Cancel")
        
        buttons += [searchButton, cancelButton, profileButton]
        
        button.setImage(buttons[atIndex], forState: .Normal)
        
    }
    
    func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: CircleMenuButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
        
    }
    
    func circleMenu(circleMenu: CircleMenu, buttonDidSelected button: CircleMenuButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
        
        switch atIndex {
        case 0:
            print("Search button")
            
            guard let searchViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as? SearchViewController else {
                print("Error finding Search View Controller!")
                return
            }
            
            self.navigationController?.presentViewController(searchViewController, animated: true, completion: nil)
        case 1:
            print("Cancel button")
        default:
            print("profile button")
            
            guard let profileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as? ProfileViewController else {
                print("Error finding Profile view controller")
                return
            }
            
            self.navigationController?.presentViewController(profileViewController, animated: true) {
                
                
            }
        }
        
    }
    
}
