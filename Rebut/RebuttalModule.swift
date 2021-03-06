////
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
    
    // Can't init is singleton
    private init() { }
    
    static let shared = RebuttalModule()
    
    var allRebuts = [Rebut]()
    var post: Post?
    var rebuttal: Rebuttal?
    var responses = [Rebut]()
    var allRebuttals = [Rebuttal]()
    var player: RebutPlayer? {
        didSet {
            player?.playerDelegate = self
        }
    }
    var rebutToPlay: Rebut?
    var currentlyVisibleRebut: Rebut?
    var playerDelegate: RebutPlayerDelegate?
    // Realm stuff
//    let realm = try! Realm()
//    var allRealmRebuts: Results<Rebut> {
//        get {
//            return realm.objects(Rebut.self)
//        }
//    }
    /*
    init(post:Post?=nil, responses:[Rebut]=[Rebut](), rebuts:[Rebut]=[Rebut]()) {
        self.post = post
        self.responses = responses
        self.allRebuts = rebuts
       // makeRebutsArrayFromResults()
    }
     */
    
    func play(rebut: Rebut) {
        // Will probably need to
//        player?.play(rebut: rebut)
        self.player = RebutPlayer(url: URL(fileURLWithPath: rebut.recordingFilePath))
        self.rebutToPlay = rebut
        self.togglePlayer()
    }
    
    func stop() {
        player?.stop()
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
            self.allRebuts.append(self.post!)
        } else {
            self.allRebuts.append(newRebut)
        }
        
        if self.rebuttal == nil {
            let rebuttal = Rebuttal()
            rebuttal.makeRebuttal(with: allRebuts)
            self.rebuttal = rebuttal
            self.allRebuttals.append(rebuttal)
        } else {
            self.rebuttal?.allRebuts = self.allRebuts
        }
    }
    
    func allRecordings() -> [String] {
        return allRebuts.map { $0.recordingFilePath }
    }
    
    func getPost() -> Post? {
        if let rebuts = rebuttal?.allRebuts {
            for rebut in rebuts {
                if rebut.rebutType == .post {
                    return rebut as? Post
                }
            }
        }
        return nil
    }
    
    func upVoteRebut(rebut: Rebut) {
        getRebut(rebut: rebut)?.upVotes+=1
    }
    
    func downVoteRebut(rebut: Rebut) {
        getRebut(rebut: rebut)?.dnVotes+=1
    }
}

extension RebuttalModule : RebutPlayerDelegate {
    func trackCurrentProgress(progress: Double) {
        playerDelegate?.trackCurrentProgress(progress: progress)
    }

    func didFinishPlayingRebut(rebut: Rebut) {
        playerDelegate?.didFinishPlayingRebut(rebut: rebut)
        // Include logic to recursively check if Rebut has a response, and continue auto-playing all responses until done
    }
}

private extension RebuttalModule {
    func togglePlayer() {
        (player?.isPlaying())! ? player?.stop() : player?.play(rebut: self.rebutToPlay!)
    }
    
    func getRebut(rebut: Rebut) -> Rebut? {
        if let rebuts = rebuttal?.allRebuts {
            return rebuts.filter { $0 == rebut }.first
        }
        return nil
    }
}
