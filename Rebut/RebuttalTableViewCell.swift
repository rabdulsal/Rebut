//
//  RebuttalTableViewCell.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/27/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit

class RebuttalTableViewCell : UITableViewCell {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    var viewModel: RebuttalViewModel!
    
    func configureCell(with rebuts: [Rebut]) {
        viewModel = RebuttalViewModel(rebuts: rebuts, scrollView: scrollView)
        let post = rebuts.first as! Post
        self.titleLabel.text = post.title
    }
}
