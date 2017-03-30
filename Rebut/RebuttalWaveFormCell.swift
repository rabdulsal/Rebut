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
    func configureCell(with rebut: Rebut) {
        waveformView.audioURL = URL(fileURLWithPath: rebut.recordingFilePath)
        waveformView.progressSamples = waveformView.totalSamples / 2
    }
}
