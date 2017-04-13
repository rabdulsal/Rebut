//
//  RebuttalViewModel.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/21/17.
//  Copyright © 2017 rebuttal Inc. All rights reserved.
//

import Foundation
import UIKit
import FDWaveformView

class RebuttalViewModel : NSObject {
    
    // --- Manages the updating of the RecordControlsVC scrollView
    
    //var rebuttal: Rebuttal Commented for now
    var rebuts: [Rebut]
    var allRecordings = [Recording]()
    
    init(rebuts: [Rebut],scrollView: UIScrollView) {
        //self.rebuttal = rebuttal
        self.rebuts = rebuts
        super.init()
    }
}

// MARK: - UIScrollViewDelegate

extension RebuttalViewModel : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    
    }    
}

extension RebuttalViewModel : FDWaveformViewDelegate { }

// MARK: - Private

protocol PlayButtonDelegate {
    func didPressPlayButton()
}
