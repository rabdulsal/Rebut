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
    private (set) var responses = [Response]()
    private (set) var comments = [Comment]()
    private (set) var sources = [Source]()
    private (set) var likes = Like()
    
    init(recording: Recording) {
        self.recording = recording
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
