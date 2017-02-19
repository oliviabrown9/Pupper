//
//  IdealDogViewController.swift
//  Pupper
//
//  Created by Miriam Hendler on 2/18/17.
//  Copyright © 2017 Olivia. All rights reserved.
//

import UIKit

class IdealDogViewController: UIViewController {
    var dogBreed : DogPreference?
    
    @IBOutlet weak var young: UIButton!
    @IBOutlet weak var adult: UIButton!
    @IBOutlet weak var senior: UIButton!
    @IBOutlet weak var puppy: UIButton!
    
    @IBOutlet weak var hair: UIButton!
    @IBOutlet weak var hypo: UIButton!
    
    @IBOutlet weak var large: UIButton!
    @IBOutlet weak var medium: UIButton!
    @IBOutlet weak var small: UIButton!
    
    var sizeOfDog: size?
    var age: age?
    @IBAction func smallPressed(_ sender: Any) {
        print("small button presssed")
        small.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        small.titleLabel!.textColor = .blue
        sizeOfDog = .small
    }
    
    @IBAction func mediumPressed(_ sender: Any) {
        medium.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        medium.titleLabel!.textColor = .blue
        sizeOfDog = .medium
    }
    
    @IBAction func largePressed(_ sender: Any) {
        large.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        large.titleLabel!.textColor = .blue
        sizeOfDog = .large
    }
    
    @IBAction func puppyPressed(_ sender: Any) {
        puppy.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        puppy.titleLabel!.textColor = .blue
        age = .puppy
    }
    
    @IBAction func youngPressed(_ sender: Any) {
        young.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        young.titleLabel!.textColor = .blue
        age = .young
    }
    
    @IBAction func adultPressed(_ sender: Any) {
        adult.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        adult.titleLabel!.textColor = .blue
        age = .adult
    }
    
    @IBAction func seniorPressed(_ sender: Any) {
        senior.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        senior.titleLabel!.textColor = .blue
        age = .senior
    }
    
    @IBAction func hypoPressed(_ sender: Any) {
        hypo.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        hypo.titleLabel!.textColor = .blue
    }
    
    @IBAction func hairPressed(_ sender: Any) {
        hair.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        hair.titleLabel!.textColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! BreedViewController
        if let dogBreed = dogBreed {
            dogBreed.age = age!
            dogBreed.sizeOfDog = sizeOfDog!
            destination.dogBreed = dogBreed
        }
    }

}
