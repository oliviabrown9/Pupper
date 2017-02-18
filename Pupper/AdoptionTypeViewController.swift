//
//  AdoptionTypeViewController.swift
//  Pupper
//
//  Created by Olivia on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit

class AdoptionTypeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var adoptButton: UIButton!
    @IBOutlet weak var fosterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: Button Settings
        adoptButton.layer.cornerRadius = 15
        fosterButton.layer.cornerRadius = 15
    }


   

}
