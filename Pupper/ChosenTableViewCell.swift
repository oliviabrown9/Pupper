//
//  ChosenTableViewCell.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import MessageUI

class ChosenTableViewCell: UITableViewCell {
    
    @IBAction func unwindToSelectDog(segue: UIStoryboardSegue) {}
    
    var chosenDog: Dog?
    var tableViewController: SelectDogTableViewController? = nil
    
    @IBOutlet weak var blurImageViewTwo: UIImageView!
    @IBOutlet weak var blurImageViewOne: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBAction func phoneButtonPressed(_ sender: Any) {
        if let phoneNumber = chosenDog?.phone, let number = URL(string: "telprompt://" + phoneNumber) {
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }
        else {
            let alertController = UIAlertController(title: "Phone number unavailable.", message: "Unforuntately, we do not have the phone number. Please try another contact method.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okayAction)
            self.tableViewController?.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        tableViewController?.shareDog()
    }

    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeInShelterLabel: UILabel!
    
    var expanded: Bool = false
    @IBOutlet weak var houseTrainedImageVIew: UIImageView!
    @IBOutlet weak var hasShotsImageView: UIImageView!
    
    @IBOutlet weak var adoptMeButton: UIButton!
    @IBAction func adoptMeButtonPressed(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adoptMeButton.layer.cornerRadius = 15
        adoptMeButton.layer.borderWidth = 1
        adoptMeButton.layer.borderColor = UIColor.white.cgColor
    }

}
