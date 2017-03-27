//
//  RebuttalModule.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/23/17.
//  Copyright © 2017 Rebuttal Inc. All rights reserved.
//

import Foundation
import RealmSwift

class RebuttalModule {
    
    // --- Manages creation of Posts, Rebuts, etc & updating of related Models
    
    var allRebuts: [Rebut]
    var post: Post?
    var responses: [Rebut]
    
    let realm = try! Realm()
    var allRealmRebuts: Results<Rebut> {
        get {
            return realm.objects(Rebut.self)
        }
    }
    
    init(post:Post?=nil, responses:[Rebut]=[Rebut](), rebuts:[Rebut]=[Rebut]()) {
        self.post = post
        self.responses = responses
        self.allRebuts = rebuts
        makeRebutsArrayFromResults()
    }
    
    func updateAllRebuts(with recordingFile: String) {
        // Mock User
        let user = User(value: ["name": "Gustav", "karma": 5])
        // New Rebut
        let newRebut = Rebut()
        newRebut.makeRebut(with: recordingFile, poster: user)
        
        // If no Post, make new Post
        if self.post == nil {
            let newPost = Post()
            newPost.makePost(with: "\(user.name)'s Parent Post", rebut: newRebut)
            self.post = newPost
        }
        self.allRebuts.append(newRebut)
    }
    
    func allRecordings() -> [String] {
        return allRebuts.map { $0.recordingFilePath }
    }
}

private extension RebuttalModule {
    func makeRebutsArrayFromResults() {
        for rebut in allRealmRebuts {
            allRebuts.append(rebut)
        }
    }
}
