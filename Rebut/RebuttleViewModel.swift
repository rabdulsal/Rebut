//
//  RebuttleViewModel.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/21/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit
import FDWaveformView

class RebuttleViewModel : NSObject {
    
    // --- Manages the updating of the RecordControlsVC scrollView
    
    var rebuttle: Rebuttle
    var allRecordings = [Recording]()
    var rebuttleScrollView: UIScrollView
    var recordingWaveFormViews = [FDWaveformView]()
    
    init(rebuttle: Rebuttle, scrollView: UIScrollView) {
        self.rebuttle = rebuttle
        self.rebuttleScrollView = scrollView
        super.init()
        self.makeWaveFormScrollView()
        // Set recordingWaveFormView delegate?
    }
    
    func makeWaveFormScrollView() {
        for rebut in rebuttle.rebuts { self.makeWaveFormView(with: rebut) }
        let totalScrollWidth = CGFloat(Int(rebuttleScrollView.bounds.width)*rebuttle.rebuts.count)
        rebuttleScrollView.contentSize = CGSize(width: totalScrollWidth, height: rebuttleScrollView.bounds.height)
    }
    
    func makeWaveFormView(with rebut: Rebut) {
        for (index,waveFormView) in recordingWaveFormViews.enumerated() {
            let scrollOffset = CGFloat(Int(rebuttleScrollView.bounds.width)*index)
            let frame = CGRect(x: scrollOffset, y: rebuttleScrollView.bounds.origin.y, width: rebuttleScrollView.bounds.width, height: rebuttleScrollView.bounds.height)
            waveFormView.delegate = self
            waveFormView.frame = frame
            waveFormView.audioURL = rebut.recording.url
            waveFormView.progressSamples = waveFormView.totalSamples / 2
            rebuttleScrollView.addSubview(waveFormView)
        }
    }
    
    func updateRebuttleViews(newRecording: Recording) {
        
    }
    
    func someFunc() {
        let rebut = rebuttle.rebuts
        let comments = rebuttle.rebuttleComments()
    }
    
}

extension RebuttleViewModel : FDWaveformViewDelegate {
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
