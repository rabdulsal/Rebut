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
    @IBOutlet weak var button: PlayButton!
    
    var rebutPlayerDelegate: RebutPlayable?
    var rebut: Rebut!
    
    func configureCell(with rebut: Rebut, delegate: RebutPlayable) {
        self.rebut = rebut
        rebutPlayerDelegate = delegate
        userNameLabel.text = rebut.poster?.name
        waveFormView.audioURL = URL(fileURLWithPath: rebut.recordingFilePath)
    }
    
    // MARK: - IBActions
    @IBAction func pressedPlay(_ sender: Any) {
        rebutPlayerDelegate?.shouldPlayRebut(rebut: self.rebut!, playDelegate: self)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        print("Pressed Like Button")
    }
    
    @IBAction func commentButtonPressed(_ sender: Any) {
        print("Pressed Comment Button")
    }
    
    @IBAction func replyButtonPressed(_ sender: Any) {
        print("Pressed Reply Button")
    }
    
    
    @IBAction func pressedUpVoteButton(_ sender: Any) {
        print("Pressed UpVote Button")
    }
    
    @IBAction func pressedDownVoteButton(_ sender: Any) {
        print("Pressed DownVote Button")
    }
}

// MARK: - Delegate Extensions
extension RebutDetailCell : PlayButtonTogglable {
    var playButton: PlayButton { return self.button }
}

extension RebutDetailCell : RebutPlayerDelegate {
    
    func trackCurrentProgress(progress: Double) {
        // Update WaveFormView
        waveFormView.progressSamples = Int(progress)
    }
    
    func didFinishPlayingRebut(rebut: Rebut) {
        togglePlayButtonSelected()
    }
}
