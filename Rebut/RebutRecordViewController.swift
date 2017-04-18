//
//  RebutRecordViewController.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import UIKit
import FDWaveformView

protocol RecorderViewDelegate : class {
    func didFinishRecording(_ recording: Recording)
}

class RebutRecordViewController: UIViewController {
    
    /* --- Controller for managing recording Rebuts --- */
    @IBOutlet weak var recordingWaveformView: FDWaveformView!
    
    var recorderFactory: RecordingControllerFactory!
    // MARK: View Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recorderFactory = RecordingControllerFactory(viewController: self)
        recorderFactory.presentRecorder()
    }
    
}

extension RebutRecordViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: source)
    }
}

class HalfSizePresentationController : UIPresentationController {
    
    
    override var frameOfPresentedViewInContainerView: CGRect { return CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: containerView!.bounds.height/2) }
}

