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

class RebuttalWaveFormCell : UICollectionViewCell {
    
    @IBOutlet weak var waveformView: FDWaveformView!
    @IBOutlet weak var button: PlayButton!
    @IBOutlet weak var userName: UILabel! // Put userName in upper left corner
    @IBOutlet weak var respondButton: UIButton! // Pressing triggers Response creation
    @IBOutlet weak var likeButton: UIButton! // Pressing increment Likes
    
    var rebut: Rebut?
    var viewModelDelegate: RebutPlayable?
    
    // IBActions
    @IBAction func pressedPlay(_ sender: Any) {
        if playButton.isSelected {
            viewModelDelegate?.shouldStopPlayingRebut()
        } else {
            viewModelDelegate?.shouldPlayRebut(rebut: self.rebut!, playDelegate: self)
        }
        togglePlayButtonSelected()
    }
    
    @IBAction func pressedLike(_ sender: Any) {
        
    }
    
    @IBAction func pressedRebutCell(_ sender: Any) {
        // Push to DetailVC
    }
    
    
    func configureCell(with rebut: Rebut, delegate: RebutPlayable) {
        self.rebut = rebut
        self.viewModelDelegate = delegate
        waveformView.audioURL = URL(fileURLWithPath: rebut.recordingFilePath)
    }
}

extension RebuttalWaveFormCell : RebutPlayerDelegate {
    
    func trackCurrentProgress(progress: Double) {
        // Shade WaveFormView
        waveformView.progressSamples = Int(progress)
    }
    
    func didFinishPlayingRebut(rebut: Rebut) {
        togglePlayButtonSelected()
//        viewModelDelegate?.shouldStopPlayingRebut() Don't need to call this?
    }
}

extension RebuttalWaveFormCell : RebutAutoPlayDelegate {
    func shouldPressRebutPlayButton() {
        self.pressedPlay(self)
    }
}

extension RebuttalWaveFormCell : PlayButtonTogglable {
    var playButton: PlayButton { return self.button }
}

private extension RebuttalWaveFormCell {
    func playButtonOn() {
        //playButton.setTitle("Stop", for: .normal) // Eventually move to RebutPlayButton class
        togglePlayButtonSelected()
    }
    
    func playButtonOff() {
        //playButton.setTitle("Play", for: .normal) // Eventually move to RebutPlayButton class
        togglePlayButtonSelected()

    }
}
