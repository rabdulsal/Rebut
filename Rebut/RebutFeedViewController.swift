//
//  RebutFeedViewController.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import UIKit
import RealmSwift

class RebutFeedViewController: UIViewController {
    
    /* --- Controller for viewing all Rebuts in your Feed --- */
    
    @IBOutlet weak var rebuttalFeedTableView: UITableView!
    
    let reuseIdentifier = "RebuttalCell"
    let realm = try! Realm()
    var allRebuttals: Results<Rebut> {
        get {
            return realm.objects(Rebut.self)
        }
    }
    
    var allRebuts = [Rebut]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rebuttalFeedTableView.delegate = self
        rebuttalFeedTableView.dataSource = self
        makeRebutsArrayFromResults()
    }

    func makeRebutsArrayFromResults() {
        for rebut in allRebuttals {
            allRebuts.append(rebut)
        }
    }
}

extension RebutFeedViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Push to DetailVC
    }
}

extension RebutFeedViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RebuttalTableViewCell
        cell.configureCell(with: allRebuts)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRebuts.count
    }
}

