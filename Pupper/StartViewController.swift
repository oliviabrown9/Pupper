//
//  ViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import UserNotifications

class StartViewController: UIViewController {
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.applicationIconBadgeNumber = 0
        getStartedButton.layer.cornerRadius = 28
        
        // For testing purposes, I set the time interval to 30 seconds. In reality, I would set it to 3 days.
        let requestTrigger = UNTimeIntervalNotificationTrigger(timeInterval: (30), repeats: false)
        
        let requestContent = UNMutableNotificationContent()
        requestContent.title = "🐶"
        requestContent.subtitle = "We miss you!"
        requestContent.body = "Come check out all the cute dogs!"
        requestContent.badge = 1
        requestContent.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "ComeBackToApp", content: requestContent, trigger: requestTrigger)
        UNUserNotificationCenter.current().add(request)
    }
}

