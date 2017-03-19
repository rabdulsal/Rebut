//
//  RecordControlsViewController.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/16/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit

class RecordControlsViewController : UIViewController {
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var recordingsTableView: UITableView!
    
    var allRecordings = [Recording]()
    var recorderView: RebutRecordViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingsTableView.delegate = self
        recordingsTableView.dataSource = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        recorderView = storyboard.instantiateViewController(withIdentifier: "RecorderViewController") as! RebutRecordViewController
        recorderView.delegate = self
        recorderView.createRecorder()
        //recorderView.view.backgroundColor = UIColor.green
        recorderView.modalTransitionStyle = .crossDissolve
        recorderView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }
    
    @IBAction func start() {
        self.present(recorderView, animated: true, completion: nil)
        recorderView.startRecording()
    }
    
    @IBAction func play() {
        do {
            try recorderView.recording.play()
        } catch {
            print(error)
        }
    }
}

// MARK: - RecorderViewDelegate

extension RecordControlsViewController : RecorderViewDelegate {
    internal func didFinishRecording(_ recording: Recording) {
        allRecordings.insert(recording, at: 0)
        print(recording.url)
        recordingsTableView.reloadData()
    }
}

// MARK: - TableViewDelegate & DataSource

extension RecordControlsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recording = allRecordings[indexPath.row]
        do {
            try recording.play()
        } catch {
            print(error)
        }
    }
}

extension RecordControlsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordControlsIdentifier", for: indexPath) as! RecordingTableViewCell

        let recording = allRecordings[indexPath.row]
        cell.title.text = "\(recording.url)"
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRecordings.count > 0 ? allRecordings.count : 0
    }
}
