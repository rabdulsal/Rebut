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
    
    var rebutResponderDelegate: RebutDetailResponder?
    var rebut: Rebut!
    
    func configureCell(with rebut: Rebut, delegate: RebutDetailResponder) {
        self.rebut = rebut
        rebutResponderDelegate = delegate
        userNameLabel.text = rebut.poster?.name
        waveFormView.audioURL = URL(fileURLWithPath: rebut.recordingFilePath)
        self.totalUpvotesLabel.text = "\(self.rebut.upVotes)"
        self.totalDownvotesLabel.text = "\(self.rebut.dnVotes)"
    }
    
    // MARK: - IBActions
    @IBAction func pressedPlay(_ sender: Any) {
        rebutResponderDelegate?.shouldPlayRebut(rebut: self.rebut!, playDelegate: self)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func commentButtonPressed(_ sender: Any) {
        // Present Comment entry view
        rebutResponderDelegate?.shouldCommentOnRebut(rebut: self.rebut)
    }
    
    @IBAction func replyButtonPressed(_ sender: Any) {
        // Launch RecordVC
        rebutResponderDelegate?.shouldReplyToRebut(rebut: self.rebut)
    }
    
    
    @IBAction func pressedUpVoteButton(_ sender: Any) {
        self.rebut.upVotes+=1
        self.totalUpvotesLabel.text = "\(self.rebut.upVotes)"
    }
    
    @IBAction func pressedDownVoteButton(_ sender: Any) {
        self.rebut.dnVotes+=1
        self.totalDownvotesLabel.text = "\(self.rebut.dnVotes)"
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
