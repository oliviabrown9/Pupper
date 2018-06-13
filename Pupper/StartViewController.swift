//
//  ViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import UserNotifications

class StartViewController: UIViewController {
    
    @IBOutlet private weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedButton.layer.cornerRadius = getStartedButton.bounds.size.height / 2
        pushNotifications()
        
        
    }
    
    private func pushNotifications() {
        
        let threeDaysInSeconds = 259200.0
        
        let requestTrigger = UNTimeIntervalNotificationTrigger(timeInterval: (threeDaysInSeconds), repeats: false)
        
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


extension UIViewController {
    func presentOkAlertWith(title: String, message: String, from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func popOkAlertWith(title: String, message: String, from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in _ = self.navigationController?.popViewController(animated: true) })
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

