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

class RebutPlayer {
    
    // --- Manages playing Rebuts, Rebuttles and auto-play through responses
    
    var player = AVAudioPlayer()
    
    func play(rebut: Rebut) {
        let url = NSURL.init(fileURLWithPath: rebut.recordingFilePath)
        self.play(url: url)
    }
}

private extension RebutPlayer {
    func play(url:NSURL) { // Eventually make private
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url as URL)
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
}
