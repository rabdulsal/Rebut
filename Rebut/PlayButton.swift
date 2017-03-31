//
//  PlayButton.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/31/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit

class PlayButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        backgroundColor = UIColor.rebutCTAColor()
    }
    
    override var isSelected: Bool {
        didSet {
            configButtonState()
        }
    }
    
    override public var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                
            }
        }
    }
}

private extension PlayButton {
    func configButtonState() {
        if isSelected {
            setTitle("Stop", for: .normal)
        } else {
            setTitle("Play", for: .normal)
        }
    }
}
