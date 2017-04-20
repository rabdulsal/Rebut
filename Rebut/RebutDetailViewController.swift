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
import IQAudioRecorderController

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
    let commentCellIdentifier = "CommentCell"
    let module = RebuttalModule.shared
    var rebut: Rebut!
    var playerDelegate: RebutPlayerDelegate?
    
//    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register any Cell Nibs
        tableView.register(UINib.init(nibName: "RebutDetailCard", bundle: nil), forCellReuseIdentifier: rebutCellIdentifier)
        tableView.estimatedRowHeight = 72
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIdentifier, for: indexPath) as! CommentCell
            let comment = rebut.allComments[indexPath.row]
            cell.configureCell(username: comment.commenter!.name, comment: comment.comment)
            return cell
        }
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
        return indexPath.section == 0 ? 300 : UITableViewAutomaticDimension
    }
}

// MARK: - Delegate Extensions

extension RebutDetailViewController : IQAudioRecorderViewControllerDelegate {
    func audioRecorderController(_ controller: IQAudioRecorderViewController, didFinishWithAudioAtPath filePath: String) {
        self.toggleTabBar()
        // Initialize Rebut
        // Set Rebut as currentRebut's response
        // Mock User
        let user = User(value: ["name": "Johnny", "karma": 10])
        // New Rebut
        let newRebut = Rebut()
        newRebut.makeRebut(with: filePath, poster: user)
        rebut.allReplies.append(newRebut)
        module.updateAllRebuts(with: filePath)
        controller.dismiss(animated: true, completion: nil)
    }
    
    func audioRecorderControllerDidCancel(_ controller: IQAudioRecorderViewController) {
        controller.dismiss(animated: true, completion: nil)
        // Move to extension on UIViewController
        self.toggleTabBar()
    }
}

extension RebutDetailViewController : RebutPlayerDelegate {
    
    func trackCurrentProgress(progress: Double) {
        // Do nothing?
        playerDelegate?.trackCurrentProgress(progress: progress)
    }
    
    func didFinishPlayingRebut(rebut: Rebut) {
        // Set new Rebut Datasource w/ RebutDetailPlayerManager
        playerDelegate?.didFinishPlayingRebut(rebut: rebut)
        // Setup next Rebut to display
        tableView.reloadData()
    }
}

extension RebutDetailViewController : RebutDetailResponder {
    func shouldPlayRebut(rebut: Rebut, playDelegate: RebutPlayerDelegate) {
        self.playerDelegate = playDelegate
        module.playerDelegate = self
        module.play(rebut: rebut)
    }
    
    func shouldStopPlayingRebut() {
        module.player?.stop()
    }
    
    func shouldUpVoteRebut(rebut: Rebut) {
        //
    }
    
    func shouldDownVoteRebut(rebut: Rebut) {
        //
    }
    
    func shouldReplyToRebut(rebut: Rebut) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let recordControlsViewController = storyboard.instantiateViewController(withIdentifier: "RecordControlsViewController") as! RecordControlsViewController
        let navController = UINavigationController(rootViewController: recordControlsViewController)
        recordControlsViewController.interfaceType = .rebut
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func shouldCommentOnRebut(rebut: Rebut) {
        // Show CreateCommentViewController
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let commentVC = storyboard.instantiateViewController(withIdentifier: "CreateCommentViewController") as! CreateCommentViewController
        commentVC.rebut = rebut
        commentVC.commentDelegate = self
        let navController = UINavigationController(rootViewController: commentVC)
        self.navigationController?.present(navController, animated: true, completion: nil)
        toggleTabBar()
    }
}

extension RebutDetailViewController : CommentSubmittable {
    func didSubmitComment(comment: Comment) {
        // Update Comment & Reload tableView
        toggleTabBar()
        self.rebut.allComments.append(comment)
        tableView.reloadData()
    }
    
    func didCancelComment() {
        toggleTabBar()
    }
}
