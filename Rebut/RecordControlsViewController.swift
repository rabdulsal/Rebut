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
    @IBOutlet weak var closeButton: UIButton!
    
    var interfaceType: RebutType = .post
    var rebutModule = RebuttalModule.shared
    var recorderFactory: RecordingControllerFactory?
    var actionHandler: (()->())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recorderFactory = RecordingControllerFactory(viewController: self)
        recordingWaveForm.layer.borderWidth = 2
        recordingWaveForm.layer.borderColor = UIColor.gray.cgColor
        recordingWaveForm.delegate = self
        sourceField.layer.borderWidth = 2
        sourceField.layer.borderColor = UIColor.gray.cgColor
        sourceField.delegate = self
        titleField.delegate = self
        titleView.isHidden = true
        
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
    
    @IBAction func pressedClose(_ sender: Any) {
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

private extension RecordControlsViewController { // TODO: Eventually place in ViewModel
    
    func setUIForInterfaceType() {
        switch interfaceType {
        case .post:
            // Show titleView
            titleView.isHidden = false
            // Button title = "Post"
            postButton.titleLabel?.text = "Post"
            // Hide Cancel button
            closeButton.isHidden = false
            // Set postButton actionHandler
            actionHandler = postActionHandler
            break
        case .rebut:
            // Hide titleView
            titleView.isHidden = true
            // Button title = "Reply"
            postButton.titleLabel?.text = "Reply"
            // Show Cancel button
            closeButton.isHidden = true
            // Set actionHandler
            actionHandler = replyActionHandler
            break
        }
    }
    
    func postActionHandler() {
        // Make Post
    }
    
    func replyActionHandler() {
        // Make Rebut
    }
    
    func resetUI() {
        titleField.text = ""
        sourceField.text = ""
        interfaceType = .post
        setUIForInterfaceType()
    }
}
