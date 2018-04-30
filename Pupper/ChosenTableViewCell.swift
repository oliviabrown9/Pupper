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
    
    var chosenDog: Chosen?
    var tableViewController: SelectDogTableViewController? = nil
    
    @IBOutlet weak var blurImageViewTwo: UIImageView!
    @IBOutlet weak var blurImageViewOne: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBAction func phoneButtonPressed(_ sender: Any) {
        guard let number = URL(string: "telprompt://" + "\(chosenDog!.phone)") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    @IBAction func mailButtonPressed(_ sender: Any) {
    
//        tableViewController!.sendEmail()
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
        // Initialization code
        adoptMeButton.layer.cornerRadius = 15
        adoptMeButton.layer.borderWidth = 1
        adoptMeButton.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
