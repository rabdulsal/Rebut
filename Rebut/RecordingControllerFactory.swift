//
//  RecordingControllerFactory.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 4/14/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import IQAudioRecorderController

protocol RecordingViewControllerDelegate : IQAudioRecorderViewControllerDelegate { }

class RecordingControllerFactory {
    
    var parentViewController: UIViewController
    
    init(viewController: UIViewController) {
        self.parentViewController = viewController
    }
    
    func presentRecorder() {
        let controller = IQAudioRecorderViewController()
        controller.delegate = self.parentViewController as? IQAudioRecorderViewControllerDelegate
        controller.title = "Recorder"
        controller.maximumRecordDuration = 10
        controller.allowCropping = false
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self.parentViewController as? UIViewControllerTransitioningDelegate
        //    controller.barStyle = UIBarStyleDefault;
        //    controller.normalTintColor = [UIColor magentaColor];
        //    controller.highlightedTintColor = [UIColor orangeColor];
        self.parentViewController.presentRecorder(audioViewController: controller)
    }
}
