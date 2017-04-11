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

class RebutDetailViewController : UIViewController {
    
    /* --- TableView with Sections
     * 1. Rebut plays through
     * 2. Once Rebut finishes playing, new Rebut is loaded and tableView reloaded
     * 3. TableView will have multiple sections for RebutDetailView & Comments, etc
    */
    
    // Needs UIView which will load RebutDetailCard xib
    @IBOutlet weak var tableView: UITableView!
    
    var rebuttalViewModel: RebuttalViewModel?
    var rebuttal: Rebuttal! // TODO: Will be fetched from previous VC
    var rebutPlayerManager: RebutDetailPlayerManager!
    let identifier = "rebutViewCell"
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Load RebutDetailCard xib into UIView property
        // Get Rebuttle from Realm.
        // Once retrieved set RebuttleViewModel
        // Fire makeScrollView method
    }
}

extension RebutDetailViewController : UITableViewDelegate {
    
}

extension RebutDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RebutDetailCell
        cell.rebutPlayerDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
    
        case 1: // Comments
            let userComment = rebuttal?.userComments[section]
            return userComment?.comments.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Comments"
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // RebutDetailView + Comments
    }
}

// MARK: - Delegate Extensions

extension RebutDetailViewController : RebutPlayerDelegate {
    func didFinishPlayingRebut(rebut: Rebut) {
        // Set new Rebut Datasource w/ RebutDetailPlayerManager
        tableView.reloadData()
    }
}
// Will be reloading tableView at rebutDidFinishPlaying
