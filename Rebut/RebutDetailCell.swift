//
//  RebutDetailCell.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 4/10/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit
import FDWaveformView

class RebutDetailCell : UITableViewCell {
    
    // Definitely needed
    @IBOutlet weak var waveFormView: FDWaveformView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var upvoteButton: UIButton!
    @IBOutlet weak var downvoteButton: UIButton!
    @IBOutlet weak var totalUpvotesLabel: UILabel!
    @IBOutlet weak var totalDownvotesLabel: UILabel!
    var rebutPlayerDelegate: RebutPlayerDelegate?
    var rebut: Rebut!
    
    func configureCell(with rebut: Rebut, delegate: RebutPlayerDelegate) {
        rebutPlayerDelegate = delegate
        waveFormView.audioURL = URL(fileURLWithPath: rebut.recordingFilePath)
        waveFormView.progressSamples = waveFormView.totalSamples / 2
    }
}

// MARK: - Delegate Extensions

extension RebutDetailCell : RebutPlayerDelegate {
    func didFinishPlayingRebut(rebut: Rebut) {
        rebutPlayerDelegate?.didFinishPlayingRebut(rebut: rebut)
    }
}
