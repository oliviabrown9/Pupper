//
//  HomeViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var dogBreed: DogPreference?
    
    @IBAction func unwindToSelectDog(segue: UIStoryboardSegue) {}
    
    var homeType: homeType?
    
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var homeImageView: UIImageView!
    @IBAction func houseButtonPressed(_ sender: Any) {
        homeImageView.image = UIImage(named: "selected home")
        cityImageView.image = UIImage(named: "unselected city")
        
        houseButton.setImage(UIImage(named: "selected"), for: UIControlState.normal)
        cityButton.setImage(UIImage(named: "unselected"), for: UIControlState.normal)
        homeType = .house
    }
    
    @IBAction func cityButtonPressed(_ sender: Any) {
        homeImageView.image = UIImage(named: "unselected house")
        cityImageView.image = UIImage(named: "selected city")

        houseButton.setImage(UIImage(named: "unselected"), for: UIControlState.normal)
        cityButton.setImage(UIImage(named: "selected"), for: UIControlState.normal)
        homeType = .apartment
    }
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var houseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! FamilyViewController
        if let dogBreed = self.dogBreed {
            dogBreed.homeType = homeType!
            destination.dogBreed = dogBreed
        }
    }

}
