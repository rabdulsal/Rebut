//
//  Response.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation

class Response: Rebut {
    
    // Represents a child-level Rebut that is in response to a Post. 
    
    /* 
     * Required:
     * - Rebutter
     * - Recipient
     * - Rebut
    */
    
    var rebutter: User
    var recipient: User
    var parentRebut: Rebut
    
    init(rebutter: User, recipient: User, rebut: Rebut, recording: Recording) {
        self.rebutter = rebutter
        self.recipient = recipient
        self.parentRebut = rebut
        super.init(recording: recording)
    }
}
