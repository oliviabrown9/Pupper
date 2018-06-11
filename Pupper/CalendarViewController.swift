//
//  CalendarViewController.swift
//  Pupper
//
//  Created by Olivia Brown on 6/6/18.
//  Copyright © 2018 Olivia. All rights reserved.
//

import UIKit
import MessageUI

class CalendarViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var chosenDog: Dog?
    var selectedDateString = String()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var selectedBreed: String?
    
    @IBAction func submitApplicationButtonPressed(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = .short
        selectedDateString = formatter.string(from: datePicker.date)
        
        if chosenDog?.email != nil, chosenDog?.email != "" {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                emailErrorAlert()
            }
        }
        else {
            emailErrorAlert()
        }
    }
    
    private func emailErrorAlert() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        
        let title = "Unable to send email."
        let message = "Oh no! We couldn't send your email. Maybe try another contact method?"
        self.popOkAlertWith(title: title, message: message, from: self)
    }
    
    private func emailSuccessAlert() {
        let alertController = UIAlertController(title: "Email sent!", message: "The email to the shelter successfully sent!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([chosenDog!.email])
        mailComposerVC.setSubject("Adoption Inquiry")
        mailComposerVC.setMessageBody("Hello, I am looking to adopt a dog and came across \(chosenDog!.dogName). Can I come in to visit \(chosenDog!.dogName) and learn more about the adoption process on \(selectedDateString)? Thank you!", isHTML: false)
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        switch result {
        case .sent:
            emailSuccessAlert()
        default:
            emailErrorAlert()
        }
    }
}
