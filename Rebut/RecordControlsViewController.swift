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
    var allRecordingFiles: [String] {
        return rebutModule.allRecordings()
    }
    var recorderView: RebutRecordViewController!
    var player = AVAudioPlayer() // TODO: Eventually move to ViewModel
    var rebutModule = RebuttalModule.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let controller = IQAudioRecorderViewController()
        controller.delegate = self
        controller.title = "Recorder"
        controller.maximumRecordDuration = 10
        controller.allowCropping = false
        //    controller.barStyle = UIBarStyleDefault;
        //    controller.normalTintColor = [UIColor magentaColor];
        //    controller.highlightedTintColor = [UIColor orangeColor];
        self.presentBlurredAudioRecorderViewControllerAnimated(controller)
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
        
        let filePath = allRecordingFiles[indexPath.row]
        let url = NSURL.fileURL(withPath: filePath)
        
        recordingWaveForm.audioURL = url
        recordingWaveForm.progressSamples = self.recordingWaveForm.totalSamples / 2
        play(url: url as NSURL)
    }
}

extension RecordControlsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordControlsIdentifier", for: indexPath) as! RecordingTableViewCell

        let recording = allRecordingFiles[indexPath.row]
        cell.title.text = "\(recording)"
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRecordingFiles.count
    }
}

// MARK: - IQAudioRecorderViewControllerDelegate

extension RecordControlsViewController : IQAudioRecorderViewControllerDelegate {
    func audioRecorderController(_ controller: IQAudioRecorderViewController, didFinishWithAudioAtPath filePath: String) {
        //allRecordingFiles.insert(filePath, at: 0)
        print(filePath)
        rebutModule.updateAllRebuts(with: filePath)
        controller.dismiss(animated: true) { 
            self.recordingsTableView.reloadData()
        }
    }
    
    func audioRecorderControllerDidCancel(_ controller: IQAudioRecorderViewController) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - FDWaveformViewDelegate

extension RecordControlsViewController: FDWaveformViewDelegate { }

private extension RecordControlsViewController { // TODO: Eventually place in ViewModel
    
    func play(url:NSURL) {
        print("playing \(url)")
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url as URL)
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
}
