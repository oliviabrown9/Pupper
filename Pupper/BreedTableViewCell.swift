//
//  BreedTableViewCell.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class BreedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var breedPhoto: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    var tableViewController: FindDogsViewController? = nil
    var expanded:Bool = false
    
    @IBAction func selectBreedPressed(_ sender: Any) {
        if tableViewController != nil {
            tableViewController!.selectedBreed = breedLabel.text
        }
    }
    
}
