//
//  CreateCommentViewController.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 4/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit

protocol CommentSubmittable {
    func didSubmitComment(comment: Comment)
    func didCancelComment()
}

class CreateCommentViewController : UIViewController {
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    var rebut: Rebut!
    var commentDelegate: CommentSubmittable?
    
    override func viewDidLoad() {
        commentTextView.delegate = self
        checkValidComment()
    }
    
    @IBAction func pressedSubmitButton(_ sender: Any) {
        // Show progress
        
        // Make Comment
        let commenter = User(value: ["name": "Gustav", "karma": 5])
        
        let comment = Comment()
        comment.makeComment(comment: commentTextView.text, commenter: commenter, recipient: self.rebut.poster!, rebut: self.rebut)
        // Fire protocol
        commentDelegate?.didSubmitComment(comment: comment)
        // Close VC
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedCancel(_ sender: Any) {
        commentDelegate?.didCancelComment()
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension CreateCommentViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if submitButton.isEnabled == false {
            checkValidComment()
        }
    }
}

private extension CreateCommentViewController {
    func commentIsValid() -> Bool {
        return commentTextView.text.isEmpty == false
    }
    
    func checkValidComment() {
        submitButton.isEnabled = commentIsValid()
    }
}
