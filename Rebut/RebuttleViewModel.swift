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
    var rebuttalScrollView: UIScrollView
    var recordingWaveFormViews = [FDWaveformView]()
    
    init(rebuts: [Rebut],scrollView: UIScrollView) {
        //self.rebuttal = rebuttal
        self.rebuts = rebuts
        self.rebuttalScrollView = scrollView
        super.init()
        self.makeWaveFormScrollView()
        // Set recordingWaveFormView delegate?
    }
    
    func makeWaveFormScrollView() {
        for rebut in rebuts { self.makeWaveFormView(with: rebut) }
        let totalScrollWidth = CGFloat(Int(rebuttalScrollView.bounds.width)*rebuts.count)
        rebuttalScrollView.contentSize = CGSize(width: totalScrollWidth, height: rebuttalScrollView.bounds.height)
    }
    
    func makeWaveFormView(with rebut: Rebut) {
        for (index,waveFormView) in recordingWaveFormViews.enumerated() {
            let scrollOffset = CGFloat(Int(rebuttalScrollView.bounds.width)*index)
            let frame = CGRect(x: scrollOffset, y: rebuttalScrollView.bounds.origin.y, width: rebuttalScrollView.bounds.width, height: rebuttalScrollView.bounds.height)
            waveFormView.delegate = self
            waveFormView.frame = frame
            waveFormView.audioURL = rebut.recording?.url
            waveFormView.progressSamples = waveFormView.totalSamples / 2
            rebuttalScrollView.addSubview(waveFormView)
        }
    }
    
    func updaterebuttalViews(newRecording: Recording) {
        
    }    
}

extension RebuttalViewModel : FDWaveformViewDelegate {
    func waveformViewWillRender(_ waveformView: FDWaveformView) {
       // self.startRendering = Date()
    }
    
    func waveformViewDidRender(_ waveformView: FDWaveformView) {
       // self.endRendering = Date()
        //NSLog("FDWaveformView rendering done, took %f seconds", self.endRendering.timeIntervalSince(self.startRendering))
       // UIView.animate(withDuration: 0.25, animations: {() -> Void in
     //       waveformView.alpha = 1.0
     //   })
    }
    
    func waveformViewWillLoad(_ waveformView: FDWaveformView) {
      //  self.startLoading = Date()
    }
    
    func waveformViewDidLoad(_ waveformView: FDWaveformView) {
       // self.endLoading = Date()
      //  NSLog("FDWaveformView loading done, took %f seconds", self.endLoading.timeIntervalSince(self.startLoading))
    }
}
