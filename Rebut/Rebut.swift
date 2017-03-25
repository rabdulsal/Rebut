//
//  Rebut.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation

class Rebut {
    
    // Represents a base content object consisting of Audio
    
    private (set) var recording: Recording
    private (set) var poster: User
    private (set) var responses = [Response]()
    private (set) var comments = [Comment]()
    private (set) var sources = [Source]()
    private (set) var likes = Like()
    
    init(
        recording: Recording,
        poster: User,
        responses: [Response] = [Response](),
        comments: [Comment] = [Comment](),
        sources: [Source] = [Source]())
    {
        self.recording = recording
        self.responses = responses
        self.comments = comments
        self.sources = sources
        self.poster = poster
    }
    
    func addComment(comment: Comment) {
        comments.append(comment)
    }
    
    func addResponse(response: Response) {
        responses.append(response)
    }
    
    func addSources(sources: [Source]) {
        for source in sources {
            self.sources.append(source)
        }
    }
}
