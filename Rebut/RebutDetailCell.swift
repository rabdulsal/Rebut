//
//  RebutDetailCell.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 4/10/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit

class RebutDetailCell : UITableViewCell {
    @IBOutlet weak var rebutDetailView: RebutDetailCard!
    var rebutPlayerDelegate: RebutPlayerDelegate?
    
    override func awakeFromNib() {
        self.rebutDetailView = Bundle.main.loadNibNamed("RebutDetailCard", owner: self, options: nil)?.first as! RebutDetailCard
        
        // TODO: Set rebutDetailView.playerDelegate = self
    }
}

// MARK: - Delegate Extensions

extension RebutDetailCell : RebutPlayerDelegate {
    func didFinishPlayingRebut(rebut: Rebut) {
        rebutPlayerDelegate?.didFinishPlayingRebut(rebut: rebut)
    }
}
