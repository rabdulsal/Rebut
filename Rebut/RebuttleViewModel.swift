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
    var recordingWaveFormViews = [RebutWaveFormView]()
    
    init(rebuts: [Rebut],scrollView: UIScrollView) {
        //self.rebuttal = rebuttal
        self.rebuts = rebuts
        self.rebuttalScrollView = scrollView
        self.recordingWaveFormViews = rebuts.map { $0.waveFormView }
        super.init()
        self.rebuttalScrollView.delegate = self
        self.makeWaveFormScrollView()
    }
}

// MARK: - UIScrollViewDelegate

extension RebuttalViewModel : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth:CGFloat = scrollView.frame.width
        let val:CGFloat = scrollView.contentOffset.x / pageWidth
        var newPage = NSInteger(val)
        
        if (velocity.x == 0)
        {
            newPage = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        } else {
            if(velocity.x < 0)
            {
                let diff:CGFloat = val - CGFloat(newPage)
                if(diff > 0.6){
                    newPage+=1
                }
            }
            newPage = velocity.x > 0 ? newPage + 1 : newPage - 1
            
            //Velocity adjustments.
            if velocity.x > 2.7 {
                newPage += 2
            } else if velocity.x > 2.2 {
                newPage+=1
            }
            if velocity.x < -2.7 {
                newPage -= 2
            } else if velocity.x < -2.2 {
                newPage-=1
            }
            
            if (newPage < 0){
                newPage = 0
            }
            if (newPage > NSInteger(scrollView.contentSize.width / pageWidth)){
                newPage = NSInteger(ceil(scrollView.contentSize.width / pageWidth) - 1.0)
            }
        }
        let scrollPoint = CGPoint(x:CGFloat(newPage) * pageWidth, y:0)
        rebuttalScrollView.setContentOffset(scrollPoint, animated: true)
    }
}

extension RebuttalViewModel : FDWaveformViewDelegate { }

// MARK: - Private

private extension RebuttalViewModel {
    func makeWaveFormScrollView() {
        for (index,waveFormView) in recordingWaveFormViews.enumerated() {
            let scrollOffset = CGFloat(Int(rebuttalScrollView.bounds.width)*index)
            let frame = CGRect(x: scrollOffset, y: rebuttalScrollView.bounds.origin.y, width: rebuttalScrollView.bounds.width, height: rebuttalScrollView.bounds.height)
            waveFormView.waveForm.delegate = self
            waveFormView.frame = frame
            waveFormView.layer.borderWidth = 2
            waveFormView.layer.borderColor = UIColor.black.cgColor
            rebuttalScrollView.addSubview(waveFormView)
            
        }
        let totalScrollWidth = CGFloat(Int(rebuttalScrollView.bounds.width)*rebuts.count)
        rebuttalScrollView.contentSize = CGSize(width: totalScrollWidth, height: rebuttalScrollView.bounds.height)
    }
    
    func currentPageNumber() -> Int {
        let pageWidth:CGFloat   = rebuttalScrollView.frame.width
        let currentPage:CGFloat = floor((rebuttalScrollView.contentOffset.x-pageWidth/2)/pageWidth)+2
        
        return Int(currentPage)
    }
    
    func resetContentOffset() {
        let scrollOffset     = currentPageNumber()
        let scrollerXPos:Int = Int(self.rebuttalScrollView.bounds.width) * scrollOffset
        let scrollPoint      = CGPoint(x:CGFloat(scrollerXPos), y:0)
        rebuttalScrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    func makePlayButton(for waveFormView:FDWaveformView) {
        let playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        playButton.setTitle("Play", for: .normal)
        playButton.center = waveFormView.center
        playButton.layer.cornerRadius = 2
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.black.cgColor
        playButton.addTarget(self, action: #selector(self.playButtonPressed), for: .touchUpInside)
        waveFormView.addSubview(playButton)
        waveFormView.setNeedsLayout()
    }
    
    @objc func playButtonPressed() {
        print("Play Button pressed!")
    }
}

protocol PlayButtonDelegate {
    func didPressPlayButton()
}

class RebutWaveFormView : UIView {
    
    var waveForm = FDWaveformView()
    var playButtonDelegate: PlayButtonDelegate?
    
    required public init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
    }
    
    override init(frame rect: CGRect) {
        super.init(frame: rect)
        self.waveForm.frame = frame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makePlayButton()
    }
    
    func makePlayButton() {
        let playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        playButton.setTitle("Play", for: .normal)
        playButton.tintColor = UIColor.black
        playButton.center = self.center
        playButton.layer.cornerRadius = 2
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.black.cgColor
        playButton.addTarget(self, action: #selector(self.playButtonPressed), for: .touchUpInside)
        self.addSubview(playButton)
    }
    
    @objc func playButtonPressed() {
        print("Play Button pressed!")
        self.playButtonDelegate?.didPressPlayButton()
    }
}
