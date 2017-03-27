//
//  Rebut.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import RealmSwift

class Rebut : Object {
    
    // Represents a base content object consisting of Audio
    
//    private (set) var recording: Recording TODO: Must store Recording as NSData object
    dynamic var recordingData: NSData = NSData()
    dynamic var poster: User?
    dynamic var likes: Int = 0
    let responses = List<Response>()
    let comments = List<Comment>()
    let sources = List<Source>()
    var recording: Recording?
    dynamic var recordingFilePath = ""
    
    override static func ignoredProperties() -> [String] {
        return ["recording"]
    }
    
    func makeDataWithPath(filePath: String) {
        let url = URL.init(fileURLWithPath: filePath)
        do {
            try recordingData = NSData.init(contentsOf: url)
        } catch {
            print(error)
        }
    }
    
    func updateRecording(with recording: Recording) {
        
    }
    
    func makeRebut(with recordingFile: String, poster: User, responses: [Response]?=nil, likes: Int=0) {
        //self.makeDataWithPath(filePath: recordingFile)
        self.poster = poster
        self.recordingFilePath = recordingFile
        //self.writeToRealm(object: self)
        do {
            try realm?.write {
                realm?.add(self)
            }
        } catch {
            print(error)
        }
    }
//    init(
//        recording: Recording,
//        poster: User,
//        responses: [Response] = [Response](),
//        comments: [Comment] = [Comment](),
//        sources: [Source] = [Source]())
//    {
//        self.recording = recording
//        self.responses = responses
//        self.comments = comments
//        self.sources = sources
//        self.poster = poster
//    }
    
    func addComment(comment: Comment) {
        do {
            try realm?.write {
                comments.append(comment)
            }
        } catch {
            print(error)
        }
    }
    
    func addResponse(response: Response) {
        do {
            try realm?.write {
                responses.append(response)
            }
        } catch {
            print(error)
        }
    }
    
    func addSources(source: Source) {
        do {
            try realm?.write {
                self.sources.append(source)
            }
        } catch {
            print(error)
        }
    }
    
    func incrLike() {
        do {
            try realm?.write {
                self.likes += 1
            }
        } catch {
            print(error)
        }
    }
    
    func decrLike() {
        do {
            try realm?.write {
                self.likes -= 1
            }
        } catch {
            print(error)
        }
    }
}
