//
//  RebuttalWaveFormCell.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/29/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit
import FDWaveformView

protocol RebutViewModelDelegate {
    func shouldPlayRebut(rebut: Rebut, playDelegate: RebutPlayerDelegate)
    func rebutIsPlaying() -> Bool
    func shouldStopPlayingRebut()
    func shouldRespondToRebut(rebut: Rebut)
    func shouldLikeRebut(rebut: Rebut)
}

class RebuttalWaveFormCell : UICollectionViewCell {
    
    @IBOutlet weak var waveformView: FDWaveformView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var userName: UILabel! // Put userName in upper left corner
    @IBOutlet weak var respondButton: UIButton! // Pressing triggers Response creation
    @IBOutlet weak var likeButton: UIButton! // Pressing increment Likes
    
    var rebut: Rebut?
    var viewModelDelegate: RebutViewModelDelegate?
    
    // IBActions
    @IBAction func pressedPlay(_ sender: Any) {
        if playButton.isSelected {
            playButtonOff()
            viewModelDelegate?.shouldStopPlayingRebut()
        } else {
            playButtonOn()
            viewModelDelegate?.shouldPlayRebut(rebut: self.rebut!, playDelegate: self)
        }
    }
    
    @IBAction func pressedRespond(_ sender: Any) {
        viewModelDelegate?.shouldRespondToRebut(rebut: self.rebut!)
    }
    
    @IBAction func pressedLike(_ sender: Any) {
        viewModelDelegate?.shouldLikeRebut(rebut: self.rebut!)
    }
    
    func configureCell(with rebut: Rebut, delegate: RebutViewModelDelegate) {
        self.rebut = rebut
        self.viewModelDelegate = delegate
        waveformView.audioURL = URL(fileURLWithPath: rebut.recordingFilePath)
        waveformView.progressSamples = waveformView.totalSamples / 2
    }
}

extension RebuttalWaveFormCell : RebutPlayerDelegate {
    func didFinishPlayingRebut(rebut: Rebut) {
        playButtonOff()
//        viewModelDelegate?.shouldStopPlayingRebut() Don't need to call this?
    }
}

private extension RebuttalWaveFormCell {
    func playButtonOn() {
        playButton.setTitle("Stop", for: .normal) // Eventually move to RebutPlayButton class
        togglePlayButtonSelected()
    }
    
    func playButtonOff() {
        playButton.setTitle("Play", for: .normal) // Eventually move to RebutPlayButton class
        togglePlayButtonSelected()

    }
    
    func togglePlayButtonSelected() {
        playButton.isSelected = !playButton.isSelected
    }
}
