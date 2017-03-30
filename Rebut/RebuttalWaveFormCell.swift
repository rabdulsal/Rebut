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
    @IBOutlet weak var playButton: UIButton!
    var rebut: Rebut?
    var playDelegate: PlayRebutDelegate?
    
    @IBAction func pressedPlay(_ sender: Any) {
        playDelegate?.shouldPlayRebut(rebut: self.rebut!)
    }
    
    func configureCell(with rebut: Rebut, delegate: PlayRebutDelegate) {
        self.rebut = rebut
        self.playDelegate = delegate
        waveformView.audioURL = URL(fileURLWithPath: rebut.recordingFilePath)
        waveformView.progressSamples = waveformView.totalSamples / 2
    }
}
