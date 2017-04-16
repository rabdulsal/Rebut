//
//  RecordControlsViewController.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/16/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit
import IQAudioRecorderController
import FDWaveformView


class RecordControlsViewController : UIViewController {
    
    @IBOutlet weak var startBtn: UIButton! // Color: #8700FF
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var recordingsTableView: UITableView!
    @IBOutlet weak var recordingWaveForm: FDWaveformView!
    
    var allRecordings = [Recording]()
    var allRebuts: [Rebut] {
        return rebutModule.allRebuts
    }
    var recorderView: RebutRecordViewController!
    var rebutModule = RebuttalModule.shared
    var recorderFactory: RecordingControllerFactory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recorderFactory = RecordingControllerFactory(viewController: self)
        recordingsTableView.delegate = self
        recordingsTableView.dataSource = self
        recordingWaveForm.delegate = self
        
        // Make RecorderView
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        recorderView = storyboard.instantiateViewController(withIdentifier: "RecorderViewController") as! RebutRecordViewController
        recorderView.delegate = self
        recorderView.createRecorder()
        //recorderView.view.backgroundColor = UIColor.green
        recorderView.modalTransitionStyle = .crossDissolve
        recorderView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
    }
    
    @IBAction func start() {
        recorderFactory?.presentRecorder()
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
        
        let rebut = allRebuts[indexPath.row]
        rebutModule.play(rebut: rebut)
    }
}

extension RecordControlsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordControlsIdentifier", for: indexPath) as! RecordingTableViewCell

        let rebut = allRebuts[indexPath.row]
        cell.title.text = "\(rebut.recordingFilePath)"
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRebuts.count
    }
}

// MARK: - IQAudioRecorderViewControllerDelegate

extension RecordControlsViewController : IQAudioRecorderViewControllerDelegate {
    func audioRecorderController(_ controller: IQAudioRecorderViewController, didFinishWithAudioAtPath filePath: String) {
        //allRebuts.insert(filePath, at: 0)
        self.toggleTabBar()
        print(filePath)
        rebutModule.updateAllRebuts(with: filePath)
        controller.dismiss(animated: true) { 
            self.recordingsTableView.reloadData()
            
            // TODO: In actual implementation will dismiss to a PostViewController
        }
    }
    
    func audioRecorderControllerDidCancel(_ controller: IQAudioRecorderViewController) {
        self.toggleTabBar()
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - FDWaveformViewDelegate

extension RecordControlsViewController: FDWaveformViewDelegate { }

private extension RecordControlsViewController { // TODO: Eventually place in ViewModel
}
