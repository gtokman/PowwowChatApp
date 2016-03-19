//
//  UserSearch.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/19/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

extension SearchViewController {
    
    func searchDesignProperties() {
        
       // searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView?.tableHeaderView = searchController.searchBar
        
    }
    
//    func filterContentForSearchText(searchText: String, scope: String = "A11") {
//        
//        filteredUsers = users.filter { user
//            
//        }
//        
//    }
    
    
    
}
