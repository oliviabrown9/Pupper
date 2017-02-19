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
        medium.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        medium.titleLabel?.textColor = .black
        large.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        large.titleLabel?.textColor = .black
        medium.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        small.titleLabel!.textColor = .blue
        sizeOfDog = .small
    }
    
    @IBAction func mediumPressed(_ sender: Any) {
        medium.titleLabel!.font = UIFont (name: "Avenir-Black", size: 12)
        medium.titleLabel!.textColor = .blue
        small.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        small.titleLabel?.textColor = .black
        large.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        large.titleLabel?.textColor = .black
        sizeOfDog = .medium
    }
    
    @IBAction func largePressed(_ sender: Any) {
        small.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        small.titleLabel?.textColor = .black
        medium.titleLabel!.font = UIFont (name: "Avenir-Roman", size: 12)
        medium.titleLabel?.textColor = .black
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
    @IBAction func getMatchesButtonPressed(_ sender: Any) {
        
        if let dogBreed = dogBreed {
            dogBreed.age = age!
            dogBreed.sizeOfDog = sizeOfDog!
            
            
        }
    }

    
    func findDogBreeds(dogBreed: DogPreference) -> [String]{
        // MARK: Dog Types
        var matches: [String] = []
        let smallDogs = ["Pomeranian", "Terrier", "Spaniel", "Bulldog", "Pug", "Shiz Tsu"]
        let mediumDogs = ["Beagle", "Cattle Dog", "Collie", "Poodle", "Whippet", "Schnauzer"]
        let bigDogs = ["Mountain Dog", "Laborador", "Saint Bernard", "Greyhound", "Husky" ]
        
        // MARK: Setting
        
        let apartmentDogs = smallDogs + mediumDogs
        let houseDogs = mediumDogs + bigDogs
        
        let dogsForKids = ["Golden Retriever", "Setter", "Daschund", "Pointer", "Bloodhound", "Foxhound"]
        let dogsForDogs = ["Maltese","Corgi","Sheepdog","Bischon Friese", "Newfoundland", "Boxer"]
        
        let lazyDogs = ["Basset Hound", "Chihuahua", "Pug", "Bulldog", "Cockapoo", "Shar Pei",]
        let activeDogs = ["Doberman", "Dalmation", "Great Dane", "Weimaraner", "Rottweiler", "Xoloitzcuintle" ]

        
        if dogBreed.homeType == .apartment {
            matches = lazyDogs
        }
        else {
            if dogBreed.hasChild {
                matches = dogsForKids
            } else if dogBreed.personType == .walk {
                matches = mediumDogs
            } else {
                matches = activeDogs
            }
        }
        
        return matches
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! BreedViewController
        if let dogBreed = dogBreed {
            dogBreed.age = age!
            dogBreed.sizeOfDog = sizeOfDog!
            destination.dogBreed = dogBreed
//            destination.matches = findDogBreeds(dogBreed)
        }
    }

}
