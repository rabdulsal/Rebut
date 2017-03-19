//
//  Source.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/16/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation

class Source {
    
    // Represents a piece of content a User can attach to their Rebut for reference purposes
    
    /*
     * Required:
     * - Rebut
     * - Title
     * - Hyperlink
     */
    private (set) var title: String
    private (set) var link: String

    init(title: String, link: String) {
        self.title = title
        self.link = link
    }
}
