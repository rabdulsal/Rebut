//
//  Source.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/16/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import RealmSwift

class Source : Object {
    
    // Represents a piece of content a User can attach to their Rebut for reference purposes
    
    /*
     * Required:
     * - Rebut
     * - Title
     * - Hyperlink
     */
    dynamic var title: String = ""
    dynamic var link: String = ""

//    init(title: String, link: String) {
//        self.title = title
//        self.link = link
//    }
}
