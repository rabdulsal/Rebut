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

protocol ViewControllerResponder {
    func shouldCloseViewController()
}

class RecordControlsViewController : UIViewController {
    
    @IBOutlet weak var recordButton: UIButton! // Color: #8700FF
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var recordingWaveForm: FDWaveformView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var sourceField: UITextView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var waveformViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    var interfaceType: RebutType = .post
    var rebutModule = RebuttalModule.shared
    var recorderFactory: RecordingControllerFactory?
    var actionHandler: (()->())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recorderFactory = RecordingControllerFactory(viewController: self)
        recordingWaveForm.layer.borderWidth = 1
        recordingWaveForm.layer.borderColor = UIColor.lightGray.cgColor
        recordingWaveForm.delegate = self
        sourceField.layer.borderWidth = 1
        sourceField.layer.borderColor = UIColor.lightGray.cgColor
        sourceField.delegate = self
        titleField.delegate = self
        waveformViewHeight.constant = self.view.bounds.height/2
        
        // InterfaceType diffs
        self.setUIForInterfaceType()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if recordingWaveForm.audioURL == nil {
            recorderFactory?.presentRecorder()
        }
    }
    
    @IBAction func pressedRecord() {
        recorderFactory?.presentRecorder()
    }
    
    @IBAction func pressedPost() {
        actionHandler?()
    }
    
    @IBAction func pressedCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - IQAudioRecorderViewControllerDelegate

extension RecordControlsViewController : IQAudioRecorderViewControllerDelegate {
    func audioRecorderController(_ controller: IQAudioRecorderViewController, didFinishWithAudioAtPath filePath: String) {
        //allRebuts.insert(filePath, at: 0)
        self.toggleTabBar()
        print(filePath)
        rebutModule.updateAllRebuts(with: filePath)
        recordingWaveForm.audioURL = URL(fileURLWithPath: filePath)
        controller.dismiss(animated: true, completion: nil)
    }
    
    func audioRecorderControllerDidCancel(_ controller: IQAudioRecorderViewController) {
        self.toggleTabBar()
        controller.dismiss(animated: true, completion: nil)
    }
}

extension RecordControlsViewController : UITextFieldDelegate {
    
    // --- Delegate Methods to restrict character limit to 20?
}

extension RecordControlsViewController : UITextViewDelegate {
    
    // --- Delegate Methods to restrict character limit to 100?
}

// MARK: - FDWaveformViewDelegate

extension RecordControlsViewController: FDWaveformViewDelegate { }

private extension RecordControlsViewController { 
    
    func setUIForInterfaceType() {
        switch interfaceType {
        case .post:
            // Show titleView
            titleView.isHidden = false
            // Button title = "Post"
            postButton.setTitle("Post", for: .normal)
            // Hide Cancel button
            cancelButton.isEnabled = false
            cancelButton.tintColor = UIColor.clear
            self.navigationItem.title = "Post"
            // Set postButton actionHandler
            actionHandler = postActionHandler
            break
        case .rebut:
            // Hide titleView
            titleView.isHidden = true
            // Button title = "Reply"
            postButton.setTitle("Reply", for: .normal)
            // Show Cancel button
            cancelButton.isEnabled = true
            cancelButton.tintColor = UIColor.rebutCTAColor()
            self.navigationItem.title = "Reply"
            // Set actionHandler
            actionHandler = replyActionHandler
            break
        }
    }
    
    func postActionHandler() {
        // Make Post
        print("This is a POST")
    }
    
    func replyActionHandler() {
        // Make Rebut
        print("This is a REPLY")
    }
    
    func resetUI() {
        titleField.text = ""
        sourceField.text = ""
        interfaceType = .post
        setUIForInterfaceType()
    }
}
