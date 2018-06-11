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
    @IBOutlet weak var adoptMeButton: UIButton!
    
    @IBAction private func phoneButtonPressed(_ sender: Any) {
        if let phoneNumber = chosenDog?.phone, phoneNumber != "", let number = URL(string: "telprompt://" + phoneNumber) {
            tableViewController?.phoneAlertAction(withNumber: number)
        }
        else {
            let title = "Phone number unavailable."
            let message = "Unforuntately, we do not have the phone number. Please try another contact method."
            if let controller = self.tableViewController {
                controller.presentOkAlertWith(title: title, message: message, from: controller)
            }
        }
    }
    
    @IBAction private func adoptPressed(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    @IBAction private func shareButtonPressed(_ sender: UIButton) {
        tableViewController?.shareDog()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        adoptMeButton.layer.cornerRadius = 15
        adoptMeButton.layer.borderWidth = 1
        adoptMeButton.layer.borderColor = UIColor.white.cgColor
    }
}
