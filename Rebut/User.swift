//
//  User.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/16/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object {
    
    // Represents a base User object
    
    dynamic var name: String = ""
    dynamic var karma: Int = 0
//    dynamic var rebuttles = [Rebuttle]()
    let rebuttles = List<Rebuttle>()
    
//    init(name: String, karma: Int=0, rebuttles: [Rebuttle] = [Rebuttle]()) {
//        self.name = name
//        self.karma.update(points: karma)
//        self.rebuttles = rebuttles
//    }
    
    func storeUserWithData(name: String, karma: Int) {
        self.name = name
        self.karma = karma
        self.writeToRealm(object: self)
        
    }
}
