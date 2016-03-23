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
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView?.tableHeaderView = searchController.searchBar
       
        
        // Add scope to searchBar
        searchController.searchBar.scopeButtonTitles = ["All", "Online", "Offline"]
        searchController.searchBar.delegate = self
        
    }
    
    
    // MARK: Helper func
    
    func filterUsersForSearch(searchText text: String, searchScope scope: String = "All") {
        
        filteredUsers = users.filter { user in
            
            let categoryMatch = (scope == "All") || (user.uid == scope)
            
            return categoryMatch && user.email.lowercaseString.containsString(text.lowercaseString)
            
        }
        
        tableView?.reloadData()
        
    }
    
    
}

// MARK: UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        // Filter
        filterUsersForSearch(searchText: searchController.searchBar.text!, searchScope: scope)
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        // Filter on scope
        filterUsersForSearch(searchText: searchBar.text!, searchScope: searchBar.scopeButtonTitles![selectedScope])
        
    }
}

extension SearchViewController: UIBarPositioningDelegate {
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
}
