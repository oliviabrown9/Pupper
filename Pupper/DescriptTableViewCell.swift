//
//  DescriptTableViewCell.swift
//  Pupper
//
//  Created by Olivia on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit

class DescriptTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptLabel: UILabel!
    
    @IBAction func selectBreedButtonPressed(_ sender: Any) {
        print("did press")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
