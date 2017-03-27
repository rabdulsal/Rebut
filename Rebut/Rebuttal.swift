//
//  Rebuttal.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/20/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import RealmSwift

class Rebuttal : Object {
    
    // Object representing an array of Rebuts + plus all Votes & Comments
    
    let rebuts = List<Rebut>()
    dynamic var votes: Int = 0
    
//    init(rebuts: [Rebut], votes: Int = 0) {
//        self.rebuts = rebuts
//        self.votes.update(points: votes)
//    }
    
    func getAllRebutUsers() -> [User] {
        var rebutUsers = [User]()
//        for rebut in rebuts {
//            rebutUsers.append(rebut.poster)
//        }
        return rebutUsers
    }
    
    func rebuttalComments() -> [Comment] {
        var rebutComments = [Comment]()
//        for rebut in rebuts {
//            for comment in rebut.comments {
//                rebutComments.append(comment)
//            }
//        }
        return orderCommentsChronologically(comment: rebutComments)
    }
    
    func orderCommentsChronologically(comment: [Comment]) -> [Comment] {
        let comments = [Comment]()
        
        return comments
    }
}
