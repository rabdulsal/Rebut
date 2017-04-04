//
//  PostViewController.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 4/3/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import FDWaveformView

class PostViewController : UIViewController {
    
    // --- ViewController for finishing completion of a Post
    
    @IBOutlet weak var waveFormView: FDWaveformView!
    @IBOutlet weak var textView: UITextView!
    var rebutFilePath: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Immediately open IAQAudioRecorderVC?
    }
    
    // MARK: Actions
    @IBAction func pressedPostButton(_ sender: Any) {
        
        // Create Post
        let user = User(value: ["name": "Gustav", "karma": 5])
        let rebut = Rebut()
        rebut.makeRebut(with: self.rebutFilePath, poster: user)
        let post = Post()
        let title = textView.text
        post.makePost(with: title!, rebut: rebut)
        
        // Reset View
        
        // Close to FeedViewController
    }
    
    @IBAction func pressedCancelButton(_ sender: Any) {
        // Reset View
        
        // Close to RecordViewController
    }
    
}

extension PostViewController : UITextViewDelegate {
    
}

private extension PostViewController {
    func resetView() {
        textView.text = ""
        rebutFilePath = ""
    }
}
