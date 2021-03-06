//
//  GCD.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/16/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

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

extension UIColor {
    static func powwowRed() -> UIColor {
        return UIColor(red: 203.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0)
    }
}

extension UIColor {
    static func powwowBlue() -> UIColor {
        return UIColor(red: 165.0/255.0, green: 223.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    }
}

extension UIColor {
    static func powwowGreen() -> UIColor {
        return UIColor(red: 96.0/255.0, green: 197.0/255.0, blue: 186.0/255.0, alpha: 1.0)
    }
}