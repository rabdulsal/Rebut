//
//  RebutFeedViewController.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import UIKit
import Foundation

class RebutFeedViewController: UIViewController {
    
    /* --- Controller for viewing all Rebuts in your Feed --- */
    
    @IBOutlet weak var rebuttalFeedTableView: UITableView!
    
    let reuseIdentifier = "RebuttalCell"
    let detailVCIdentifier = "RebutDetailVC"
    var rebutModule = RebuttalModule.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rebuttalFeedTableView.delegate = self
        rebuttalFeedTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rebuttalFeedTableView.reloadData()
    }
    
    // MARK: - IBActions
    
    @IBAction func pressedPushToDetailButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: detailVCIdentifier) as! RebutDetailViewController
        detailVC.rebut = rebutModule.currentlyVisibleRebut!
//        present(detailVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension RebutFeedViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do nothing
        
    }
}

extension RebutFeedViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RebuttalTableViewCell
        cell.configureCell(with: rebutModule.allRebuts)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rebutModule.allRebuttals.count
    }
}
