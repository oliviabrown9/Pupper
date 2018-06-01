//
//  IdealDogViewController.swift
//  Pupper
//
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit
import SwiftyJSON

class IdealDogViewController: UIViewController {
    var criteria: DogCriteria?
    var buttons = [UIButton]()

    @IBOutlet weak var dogSizeImage: UIImageView!
    
    @IBOutlet weak var baby: UIButton!
    @IBOutlet weak var young: UIButton!
    @IBOutlet weak var adult: UIButton!
    @IBOutlet weak var senior: UIButton!
    
    @IBOutlet weak var large: UIButton!
    @IBOutlet weak var medium: UIButton!
    @IBOutlet weak var small: UIButton!
    
    var matches: [String] = []
    var sizeOfDog: size?
    var selectedAge: age?
    
    private func select(label: UILabel?) {
        if let textLabel = label {
            textLabel.font = UIFont (name: "Avenir-Black", size: 12)
        }
    }
    
    private func deselect(label: UILabel?) {
        if let textLabel = label {
            textLabel.font = UIFont (name: "Avenir-Roman", size: 12)
        }
    }
    
    @IBAction func smallPressed(_ sender: Any) {
        select(label: small.titleLabel)
        deselect(label: medium.titleLabel)
        deselect(label: large.titleLabel)
        sizeOfDog = .small
        dogSizeImage.image = #imageLiteral(resourceName: "selected_small")
    }
    
    @IBAction func mediumPressed(_ sender: Any) {
        select(label: medium.titleLabel)
        deselect(label: small.titleLabel)
        deselect(label: large.titleLabel)
        sizeOfDog = .medium
        dogSizeImage.image = #imageLiteral(resourceName: "selected_medium")
    }
    
    @IBAction func largePressed(_ sender: Any) {
        select(label: large.titleLabel)
        deselect(label: small.titleLabel)
        deselect(label: medium.titleLabel)
        sizeOfDog = .large
        dogSizeImage.image = #imageLiteral(resourceName: "large_selected")
    }
    
    @IBAction func ageSelected(_ sender: UIButton) {
        let unselectedButtons = [baby, young, adult, senior].filter { $0 != sender }
        if let title = sender.titleLabel?.text?.lowercased() {
            select(label: sender.titleLabel)
            for button in unselectedButtons {
                deselect(label: button?.titleLabel)
            }
            selectedAge = age(rawValue: title)
        }
    }
    
    
    

    
    func findDogBreeds(dogBreed: DogCriteria) -> [Dog]{
        var dogs: [Dog] = []
        
        if let path = Bundle.main.path(forResource: "dogs", ofType: "json") {
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                if jsonObj != JSON.null {
                    for dog in jsonObj["breeds"] {
                        let breed = Dog(name: dog.1["name"].string! , description: dog.1["description"].string!)
                        dogs.append(breed)
                    }
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        return dogs
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navVC = segue.destination as? UINavigationController
        
        let destination = navVC?.viewControllers.first as! FindDogsViewController
        if let dogBreed = criteria {
            dogBreed.age = selectedAge!
            destination.dogs = findDogBreeds(dogBreed: dogBreed)
            destination.dogBreed = dogBreed
        }
    }

}
