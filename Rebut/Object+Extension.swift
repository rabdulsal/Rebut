//
//  Object+Extension.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/25/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import RealmSwift

extension Object {
    
    func storeData() {
        writeToRealm(object: self)
    }
    
    func writeToRealm(object: Object) {
        //let realm = try! Realm()
        do {
            try realm?.write {
                realm?.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteFromRealm(object: Object) {
       // let realm = try! Realm()
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    /**
     * Updating Models will require having specific update methods for each Model in the following structure
    */
    
    func updateRealmData(updatedName: String, updatedKarma: Int) {
        let realm = try! Realm()
        
        // Mock 'Old' User data
        let user = User()
        user.name = "Rashad"
        user.karma = 10
        
        do {
            try realm.write {
                // Model-specific data must be updated w/in realm.write block
                user.name = updatedName
                user.karma = updatedKarma
            }
        } catch {
            print(error)
        }
    }
}
