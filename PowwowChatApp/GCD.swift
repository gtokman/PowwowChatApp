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
