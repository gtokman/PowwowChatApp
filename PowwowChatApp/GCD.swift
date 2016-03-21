//
//  GCD.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/16/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

typealias Update = () -> Void

/** Perform updates on Main */
func performUIUpdatesOnMain(updates: Update) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}

extension String {
    
    func truncate(length: Int) -> String {
        if self.characters.count > length {
            
            let shortenedString = self.substringToIndex(self.startIndex.advancedBy(length))
            
            return shortenedString
            
        } else {
            return self
        }
    }
}