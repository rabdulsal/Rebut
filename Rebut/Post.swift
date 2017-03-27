//
//  Post.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import RealmSwift

class Post : Rebut {
    
    // Represents a top-level Rebut and primary content
    
    /*
     * Required:
     * - Audio
     * - Title
     */
    dynamic var title: String = ""
    dynamic var rebut: Rebut? = nil
    
//    init(title: String, recording: Recording, poster: User) {
//        self.title = title
//        super.init(recording: recording, poster: poster)
//    }
    
    func makePost(with title: String, rebut: Rebut) {
        self.title = title
        self.rebut = rebut
        //self.writeToRealm(object: self)
        do {
            try realm?.write {
                realm?.add(self)
            }
        } catch {
            print(error)
        }
    }
}
