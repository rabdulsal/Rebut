//
//  RebutDetailViewController.swift
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
    
    @IBOutlet weak var tableView: UITableView!
    
    var rebuttalViewModel: RebuttalViewModel?
    var rebuttal: Rebuttal! // TODO: Will be fetched from previous VC
    var rebutPlayerManager: RebutDetailPlayerManager!
    let rebutCellIdentifier = "rebutViewCell"
    let module = RebuttalModule.shared
    var rebut: Rebut!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register any Cell Nibs
        tableView.register(UINib.init(nibName: "RebutDetailCard", bundle: nil), forCellReuseIdentifier: rebutCellIdentifier)
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
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: rebutCellIdentifier, for: indexPath) as! RebutDetailCell
            cell.configureCell(with: self.rebut, delegate: self)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
    
        case 1: // Comments
            return self.rebut.allComments.count
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 300 : 50
    }
}

// MARK: - Delegate Extensions

extension RebutDetailViewController : RebutPlayerDelegate {
    func didFinishPlayingRebut(rebut: Rebut) {
        // Set new Rebut Datasource w/ RebutDetailPlayerManager
        tableView.reloadData()
    }
}
