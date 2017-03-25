//
//  RebuttleViewModel.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/21/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit

class RebuttleViewModel {
    
    var rebuttle: Rebuttle
    
    init(rebuttle: Rebuttle) {
        self.rebuttle = rebuttle
    }
    
    
    
    func someFunc() {
        let rebut = rebuttle.rebuts
        let comments = rebuttle.rebuttleComments()
    }
    
}
