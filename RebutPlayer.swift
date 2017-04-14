//
//  RebutPlayer.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/30/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class RebutPlayer : NSObject {
    
    // --- Manages playing Rebuts, Rebuttles and auto-play through responses
    
    var player: AVAudioPlayer {
        didSet {
            player.delegate = self
        }
    }
    var currentRebutPlaying: Rebut?
    var playerDelegate: RebutPlayerDelegate?
    
    init(url: URL) {
        self.player = try! AVAudioPlayer(contentsOf: url as URL)
    }
    
    func play(rebut: Rebut) {
        currentRebutPlaying = rebut
        self.play(url: NSURL.init(fileURLWithPath: rebut.recordingFilePath))
    }
    
    func stop() {
        player.stop()
    }
    
    func isPlaying() -> Bool {
        return player.isPlaying
    }
}

private extension RebutPlayer {
    func play(url:NSURL) {
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url as URL)
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
            startAudioTracking()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
    func startAudioTracking() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true) // Must figure out how to invalidate timer @ Stop
    }
    
    @objc func updateAudioProgressView() {
        playerDelegate?.trackCurrentProgress(progress:player.currentTime)
    }
}

extension RebutPlayer : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Audio finished!")
        // Place logic so that if Rebut has response, auto play that
        
        playerDelegate?.didFinishPlayingRebut(rebut: currentRebutPlaying!)
    }
}
