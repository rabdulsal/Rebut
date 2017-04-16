//
//  Comment.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import RealmSwift

class Comment : Object {
    
    // Represents a text-based reply to a Rebut consisting of a User recipient and text comment
    
    /*
     * Required:
     * - Commenter
     * - Recipient
     * - Rebut
     */
    dynamic var comment: String = ""
    dynamic var commenter: User?
    dynamic var recipient: User?
    dynamic var parentRebut: Rebut?
    
//    init(comment: String, commenter: User, recipient: User, rebut: Rebut) {
//        self.comment = comment
//        self.commenter = commenter
//        self.recipient = recipient
//        self.parentRebut = rebut
//    }
    
    func makeComment(comment: String, commenter: User, recipient: User, rebut: Rebut) {
        self.comment = comment
        self.commenter = commenter
        self.recipient = recipient
        self.parentRebut = rebut
    }
}
