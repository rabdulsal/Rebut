//
//  RebuttalDetailViewController.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/26/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class RebuttalDetailViewController : UIViewController {
    @IBOutlet weak var rebuttleScrollView: UIScrollView!
    @IBOutlet weak var commentsTableView: UITableView!
    var rebuttalViewModel: RebuttalViewModel?
    var rebuttal: Rebuttal? // TODO: Will be fetched from previous VC
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        
        // Get Rebuttle from Realm.
        // Once retrieved set RebuttleViewModel
        // Fire makeScrollView method
    }
}

extension RebuttalDetailViewController : UITableViewDelegate {
    
}

extension RebuttalDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userComment = rebuttal?.userComments[section]
        return userComment?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let userComment = rebuttal?.userComments[section]
        let user = userComment?.user
        return user?.name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rebuttal?.userComments.count ?? 0
    }
}
