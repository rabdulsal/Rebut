//
//  RebuttleDetailViewController.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/26/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RebuttleDetailViewController : UIViewController {
    @IBOutlet weak var rebuttleScrollView: UIScrollView!
    @IBOutlet weak var commentsTableView: UITableView!
    var rebuttleViewModel: RebuttalViewModel?
    var rebuttle: Rebuttal? // TODO: Will be fetched from previous VC
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Rebuttle from Realm.
        // Once retrieved set RebuttleViewModel
        // Fire makeScrollView method
    }
}
