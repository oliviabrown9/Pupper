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
    
    @IBOutlet weak var breedPhoto: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
