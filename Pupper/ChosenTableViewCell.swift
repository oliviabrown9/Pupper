//
//  ChosenTableViewCell.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class ChosenTableViewCell: UITableViewCell {
    
    var chosenDog: Dog?
    var tableViewController: SelectDogTableViewController? = nil
    var expanded: Bool = false
    
    @IBOutlet weak var blurImageViewTwo: UIImageView!
    @IBOutlet weak var blurImageViewOne: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBAction private func phoneButtonPressed(_ sender: Any) {
        if let phoneNumber = chosenDog?.phone, phoneNumber != "", let number = URL(string: "telprompt://" + phoneNumber) {
            phoneAlertAction(withNumber: number)
        }
        else {
            let title = "Phone number unavailable."
            let message = "Unfortunately, we do not have the phone number. Please try another contact method."
            if let controller = self.tableViewController {
                controller.presentOkAlertWith(title: title, message: message, from: controller)
            }
        }
    }
    
    @IBAction private func emailButtonPressed(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    @IBAction private func shareButtonPressed(_ sender: UIButton) {
        tableViewController?.shareDog()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        styleContactButton(button: emailButton)
        styleContactButton(button: phoneButton)
    }
    
    private func styleContactButton(button: UIButton) {
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    private func phoneAlertAction(withNumber number: URL) {
        let actionSheetController = UIAlertController(title: "Select", message: nil, preferredStyle: .actionSheet)
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheetController.addAction(cancelActionButton)
        let callActionButton = UIAlertAction(title: "Call", style: .default) { _ in
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }
        let textActionButton = UIAlertAction(title: "Text", style: .default) { _ in
            if let messageComposeVC = self.tableViewController?.configuredMessageComposeViewController() {
                self.tableViewController?.present(messageComposeVC, animated: true, completion: nil)
            }
        }
        actionSheetController.addAction(callActionButton)
        actionSheetController.addAction(textActionButton)
        self.tableViewController?.present(actionSheetController, animated: true, completion: nil)
    }
}
