//
//  CalendarViewController.swift
//  Pupper
//
//  Created by Olivia on 2/19/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit
import MessageUI

class CalendarViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var chosenDog: Chosen?
    
    var selectedBreed: String?
    @IBOutlet weak var selectedDateButton: UIButton!
    @IBOutlet weak var submittedView: UIView!
    
    @IBAction func selectedDateButtonPressed(_ sender: Any) {
    selectedDateButton.setImage(UIImage(named: "chosen"), for: UIControlState.normal)
    }
    
    @IBAction func submitApplicationButtonPressed(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            print("error")
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["petsforyoushelter@gmail.com"])
        mailComposerVC.setSubject("Adoption")
        mailComposerVC.setMessageBody("Hello, \n I am looking to adopt a dog from the \(selectedBreed!) breed. The dog that I set my eye on is named \(chosenDog!.dogName). Can I come in to visit \(chosenDog!.dogName) and learn more about the adoption process on February 25? Thank you!", isHTML: false)
        
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        submittedView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedDateButton.setImage(UIImage(named: ""), for: UIControlState.normal)
        submittedView.isHidden = true
        submittedView.layer.cornerRadius = 15
      
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
