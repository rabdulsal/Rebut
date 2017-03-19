//
//  Value.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/18/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation

class Value {
    private (set) var value: Int = 0
    
    func increase() {
        value += 1
    }
    
    func decrease() {
        value -= 1
    }
    
    func update(points: Int) {
        value = points
    }
}

class Karma : Value { }

class Vote : Value { }

class Like : Value { }
