//
//  RecordViewController.swift
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

class RecordViewController: UIViewController {
    
    @IBOutlet weak var recordControlsViewController: RecordControlsViewController!
    var recorderFactory: RecordingControllerFactory!
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        recordControlsViewController = storyboard.instantiateViewController(withIdentifier: "RecordControlsViewController") as! RecordControlsViewController

//        performSegue(withIdentifier: "ShowRecordControlsViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowRecordControlsViewController") {
            
        }
    }
    
}

