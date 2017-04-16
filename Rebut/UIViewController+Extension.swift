//
//  UIViewController+Extension.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 4/15/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import IQAudioRecorderController

extension UIViewController {
    func presentRecorder(audioViewController: IQAudioRecorderViewController) {
        self.presentBlurredAudioRecorderViewControllerAnimated(audioViewController)
        self.toggleTabBar()
    }
    
    func showTabBar() {
        tabBarController?.tabBar.isHidden = false
    }
    
    func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func toggleTabBar() {
        if let tab = tabBarController?.tabBar {
            if tab.isHidden == false {
                self.hideTabBar()
            } else {
                self.showTabBar()
            }
        }
    }
}
