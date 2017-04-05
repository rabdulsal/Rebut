//
//  RebuttalCard.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 4/4/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit
import FDWaveformView

class RebuttalCard : UIView {
    
    @IBOutlet weak var rebutterProfilesCollectionView: UICollectionView!
    @IBOutlet weak var waveFormView: FDWaveformView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var upvoteButton: UIButton!
    @IBOutlet weak var downvoteButton: UIButton!
    @IBOutlet weak var totalUpvotesLabel: UILabel!
    @IBOutlet weak var totalDownvotesLabel: UILabel!
    var rebuttal: Rebuttal?
    
    override init(frame: CGRect, rebuttal: Rebuttal) {
        self.rebuttal = rebuttal
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - IBActions
    
    @IBAction func pressedUpvoteButton(_ sender: Any) {
        
    }
    
    @IBAction func pressedDownvoteButton(_ sender: Any) {
        
    }
}

private extension RebuttalCard {
    func setupView() {
        
    }
}
