//
//  GCD.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/16/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import Foundation

typealias update = () -> Void

/** Perform UI updates on main */
func performUIUpdatesOnMain(updates: update) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}