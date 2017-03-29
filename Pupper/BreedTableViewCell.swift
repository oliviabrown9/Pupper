//
//  BreedTableViewCell.swift
//  Pupper
//
//  Created by Olivia on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit

class BreedTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var breedPhoto: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var breedDescript: UILabel!
    var tableViewController: FindDogsViewController? = nil
    var expanded:Bool = false
    
    @IBAction func selectBreedPressed(_ sender: Any) {
        if tableViewController != nil {
        tableViewController!.selectedBreed = breedLabel.text
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
