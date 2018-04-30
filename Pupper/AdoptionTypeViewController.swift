//
//  AdoptionTypeViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
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
