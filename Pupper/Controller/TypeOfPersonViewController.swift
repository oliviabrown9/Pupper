//
//  TypeOfPersonViewController.swift
//  Pupper
//
//  Created by Miriam Hendler on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit

class TypeOfPersonViewController: UIViewController {

    var dogBreed: DogPreference?
    
    @IBOutlet weak var couchButton: UIButton!
    @IBOutlet weak var adventureButton: UIButton!
    @IBOutlet weak var walkButton: UIButton!
    var personType: personType?
    
    @IBAction func couchButtonPressed(_ sender: Any) {
        typeImageVIew.image = UIImage(named: "couch")
        
        couchButton.setImage(UIImage(named: "selected"), for: UIControlState.normal)
        walkButton.setImage(UIImage(named: "unselected"), for: UIControlState.normal)
        adventureButton.setImage(UIImage(named: "unselected"), for: UIControlState.normal)
        
        personType = .couch
    }
    
    @IBAction func walkButtonPressed(_ sender: Any) {
        typeImageVIew.image = UIImage(named: "walk")
        
        couchButton.setImage(UIImage(named: "unselected"), for: UIControlState.normal)
        walkButton.setImage(UIImage(named: "selected"), for: UIControlState.normal)
        adventureButton.setImage(UIImage(named: "unselected"), for: UIControlState.normal)
        
        personType = .walk
    }
    
    @IBAction func adventureButtonPressed(_ sender: Any) {
        typeImageVIew.image = UIImage(named: "adventure")
        
        couchButton.setImage(UIImage(named: "unselected"), for: UIControlState.normal)
        walkButton.setImage(UIImage(named: "unselected"), for: UIControlState.normal)
        adventureButton.setImage(UIImage(named: "selected"), for: UIControlState.normal)
        
        personType = .adventure
    }
    
    @IBOutlet weak var typeImageVIew: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        couchButton.setImage(UIImage(named: "selected"), for: UIControlState.normal)
        dogBreed?.personType = .couch
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! NoiseViewController
        
        if let dogBreed = dogBreed {
            dogBreed.personType = personType!
            destination.dogBreed = dogBreed
        }
    }

}
