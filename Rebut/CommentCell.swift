//
//  CommentCell.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 4/16/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit

class CommentCell : UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    func configureCell(username: String, comment: String) {
        self.username.text = username
        self.comment.text = comment
    }
}
