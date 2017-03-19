//
//  Comment.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation

struct Comment {
    
    // Represents a text-based reply to a Rebut consisting of a User recipient and text comment
    
    /*
     * Required:
     * - Commenter
     * - Recipient
     * - Rebut
     */
    private (set) var comment: String
    private (set) var commenter: User
    private (set) var recipient: User
    private (set) var parentRebut: Rebut
    
    init(comment: String, commenter: User, recipient: User, rebut: Rebut) {
        self.comment = comment
        self.commenter = commenter
        self.recipient = recipient
        self.parentRebut = rebut
    }
}
