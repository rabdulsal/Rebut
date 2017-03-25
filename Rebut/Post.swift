//
//  Post.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation

class Post : Rebut {
    
    // Represents a top-level Rebut and primary content
    
    /*
     * Required:
     * - Audio
     * - Title
     */
    var title: String
    
    init(title: String, recording: Recording, poster: User) {
        self.title = title
        super.init(recording: recording, poster: poster)
    }
}
