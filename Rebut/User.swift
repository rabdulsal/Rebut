//
//  User.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/16/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation

class User {
    
    // Represents a base User object
    
    private (set) var name: String
    private (set) var karma: Karma = Karma()
    
    init(name: String) {
        self.name = name
    }
}
