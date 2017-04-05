//
//  CommentManager.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 4/4/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation

class CommentManager {
    
    // --- Class takes Rebuttal, parses Comments into array UserComments to help build out RebuttalVC Comments tableView sectioned by Username
    
    var userComments: [UserComment]?
    
    init(rebuttal: Rebuttal) {
        self.makeUserComments(rebuttal: rebuttal)
    }
    
    func makeUserComments(rebuttal: Rebuttal) {
        for rebut in rebuttal.allRebuts! {
            let user = rebut.poster!
            let comments = rebut.comments as! [Comment]
            let userComment = UserComment(user: user, comments: comments)
            self.userComments?.append(userComment)
        }
    }
}

class UserComment {
    var user: User
    var comments: [Comment]
    
    init(user: User, comments: [Comment]) {
        self.user = user
        self.comments = comments
    }
}
