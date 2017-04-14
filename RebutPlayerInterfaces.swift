//
//  RebutPlayerInterfaces.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 4/12/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation

/*
 * Notifies delegate it should take the appropriate action for indicated Rebut
 * Will usually execute DOWN the chain to the RebutPlayer
 */

protocol RebutPlayable {
    func shouldPlayRebut(rebut: Rebut, playDelegate: RebutPlayerDelegate)
    func shouldStopPlayingRebut()
}

protocol PlayButtonTogglable {
    var playButton: PlayButton { get }
}

extension PlayButtonTogglable {
    func togglePlayButtonSelected() {
        playButton.isSelected = !playButton.isSelected
    }
}

// Notifies the delegate it should take voting

protocol RebutVotable {
    func shouldUpVoteRebut(rebut: Rebut)
    func shouldDownVoteRebut(rebut: Rebut)
}

protocol RebutRespondable {
    func shouldReplyToRebut(rebut: Rebut)
    func shouldCommentOnRebut(rebut: Rebut)
}

protocol RebuttalFeedResponder : RebutPlayable, RebutRespondable { }
protocol RebutDetailResponder : RebutVotable, RebutRespondable { }

/*
 * Notifies delegate when RebutPlay has finished playing
 * Will execute UP from the RebutPlayer
 */

protocol RebutPlayerDelegate {
    func didFinishPlayingRebut(rebut: Rebut)
    func trackCurrentProgress(progress: Double)
}
